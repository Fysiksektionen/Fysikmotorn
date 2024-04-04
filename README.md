# Fysikmotorn
OBS! Det här är första varianten av README filen. Här har jag fyllt med information, men inte än hunnit göra den helt läslig.

Välkommen till Fysikmotorn, Fysiksektionens alldeles egna server! Här är möjligheterna oändliga, friheterna enorma och ansvaret påtagligt! Det är denna server som F.devs olika projekt och sektionens hemsidor kallar hem.

Tillgång till servern är ett privilegium som främst ges till sektionens Webmaster, och sedan delas ut till de som kan hjälpa denne i sina uppdrag. Typiskt sett är det Kvackare, och F.devare som arbetar på ett aktivt projekt på servern, som får varierande tillgång.

Det här dokumentet är en kort överblick, guide och beskrivning av den nya Fysikmotorn. Använd för att få en bild, men sedan behövs nog både Stack Overflow och experiment för att förstå detta hopkok.

## Motivering
När Fysikmotorn först införskaffades, lades olika projekt och kodsnuttar dit på de sätt som var mest naturliga i stunden. Det här fungerar till viss grad, men när projekt blir gamla, personerna som skrev dem lämnat, och någonting går sönder, kan det vara ett massivt arbete att få upp det igen. Vissa försök gjordes att förbättra situationen, och bland annat blev Dockeriserade projekt standard. Mycket gammalt var dock kvar, och saker hängde inte riktigt ihop.

Därav det här projektet. Det här repot innehåller allt som behövs för den nya Fysikmotorn. Alla projekt körs i Docker containers, alla filer och containrar byggs på Github, och både nedladdning av projekt och backups är mer eller mindre automatiserat! Det har varit ett rejält arbete att få ihop detta, men Webmaster 2024, ansåg det vara dags för en renovering.

För att det här projektet ska fungera, att saker inte ska gå tillbaka till kaos, krävs det att ni tar hand om det. Om ni lägger till ett projekt, uppdaterar något, eller på annat sätt ändrar, var god och uppdatera allt. Om små saker slutar fungera blir det en pina för de som kommer efter senare, och då slutar det uppehållas. Det betyder dock inte att ändringar är dåliga, saker får gärna ändras på så länge man har förståelse för hur projektet hänger ihop. Även de delar som backup processen, och nerladdning har definitivt förbättringspotential!

## Struktur
Servern är strukturerad runt en Docker Compose fil. Denna innehåller information för Docker om hur man kör alla de olika projekten och hur de ska sättas ihop. I och med att det är just Docker, betyder det också att all kod körs på samma sätt oavsett dator.

För att bygga dessa Docker containrar, används Github Actions i varje projekts Github sida. De bygger en container som enkelt kan laddas ner av Docker Compose filen. Exakt vilken version håller dessutom .env filen koll på!

I Docker körs alla projekten, men också en nginx server. Denna ansvarar för att ta emot all datatrafik som servern får och skicka vidare den till rätt projekt. DESSUTOM, levererar den filer. Alla filer den kan se (titta i Docker Compose filen, under nginx: volumes), kan nås genom att gå in på https://domän.se/väg/till/filen, och nginx ser till att leverera den! De små hemsideprojekten till exempel, behöver ingen kod som körs på servern utom bara att HTML och Javascript filerna levereras, vilket nginx tar hand om. Om du inte är bekant med detta, sök gärna upp om "static files". Notera också att nginx här är konfigurerad att allt som den inte vet var det ska, skickas vidare till Wordpress.

Likt hur Docker containrarna byggs med Github Actions, byggs även static files till många projekt med Github Actions. Dessa blir en release som sedan kan laddas ner med hjälp av nerladdnings skripten i "scripts" mappen. Underhåll dessa! Det gör att man inte måste undra vilken version av vardera paket som används för att bygga ett projekt.

Tillsammans gör detta att alla projekt hanteras på väldigt liknande sätt, och att uppstart, ändringar och flyttar knappt skiljer sig mellan projekt. Förhoppningen är att det underlättar Webmasterns arbetsbörda, och gör det lättare att bevara gamla projekt.

## Nuvarande projekten
De projekt som just nu finns på servern är:

