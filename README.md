# Ferienkasse PWA 1.2

## Neue Funktionen
- Eigene Kategorien pro Reise: hinzufügen, umbenennen (inklusive bestehender Ausgaben), löschen nur wenn unbenutzt
- Belegfotos zu Ausgaben: Foto wird im Browser auf maximal 1100 px verkleinert und als JPEG gespeichert
- Wechselkurse bei Internetverbindung manuell von https://frankfurter.dev/ abrufen (EZB-Referenzkurse); bereits gespeicherte Ausgaben behalten ihren Kurs
- Tagesstatistik, Zahlungen pro Person, optionales Reisebudget
- Excel-kompatibler CSV-Export mit UTF-8 BOM und Semikolon-Trennung

## Upgrade von 1.1 ohne Datenverlust
1. **Vorher** in 1.1 JSON-Backup exportieren und auf einem zweiten Gerät oder PC sicher ablegen. Die Wiederherstellung auf einem zweiten Gerät prüfen.
2. Dateien aus dem ZIP in das **bestehende** öffentliche GitHub-Repository `ferienkasse` im Hauptverzeichnis hochladen und bestehende Dateien ersetzen. Für einfaches Überschreiben eignet sich GitHub Desktop: Repository klonen, Dateien in lokalen Repo-Ordner kopieren, Änderungen committen und pushen.
3. GitHub Pages unverändert auf `main` und `/(root)` belassen. Warten, bis der Deploy erfolgreich ist.
4. Die **gleiche URL** und die vorhandene Home-Bildschirm-App nutzen. App schliessen und erneut öffnen; ggf. die Seite in Safari neu laden. **Keine Website-Daten löschen und die alte App nicht deinstallieren.**
5. Prüfen, ob bestehende Ausgaben und Zahlungen erhalten sind, und anschliessend Kategorie, Beleg, Kurse, Statistik, CSV und Backup testen.

Die App nutzt weiterhin den identischen localStorage-Schlüssel `ferienkasse.pwa.v1` und das Datenformat `version:1`. Fehlende Kategorien und Budgets alter Reisen werden mit Standardwerten behandelt. Neue Belegbilder sind Bestandteil des JSON-Backups. Lokaler Speicherplatz ist begrenzt: Bei vielen Fotos kann die Speicherung fehlschlagen; regelmässig Backups erstellen. **Nicht** den Speicher des Browsers löschen.

## Hinweise
- Der Wechselkursabruf benötigt Internet und sendet nur den Währungscode an den externen Dienst. Ohne Internet bleiben die manuell eingestellten Kurse verwendbar.
- CSV-Dateien lassen sich mit Excel öffnen und als XLSX speichern. Der Export selbst ist kein XLSX.
- Für PDF die iPhone-Druckfunktion nutzen.
- Die statischen Dateien können über GitHub Pages per HTTPS bereitgestellt werden; kein Servercode notwendig.
- Syntaxprüfung erfolgt; ein realer iPhone-Test ist noch nötig.