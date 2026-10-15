# Supabase-Konfiguration (Ferienkasse 1.3)

Dieses Verzeichnis enthält die geplante Backend-Grundlage. Das Projekt ist noch NICHT mit Supabase verbunden.

1. Separates Supabase-Testprojekt anlegen.
2. Auth > Providers > Email: E-Mail-OTP aktivieren. Auth-Redirects für die spätere Test-URL erlauben.
3. `schema.sql` im SQL-Editor des Testprojekts ausführen und Policies prüfen.
4. Niemals `service_role` oder geheime Schlüssel ins Repository committen.
5. Vor Freigabe Einladungssystem, Belegspeicher, Realtime und RLS mit mindestens zwei Konten testen.

Die SQL-Grundlage implementiert bewusst noch keine Einladungsannahme und keine Offline-Synchronisation. Nicht produktiv einsetzen.
