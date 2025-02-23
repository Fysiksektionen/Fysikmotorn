# Startup
En av fördelarna med den nya serverarkitekturen är att det är lätt att installera på olika maskiner! Det gör att man kan ha en lokal kopia för att pröva saker på innan man råkar krascha hemsidan. Det innebär också att det är relativt lätt att migrera server om så skulle behövas.

Jag rekommenderar att man som ny Webmaster försöker att få igång en lokal kopia. Det är användbart eftersom man har en egen version att pröva på, man får bättre förståelse för hur saker hänger ihop och man vet att det inte finns något man kan råka göra som man inte kan rätta till.

Stegen:
- Du behöver en installation av Linux, för att de flesta av skripten ska fungera. Det går säkert med Windows också, men kan kräva en del pillande.
- Om du migrerar till en faktisk server:
    - Skapa användare, en för dig med root access, och även för andra som ska ha. 
- Installera och konfigurera [programmen som används](allmänt#program-på-servern).
- Klona Fysikmotorns repo som root till `/fysikmotorn` eller annan bra plats.
- Kör alla nedladdningsskripten för att ladda ner static files (se [här](användning#nedladdningsskript))
- Kör alla backupskripts för att få alla data (se [här](användning#backups)). Se till att backups är nya.
- Om du kör lokalt, eller inte vill flytta domänerna till nya servern, länka om domäner genom att till exempel lägga till följande i `/etc/hosts`:
```
127.0.0.1       f.kth.se
127.0.0.1       fysikalen.se
127.0.0.1       ffusion.se
```
- [Starta upp servern](användning#att-starta)!
- Klart! Testa allt och förbättra guiden med dina nya insikter.