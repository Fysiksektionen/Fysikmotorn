# För alla
**Om du inte är Webmaster är detta den enda dokumentationsfil som du behöver kolla på**.

## Inloggning
Om du jobbar på något projekt på Fysikmotorn så har du en användare med samma namn som ditt kth-id. Du loggar in med
```
ssh kthid@f.kth.se
```
Om du inte har lagts till som användare, kontakta Webmaster.

## Gemensamma scripts
Navigera till
```
cd /fysikmotorn/project-ops/
```
Här finns gemensamma scripts för olika projekt. Ni projektmedlemmar har tillgång till att köra *specifika kommandon* utan att behöva ange lösenord. För dessa behöver du känner till namnet på den relevanta containern, som till exempel kan läsas i [`compose.yaml`](../compose.yaml).

Tillgängliga skripts är
```
sudo ./exec.sh <namn>
```
som öppnar ett shell i containern.
```
sudo ./logs.sh <namn>
```
som visar Dockers loggar i din container.
```
sudo ./start.sh <namn>
```
som startar, och tillämpar eventuella ändringar av version, din container. Denna kan köras även om containern redan är aktiv för att uppdatera version.
```
sudo ./stop.sh <namn>
```
som stoppar din container.

## Projektmappar
Varje projekt har en egen mapp under `project-ops`. Här finns en fil `.env` som du kan redigera, till exempel genom `nano .env` eller `vim .env`, för att ändra vilken version som containern ska använda. Versionsnamnet motsvarar namnet på tag:en som du gjorde i projektets GitHub-repo.
En del projekt har även ett script som kan köras genom specifikt
```
sudo ./download_<namn>.sh
```
som laddar ner eventuella statiska filer tillhörande versionen specificerad i `.env`.
