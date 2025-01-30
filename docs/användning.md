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
