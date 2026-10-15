# Ferienkasse – offlinefähige iPhone-Web-App (PWA)

## Enthalten
- Mehrere Reisen und beliebig viele Teilnehmer (neue Reise beginnt mit fünf Personen)
- Ausgaben mit Datum, Zahler, Betrag, Währung und beliebiger Teilnehmerauswahl
- Gleichmässige Aufteilung mit centgenauer Resteverteilung
- Manuell festgelegte Wechselkurse (1 Fremdwährung = X Einheiten Abrechnungswährung), bei jeder Ausgabe eingefroren
- Schlussabrechnung mit vorgeschlagenen Überweisungen
- Druckansicht für PDF: im iPhone-Druckdialog die Vorschau aufziehen und über „Teilen“ als PDF sichern
- JSON-Backup und Wiederherstellung aller Reisen
- Speicherung ausschliesslich im lokalen Browser (localStorage)
- Offline-Nutzung nach dem ersten erfolgreichen Online-Laden dank Service Worker

## Ohne Mac bereitstellen – GitHub Pages (Windows)
1. ZIP-Datei entpacken.
2. Auf github.com ein kostenloses Konto anlegen (falls noch keines vorhanden).
3. Neues Repository erstellen, z. B. `ferienkasse`, **Public** auswählen. Achtung: Die hochgeladenen Programmdateien sind öffentlich, deine persönlichen Ausgaben werden nicht hochgeladen.
4. Alle Dateien aus `ferienkasse-pwa` einschliesslich `icons` in die oberste Ebene des Repositorys hochladen (Add file → Upload files → Commit changes).
5. Unter Settings → Pages → Build and deployment → Deploy from a branch, Branch `main`, Folder `/(root)` auswählen und speichern.
6. Die angezeigte HTTPS-Adresse im Safari auf dem iPhone öffnen. Warte, bis die App geladen ist.
7. In Safari „Teilen“ → „Zum Home-Bildschirm“ → „Hinzufügen“ wählen.
8. Die App vom Home-Bildschirm einmal bei bestehender Internetverbindung öffnen, danach funktioniert sie auch offline.

Alternativ kann jeder statische HTTPS-Host verwendet werden (z. B. Netlify). Ein lokaler Windows-Dateipfad `file://` genügt nicht für die PWA-Installation.

## PDF auf dem iPhone
Abrechnung → „PDF erstellen / drucken“ → im Druckdialog die Dokumentvorschau mit zwei Fingern vergrössern → Teilen → „In Dateien sichern“. Der Ablauf kann je nach iOS-Version leicht variieren.

## Wichtige Hinweise
- Die Daten sind **nicht** auf GitHub Pages gespeichert; sie verbleiben auf deinem iPhone im lokalen Website-Speicher.
- Safari-Daten löschen, private Tabs oder ein Geräteverlust können die Daten entfernen. **Regelmässig JSON-Backup in Dateien/iCloud Drive speichern.**
- Ein anderer Browser oder eine andere Domain hat einen eigenen Datenspeicher.
- Wechselkurse werden nicht automatisch abgerufen. Bei Kursänderungen bleibt der historische Kurs der bestehenden Ausgabe unverändert.
- Für die spätere Änderung der Abrechnungswährung ist eine neue Reise vorgesehen.
- Ein Export ist kein verschlüsseltes Backup; vertrauliche Daten sicher aufbewahren.
- Die Anwendung wurde syntaktisch geprüft, jedoch nicht auf einem realen iPhone getestet.
