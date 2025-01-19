# Fysikmotorn
Välkommen till Fysikmotorn, Fysiksektionens alldeles egna server! Här är möjligheterna oändliga, friheterna enorma och ansvaret påtagligt! Det är denna server som F.devs olika projekt och sektionens hemsidor kallar hem.

Tillgång till servern är ett privilegium som främst ges till sektionens Webmaster, och sedan delas ut till de som kan hjälpa denne i sina uppdrag. Typiskt sett är det Kvackare, och F.devare som arbetar på ett aktivt projekt på servern, som får varierande tillgång.

Det här dokumentet är en kort överblick, guide och beskrivning av den nya Fysikmotorn. Använd för att få en bild, men sedan behövs nog både Stack Overflow och experiment för att förstå detta hopkok.

## Struktur
Servern är strukturerad runt en Docker Compose-fil [`compose.yaml`](../compose.yaml). Denna innehåller information för Docker om hur man kör alla de olika projekten och hur de ska sättas ihop. I och med att det är just Docker betyder det också att all kod körs på samma sätt oavsett dator.

För att bygga dessa Dockercontainrar används GitHub Actions i varje projekts GitHubsida. De bygger en container som enkelt kan laddas ner av Docker Compose-filen. Exakt vilken version håller dessutom [`.env`-filen](../.env) koll på!

I Docker körs alla projekten, men också en nginx-server. Denna ansvarar för att ta emot all datatrafik som servern får och skicka vidare den till rätt projekt. DESSUTOM levererar den filer. Alla filer den kan se (titta i [Docker Compose-filen](../compose.yaml), under `nginx: [...] volumes:`), kan nås genom att gå in på `https://domän.se/väg/till/filen`, och nginx ser till att leverera den! De små hemsideprojekten behöver till exempel ingen kod som körs på servern utom bara att HTML- och Javascriptfilerna levereras vilket nginx tar hand om. Om du inte är bekant med detta, sök gärna upp om "static files". Notera också att nginx här är konfigurerad att allt som den inte vet var det ska skickas vidare till Wordpress.

Likt hur Dockercontainrarna byggs med GitHub Actions byggs även static files till många projekt med GitHub Actions. Dessa blir en release som sedan kan laddas ner med hjälp av nerladdningsskripten i [`/scripts/`](../scripts/). Underhåll dessa! Det gör att man inte måste undra vilken version av vardera paket som används för att bygga ett projekt.

Tillsammans gör detta att alla projekt hanteras på väldigt liknande sätt, och att uppstart, ändringar och flyttar knappt skiljer sig mellan projekt. Förhoppningen är att det underlättar Webmasterns arbetsbörda och gör det lättare att bevara gamla projekt.

## Motivering
När Fysikmotorn först införskaffades lades olika projekt och kodsnuttar dit på de sätt som var mest naturliga i stunden. Det här fungerar till viss grad, men när projekt blir gamla, personerna som skrev dem lämnat, och någonting går sönder kan det vara ett massivt arbete att få upp det igen. Vissa försök gjordes att förbättra situationen och bland annat blev Dockeriserade projekt standard. Mycket gammalt var dock kvar och saker hängde inte riktigt ihop.

Därav det här projektet. Det här repot innehåller allt som behövs för den nya Fysikmotorn. Alla projekt körs i Dockercontainers, alla filer och containrar byggs på GitHub, och både nedladdning av projekt och backups är mer eller mindre automatiserat! Det har varit ett rejält arbete att få ihop detta, men Webmaster 2024 ansåg det vara dags för en renovering.

För att det här projektet ska fungera och att saker inte ska gå tillbaka till kaos krävs det att ni tar hand om det. Om ni lägger till ett projekt, uppdaterar något, eller på annat sätt ändrar, var god och uppdatera allt. Om små saker slutar fungera blir det en pina för de som kommer efter senare och då slutar det uppehållas. Det betyder dock inte att ändringar är dåliga; saker får gärna ändras på så länge man har förståelse för hur projektet hänger ihop. Även delar som backupprocessen och nerladdning har definitivt förbättringspotential!
