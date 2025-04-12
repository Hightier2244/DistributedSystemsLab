# GitHub Codespaces ♥️ Ruby on Rails

## Projektübersicht
Dies ist ein Ruby on Rails-Projekt, das in GitHub Codespaces läuft. Es enthält eine API für das Verwalten von Einkaufslistenartikeln.

## Features
- **API für Einkaufslisten**: CRUD-Operationen für Artikel.
- **Swagger-Dokumentation**: Automatisch generierte API-Dokumentation verfügbar unter `/api-docs`.

## API-Dokumentation
Die API-Dokumentation wird mit [Rswag](https://github.com/rswag/rswag) generiert. Du kannst sie im Browser unter folgendem Pfad aufrufen:
```
http://localhost:3000/api-docs
```

## Erste Schritte
1. **Gems installieren**:
   Stelle sicher, dass alle benötigten Gems installiert sind:
   ```bash
   bundle install
   ```
2. **Swagger-Dokumentation aktualisieren**:
    ```bash
    rake rswag:specs:swaggerize
    ```
3. **Server starten**:
   ```bash
   rails server
   ```