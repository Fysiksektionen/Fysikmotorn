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
Här finns gemensamma scripts för olika projekt. Ni projektmedlemmar har tillgång till att köra *specifika kommandon* utan att behöva ange lösenord. För dessa behöver du känna till namnet på den relevanta containern, som till exempel kan läsas i [`compose.yaml`](../compose.yaml).

Tillgängliga skripts är följande:

För att **öppna ett shell** i containern:
```
sudo ./exec.sh <namn>
```

För att **visa Dockers loggar**:
```
sudo ./logs.sh <namn>
```

För att **starta** din container och **tillämpa eventuella ändringar av version** (notera att denna kan köras även om containern redan är aktiv för att ändra version):
```
sudo ./start.sh <namn>
```

För att **stoppa** din container:
```
sudo ./stop.sh <namn>
```

## Ändra version
Varje projekt har en egen mapp under `project-ops`:
```
cd /fysikmotorn/project-ops/<namn>/
```
Här finns en fil `.env` som du kan redigera, till exempel genom 
```
nano .env
```
eller `vim .env` för att ändra vilken version som containern ska använda. Versionsnamnet motsvarar namnet på tag:en som du gjorde i projektets GitHub-repo.

## Statiska filer
En del projekt har även script under sin egna mapp i `project-ops` som **laddar ner statiska filer** tillhörande versionen specificerad i `.env`. Denna kan köras genom specifikt
```
sudo ./download_<namn>.sh
```
