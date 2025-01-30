# Användning

## Att starta
För att starta alla tjänster, navigera till mappen som innehåller [`compose.yaml`](../compose.yaml) och kör
```
docker compose up -d
```
Det fungerar eftersom all kod som ska köras kontinuerligt körs i Dockercontainrar konfigurerade i Docker Compose-filen! För att stänga ner, kör istället
```
docker compose down
```

# Backups
För att misstag ska kunna rättas till, och att saker inte ska försvinna, har servern även utrustats med backupskripts! Dessa förlitar sig på programmet `rclone` för att ladda upp projektens data (men inte hela projektet i och med att de finns på GitHub). Det kan sedan laddas ner igen lätt.

För att köra backupskript måste [`/scripts/`](../scripts/) sättas som working directory och körningen måste oftas ske som root user.
- För att **skapa en backup** för ett projekt, kör
```
./backup_<projektnamn> u
```
- För att **ladda ner en backup** för ett projekt, dvs. radera nuvarande filer och återställa dem enligt den senaste backupen, kör
```
./backup_<projektnamn> d
```
Argumenten `u` och `d` står för "upload" respektive "download".

Dessa scripts är anpassade efter varje projekt, och måste anpassas för varje nytt.

Det är viktigt att dessa fungerar för att inte data ska försvinna och för att man ska våga göra saker på Fysikmotorn. Om de fungerar slipper man hantera servern som en porslinstaty och kan istället experimentera och ha kul!

OBS! Det krävs lite extra lagring för att genomföra en backup, 2GB är definitivt tillräckligt!

OBS! För att underlätta felsökande efter stora ändringar, laddas även `.env`, `nginx.conf`, och Docker Compose-filen upp. Kolla i dessa ifall något gått sönder och du tror att de har omkonfigurerats (de laddas dock inte ner i vanliga fall eftersom de påverkar mycket annat också).

OBS! Notera att backupen inte följer symlinks om inte det är själva argumentet.
