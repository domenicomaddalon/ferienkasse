# Supabase-Testprojekt – nächste Schritte

Projekt-URL: `https://ilcwwuoryxuxztyaacgo.supabase.co/`

Der Publishable Key wird erst bei Integration des Auth-Clients eingebunden. Niemals Secret- oder Service-Role-Keys einchecken.

## Im Supabase-Dashboard prüfen
1. Authentication > Providers > Email: E-Mail-Anmeldung aktiviert.
2. Authentication > Email Templates > Magic Link: Für echte Einmalcode-Eingabe die Vorlage mit `{{ .Token }}` konfigurieren (anstelle eines reinen Links).
3. Authentication > URL Configuration: Site URL und erlaubte Redirect-URLs auf die später tatsächlich genutzte Test-Domain abstimmen. Der GitHub-Branch allein ist keine gehostete Vorschau.
4. SQL aus `supabase/schema.sql` ausschliesslich im separaten Testprojekt verwenden. Das Schema ist noch unvollständig und darf nicht produktiv eingesetzt werden.
5. Zwei separate Testkonten für Berechtigungsprüfungen vorsehen.

## Noch offen
- Sichere Mitgliederanlage und Einladung über RPC.
- Änderungen an owner_id/trip_id blockieren, Versionsprüfung und Audit-Log.
- Auth-Oberfläche, Realtime, Offline-Queue, Storage-RLS und Migration implementieren.
- Vor dem Test einer Cloud-Migration vollständiges lokales JSON-Backup erstellen.

Die produktive Version 1.2.1 auf `main` bleibt unverändert.
