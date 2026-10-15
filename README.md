# Ferienkasse PWA 1.1

## Installation / Update auf GitHub Pages
Alle Dateien aus diesem Ordner direkt ins Repository-Hauptverzeichnis hochladen und vorhandene Dateien ersetzen. Keine Unterordner-Ebene zusätzlich einfügen. GitHub Pages bleibt auf `main` / `(root)`. Auf dem iPhone die App nach der Veröffentlichung schliessen und neu öffnen; bei Bedarf in Safari die Website erneut laden.

## Daten bleiben erhalten
Die Daten liegen weiterhin unter dem **unveränderten** localStorage-Schlüssel `ferienkasse.pwa.v1`. Das Datenformat bleibt `version:1`, und die neue `payments`-Liste ist optional. Vor dem Update unbedingt JSON-Backup exportieren und ausserhalb des iPhones aufbewahren. Die gleiche URL und Safari-Home-Bildschirm-App verwenden. **Nicht** Safari-Website-Daten löschen, App entfernen oder die URL/Domain ändern, bevor das Backup gesichert und die Wiederherstellung getestet ist.

## Neue Funktionen
- Reise bearbeiten (Name, Datum), Teilnehmer und Ausgaben bearbeiten/löschen
- Individuelle Aufteilung in der Originalwährung; exakte Cent-Prüfung
- Zahlung als bezahlt markieren und rückgängig machen; Salden nach Zahlungen
- Kategorien und Balkendiagramm, automatischer Dunkelmodus
- Backup-Export/Import, Datenstrukturprüfung und PDF-Druckansicht inklusive bezahlter Überweisungen

## Testplan
1. Vor Update Backup aus Version 1.0 erstellen.
2. Update veröffentlichen und kontrollieren, ob bestehende Reise/Ausgaben vorhanden sind.
3. Ausgabe bearbeiten, individuellen Anteil testen, Kurs fixieren.
4. Überweisung als bezahlt markieren und rückgängig machen.
5. Backup exportieren, danach zur Probe auf einem **anderen Browser/Gerät** importieren (Import überschreibt alle Reisen).
6. PDF drucken, Offlinebetrieb testen.

Hinweis: Die App wurde nicht auf einem echten iPhone automatisiert getestet.
