# Ändringar
## Generell checklista för ändringar
Om du ska göra några ändringar på servern är det jättebra att kolla att du inte glömt något. Generellt sätt är de saker som bör hållas uppdaterade:
- Docker Compose-filen
- nginx.conf
- .env
- .gitignore
- Github-repot för Fysikmotorn
- Github-repon för projekten
- Backupskript
- Nedladdningsskript
- Protect-skriptet
- Användare
- Fysikmotorns dokumentation som du nu läser!

Se till att dessa alltid är uppdaterade, FRAMFÖRALLT innan nästa Webmaster börjar. Det må vara en del saker att ha koll på, men är mycket bättre än om saker sprids vilt.

## Lägga till ett nytt projekt
Om du ska lägga till ett nytt projekt vill du:
- Kolla att alla relevanta saker byggs på Github och publiceras som en release, eller Docker Container
- Skapa en användare för projektet
- Skapa en symlink till relevant mapp från services mappen
- Lägg till version under .env-filen
- Om static files genereras:
    - Skapa ett nedladdningsskript som laddar ner dessa
    - Lägga till relevant mapp under volumes till nginx
- Om en Docker container används
    - Uppdatera Docker Compose-filen med containern
    - Konfigurera allt kopplat till den i Docker Compose-filen
    - Lägga till regler för när nginx ska skicka vidare till containern i nginx.conf
- Om data sparas
    - Skapa ett backupskript
    - Om datan är känslig, se till att den skyddas i både backupskript och protect-skriptet.
- Starta om Docker Compose med `docker compose down` och `docker compose up`
- Testa att allt fungerar, annars gå tillbaka.
- Uppdatera Fysikmotorns dokumentation
- Uppdatera repot för Fysikmotorn med allt detta!

## Ta bort
Se till att allt från den generella checklistan stämmer. Se även till att helt ta bort mappar och konton kopplade till projekt som inte längre finns. Annars blir de förvirrande år senare.
