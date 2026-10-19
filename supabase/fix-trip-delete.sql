-- Ferienkasse 1.3.1: Behebt das Löschen ganzer Reisen.
-- Einmal im SQL Editor des bestehenden Supabase-Projekts ausführen.
-- Ändert ausschliesslich Fremdschlüsselregeln, löscht selbst keine Daten.
-- Alle Verweise auf fk_people aus den drei abhängigen Tabellen werden
-- bei einer späteren Personen-/Reiselöschung automatisch mitgelöscht.
BEGIN;
DO $migration$
DECLARE
  fk record;
  definition text;
BEGIN
  FOR fk IN
    SELECT c.conname, c.conrelid, c.confdeltype,
           n.nspname AS schema_name, t.relname AS table_name
    FROM pg_constraint c
    JOIN pg_class t ON t.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = t.relnamespace
    WHERE c.contype = 'f'
      AND c.confrelid = 'public.fk_people'::regclass
      AND n.nspname = 'public'
      AND t.relname IN ('fk_expense_splits','fk_expenses','fk_settlements')
      AND c.confdeltype <> 'c'
  LOOP
    definition := pg_get_constraintdef(
      (SELECT oid FROM pg_constraint WHERE conrelid=fk.conrelid AND conname=fk.conname)
    );
    -- Diese drei Tabellen verwenden bisher NO ACTION; bei abweichender
    -- FK-Konfiguration abbrechen, statt unbemerkt Regeln zu verändern.
    IF definition ~ ' ON DELETE ' OR definition ~ ' ON UPDATE ' THEN
      RAISE EXCEPTION 'Fremdschlüssel % hat eine unerwartete Definition: %', fk.conname, definition;
    END IF;
    EXECUTE format('ALTER TABLE %I.%I DROP CONSTRAINT %I',fk.schema_name,fk.table_name,fk.conname);
    EXECUTE format('ALTER TABLE %I.%I ADD CONSTRAINT %I %s ON DELETE CASCADE',
      fk.schema_name,fk.table_name,fk.conname,definition);
  END LOOP;
END;
$migration$;
COMMIT;

-- Kontrolle: Erwartet werden ON DELETE CASCADE bei den Verweisen
-- fk_expense_splits -> fk_people,
-- fk_expenses -> fk_people,
-- fk_settlements -> fk_people.
SELECT conrelid::regclass AS tabelle, conname AS fremdschluessel,
       pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE contype='f' AND confrelid='public.fk_people'::regclass
  AND conrelid IN ('public.fk_expense_splits'::regclass,
                   'public.fk_expenses'::regclass,
                   'public.fk_settlements'::regclass)
ORDER BY 1,2;