### Nginx
Detta är den webbserver som bestämmer exakt vad som ska ske med serverns datatrafik. I nginx.conf filen konfigureras detta, men en överblick är: 
- Om en domän står nämnd där, skickas trafiken vidare som likt specificerat.
- Annars, kollar den om filen som sökvägen motsvarar finns, då skickas den filen dit! (Till exempel att https://f.kth.se/ett/exempel.html gör att nginx svarar med filen under /f.kth.se/ett/exempel.html i Docker containern).
- I sista fall, skickas det vidare till Wordpress motsvarande domänen.

Notera att om du vill att vissa filer ska finnas tillgängliga, till exempel en index.html fil, är det bara att lägga till den under en mapp i services, och skapa en mount bind i Compose filen (under volumes vid nginx). Det finns redan många exempel där att utgå ifrån.

Det kan vara bra att läsa på lite grann kring hur nginx fungerar.

### Wordpress hemsidor
Sektionen underhåller vid skrivande tillfälle 3 stycken Wordpress sidor. Dessa används för att enkelt kommunicera med omvärlden, och innehållshanteringen av dessa är utspridd på sektionen, där f.kth.se hittills faller på Webmaster.

Sidornas Wordpress version behöver uppdateras ibland, så gör gärna det! Det sker genom att först uppdatera via admin konsolen, och sedan ändra versionen i den centrala Docker Compose filen. Kom ihåg att ta en backup innan!

Notera att det inte finns ett Github repo för dessa, utom all information är i backups:en av historiska skäl.

### Kons Count
Kons Count är en hemsida som är till för att räkna antalet person i konsulatet under pubar.

Den har två delar, en frontend och backend. Frontend:en är ett React projekt och byggs på Github, så att filerna sedan kan levereras med hjälp av nginx. För att underlänkar (som counter/admin) ska fungera, behövs också att nginx är konfigurerad att skicka all trafik som börjar med counter till dess index.html sida.

Backend:en är en liten server i en Docker container som också byggs på Github. Notera att servern har en konfigurationsfil (.env) som inte är på Github, och en autentiseringsfil (service_account_auth_file.json) som kommer från Google.

### Nämndkompassen
Nämndkompassen är en kul liten hemsida där man efter att ha svarat på några frågor, får veta vilken nämnd man borde gå med i. Detta projekt är enkla html sidor, och en release görs därför manuellt och laddas ner med nedladdningsskriptet. 

Notera att ingen kod exekveras lokalt, utom allt jobb sköts av nginx. För att detta ska ske, måste dock nginx ha tillgång till filerna via mount binds definierade i Docker Compose filen.

### Arcade
Arcade är en samling spel som har gjorts på sektionen med åren. Notera att vår installation här, har två delar.

Det finns en homepage som är skriven i React och byggs på Github, och sedan finns det några spel som är skrivna i html och Javascript och release:as manuellt. Ingen av dessa kräver att kod körs lokalt, utan behöver bara att filerna levereras, vilket sköts av nginx.

Båda installeras samtidigt med nedladdningsskriptet för Arcade.

### Misc
Det är inte ett projekt, utom en samling filer som ska finnas tillgängliga ändå. 

Just nu innehåller det en fil som behövde finnas tillgänglig för KTH:s autentisering tjänst. Det är oklart om den fortfarande behöver vara tillgänglig, men får vara det tills vidare (men ta gärna bort typ 2026). Det är även ett bra exempel om hur enskilda filer kan finnas tillgängliga på servern. Notera att den är tillagd under volumes i Docker Compose filen.

## Nedladdningsskript
För att ladda ner projekten finns det nedladdningsskript i scripts mappen. Dessa är anpassade efter varje projekt, och för ett nytt projekt bör man kopiera och anpassa detta.

De kräver att det finns en Github release för projektet som antingen innehåller alla byggda filer (om så är relevant), eller källkoden (om bara den krävs). Kolla på de redan existerande projekten efter exempel.

OBS! Skripten måste köras med scripts som working directory, och det krävs oftast sudo.

## Backup
För att misstag ska kunna rättas till, och att saker inte ska försvinna, har servern även utrustats med backupskripts! Dessa förlitar sig på programmet rclone för att ladda upp projektens data (men inte hela projektet i och med att de finns på Github). Det kan sedan laddas ner igen lätt.

Dessa scripts är anpassade efter varje projekt, och måste anpassas för varje nytt.

Det är viktigt att dessa fungerar för att inte data ska försvinna, och för att man ska våga göra saker på Fysikmotorn. Om det fungerar, slipper man hantera servern som en porslinstaty och kan istället experimentera och ha kul!

OBS! Skripten måste köras med scripts som working directory, och det krävs oftast sudo.
OBS! Det krävs lite extra lagring för att genomföra en backup, 2GB är definitivt tillräckligt!
OBS! För att underlätta felsökande efter stora ändringar, laddas även .env, nginx.conf, och Docker Compose filen upp. Kolla i dessa ifall något gått sönder och du tror att det har omkonfigurerats, (de laddas dock inte ner i vanliga fall eftersom de påverkar mycket annat också).

## Säkerhet
Det finns vissa filer på servern som inte bör kunna ses av andra processer eller användare eftersom de är känsliga. I protect skriptet, samt i backup skripten, sköts att dessa inte kan ses av övriga användare, men de måste uppdateras om fler tillkommer.

En lista av dessa hemligheter är:
- SSL Certifikat - Används för att verifiera för webbläsare att vi verkligen är f.kth.se. De skulle annars kunna användas för att lossas vara f.kth.se och lura folk på lösenord.
- .env filer i Wordpress - Innehåller databas lösenord, och skulle kunna användas för att läsa eller ändra data på sektionens hemsidor (om man har tillgång till servern, men root privilegier).
- Mariadb mappar i Wordpress - Innehåller själva databaserna och skulle kunna användas för att läsa hemlig data på sektionens hemsidor.
- service_account_auth_file.json i kons-count - Innehåller API nycklar med begränsad tillgång till vårt Google Workspace.

Var försiktig med dessa filer, och generellt kring med filer som innehåller autentisering med mer. Eftersom få har tillgång till servern är det ingen katastrof om dessa skulle synas , men det är bra att undvika.

Om nya hemliga filer tillkommer, till exempel Swish koder, se till att backup och protect skriptet uppdateras för att reflektera detta.

## Certifikat
Certifikaten i services/nginx/certificates är till för att https ska fungera, och behöver ibland uppdateras. Planen är att det ska göras med hjälp av Certbot, men detta har inte än hunnit fixas :D

## Användare
Användare på servern är personliga och namngivna efter KTH id:n. Ägaren får tillgång till deras konto genom att deras publika SSH nyckel läggs till.

Det finns även en användare per projekt. Denna används sällan som användare, men mappen som tillhör den används för att spara saker som kan ändras inom projektet.

För att användare sedan ska få tillgång till dessa, läggs de till i den gruppen. Det finns oftast ingen anledning att ta bort en person från ett projekt de en gång haft tillgång till, utom de kan oftast fortsätta ha tillgång (undantag viktiga personuppgifter).

## Att starta
Det enda som krävs för att starta all tjänster är kommandot "docker compose up" (från mappen som innehåller Docker Compose filen). Det fungerar eftersom all kod som ska köras kontinuerligt, körs i Docker containrar konfigurerade i Docker Compose filen! Om du vill stänga ner är det istället "docker compose down" som gäller.

## Checklista för ändringar
Om du ska göra några ändringar på servern, är det jättebra att kolla att du inte glömt något. Generellt sätt är de saker som bör hållas uppdaterade:
- Docker Compose filen
- nginx.conf
- .env
- .gitignore
- Github repot för Fysikmotorn
- Github repon för projekten
- Backupskript
- Nedladdningsskript
- Protect skriptet
- Användare
- Den här guiden!

Se till att dessa alltid är uppdaterade, FRAMFÖRALLT innan nästa Webmaster börjar. Det må vara en del saker att ha koll på, men är mycket bättre än om saker sprids vilt.

Lite fler saker att tänka på (notera att detta inte är en komplett guide, utom en del Google lär krävas om du är obekant):

### Lägga till ett nytt projekt
Om du ska lägga till ett nytt projekt vill du:
- Kolla att alla relevanta saker byggs på Github och publiceras som en release, eller Docker Container
- Skapa en användare för projektet
- Skapa en symlink till relevant mapp från services mappen
- Lägg till version under .env filen
- Om static files genereras:
    - Skapa ett nedladdningsskript som laddar ner dessa
    - Lägga till relevant mapp under volumes till nginx
- Om en Docker container används
    - Uppdatera Docker Compose filen med containern
    - Konfigurera allt kopplat till den i Docker Compose filen
    - Lägga till regler för när nginx ska skicka vidare till containern i nginx.conf
- Om data sparas
    - Skapa ett backupskript
    - Om datan är känslig, se till att den skyddas i både backupskript och protect skriptet.
- Starta om Docker Compose med "docker compose down" och "docker compose up"
- Testa att allt fungerar, annars gå tillbaka.
- Uppdatera den här README filen om projektet
- Uppdatera repot för Fysikmotorn med allt detta!

### Justera
Kolla att allt från tidigare punkten stämmer.

### Ta bort
Se till att allt från tidigare stämmer. Se även till att helt ta bort mappar och konton kopplade till projekt som inte längre finns. Annars blir de förvirrande år senare.

### Ny användare
Om en person ska få tillgång till Fysikmotorn:
- Skapa ett konto
- Lägg till dem i grupper för de projekt de arbetar på (men inte fler)
- Om de är Webmaster, lägg till dem i sudo gruppen.

## Migrering eller Lokal installation
En av fördelarna med den nya server arkitekturen är att det är lätt att installera på olika maskiner! Det gör att man kan ha en lokal kopia för att pröva saker på, innan man råkar krascha hemsidan. Det innebär också att det är relativt lätt att migrera server om så skulle behövas.

Jag rekommenderar att man som ny Webmaster försöker att få igång en lokal kopia. Det är användbart eftersom man har en egen version att pröva på, man får bättre förståelse för hur saker hänger ihop, och man vet att det inte finns något man kan råka göra som man inte kan rätta till. Om du väl lyckats får du gärna uppdatera den här README:n för att påpeka saker du märkte missades i början.

Stegen:
- Du behöver en installation av Linux, för att de flesta av skripten ska fungera. Det går säkert med Windows också, men kan kräva en del pillande.
- Om du migrerar till en faktisk server:
    - Skapa användare, en för dig med root access, och även för andra som ska ha. Se även till att det finns användare för alla projekten, men själva server repot kan hamna under /Fysikmotorn eller liknande.
- Installera och konfigurera programmen som nämns under "Program på server"
- Ladda ner Fysikmotor repot under en egen användare.
- Skapa services mappen, och länka med symlänkar till de olika projekten
- Kör alla nedladdningsskripten för att ladda ner static files
- Kör alla backupskripts för att få alla data (se till att backups är nya)
- Om du kör lokalt, eller inte flytta länkarna till nya servern:
    - Länka om f.kth.se och övriga domäner till IP adressen för servern (/etc/hosts för Linux)
- Starta upp servern med docker compose up!
- Klart! Testa allt och förbättra guiden med dina nya insikter.

## Program på servern
OBS! På Ubuntu verkar snap inte fungera på grund av att den inte tillåter root enkelt, och apt-get har för gamla versioner. På vardera programs sida finns dock lämpliga installations instruktioner.

### Docker
Docker är ett program för att isolera program och ge en konsekvent miljö för dem att exekveras i. Docker är också betydligt mer resurs effektiv än en virtual machine.

Som nämnts används Docker för att köra de flesta program på servern. Det behöver alltså vara nedladdat på servern.

Om du inte redan är bekant med Docker, rekommenderar jag att söka på om det, samt Docker Compose!

### rclone
rclone är ett verktyg för att kopiera till och från olika fjärrfilsystem.

På Fysikmotorn används det för att sköta backups, då dessa blir uppladdade på sektionens Google Drive.

Det kräver ett projekt, vilket ägs av "Fysikmotorn" kontot (lösenord finns i Webmaster nyckelringen). Själva filerna läggs in i den delade enheten "Backup Fysikmotorn", som Webmaster också har tillgång till.

För att rclone ska fungera på en enhet måste de konfigureras, följ då guiderna:
https://rclone.org/drive/
https://rclone.org/drive/#making-your-own-client-id
och lägg till den delade driven "Backup Fysikmotorn" som "Drive".

Kontot och projektet finns som sagt redan, men koder kan behövas för en lokal installation.

### Tar
Tar är ett program som är förinstallerat på de flesta Linux datorer. Med det kan man skapa arkiv av filer, vilket används av både nedladdningsskript och backupskript vid ned och uppladdning.

### Git
För att projektet ska fungera behövs Git, både för att ladda ner det :D, men också för att 
det används av Githubs command line interface.

Notera att det används en Deploy Key för att ge servern tillgång till repot.

Om du gör ändringar på servern, så uppdatera Fysikmotor repot också!

Notera att .gitignore används för att inte fylla repot med de olika projekten eftersom dessa finns och uppdateras på separata Github sidor.

### Github
Github är tjänsten vi använder för att hosta våra Git repon. Där i används bland annat Github Actions för att bygga projekten som behöver byggas. Fortsätt med detta!

Dessutom används Github CLI för att kunna ladda ner releases enkelt. De används i nedladdningsskripten.

Vi använder github kontot kopplat till fysikmotorn@f.kth.se för att kunna logga in i Github CLI.


## Kontakt
Om du skulle behöva assistans med något, kan man alltid börja med att fråga Webmaster innan dig. Om det däremot skulle uppstå ett problem eller en fråga som handlar om själva server arkitekturen, går det alltid bra att kontakta Webmaster 2024 vars privata mejl finns i Webmaster testamentet.
