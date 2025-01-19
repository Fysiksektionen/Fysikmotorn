# Backups
För att misstag ska kunna rättas till, och att saker inte ska försvinna, har servern även utrustats med backupskripts! Dessa förlitar sig på programmet `rclone` för att ladda upp projektens data (men inte hela projektet i och med att de finns på GitHub). Det kan sedan laddas ner igen lätt.

Dessa scripts är anpassade efter varje projekt, och måste anpassas för varje nytt.

Det är viktigt att dessa fungerar för att inte data ska försvinna och för att man ska våga göra saker på Fysikmotorn. Om de fungerar slipper man hantera servern som en porslinstaty och kan istället experimentera och ha kul!

OBS! Skripten måste köras med `/scripts/` som working directory, och det krävs oftast sudo.

OBS! Det krävs lite extra lagring för att genomföra en backup, 2GB är definitivt tillräckligt!

OBS! För att underlätta felsökande efter stora ändringar, laddas även `.env`, `nginx.conf`, och Docker Compose-filen upp. Kolla i dessa ifall något gått sönder och du tror att de har omkonfigurerats (de laddas dock inte ner i vanliga fall eftersom de påverkar mycket annat också).

OBS! Notera att backupen inte följer symlinks om inte det är själva argumentet.