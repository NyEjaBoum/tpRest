# TODO — tpRest (Répartition Ewan / Nyeja)

Auteurs : Ewan (docker & Postman) — Nyeja (backend)  
Statut global : en développement

## Priorité haute
- [ ] Ewan — Fixer docker-compose pour exécution fiable (MySQL 5.7 + build WAR)
  - vérifier / supprimer option `version` obsolète
  - éviter pull forcé : tester `docker compose up --build --pull=missing` ou `--pull=never`
  - s'assurer que le service builder/compose ne bloque pas sur TLS handshake (timeout, proxy)
  - garantir que scriptNyeja.sql est exécuté correctement par mysql:5.7 (copie dans /docker-entrypoint-initdb.d)
  - fournir commande simple pour le prof : `docker compose up --build -d` + logs
  - Critère d'acceptation : `docker compose up --build -d` démarre db et app (app se connecte à db)

- [ ] Ewan — Fournir collection Postman (JSON) avec les endpoints principaux
  - inclure exemples de requêtes et réponses (200, 404, 500)
  - documenter base URL (http://localhost:8080) et variables d'environnement

- [ ] Nyeja — Corriger backend critique
  - corriger scriptNyeja.sql (tuples mal fermés; FK coherency)
  - résoudre l'erreur Hibernate "Unable to determine Dialect" (mettre spring.jpa.properties.hibernate.dialect ou définir SPRING_DATASOURCE_URL en env)
  - assurer packaging WAR dans pom.xml et que l'app démarre avec `java -jar target/*.war`
  - Critère d'acceptation : app lance sans exception Hibernate et retourne JSON attendu aux endpoints

## Priorité moyenne
- [ ] Nyeja — Sécurité / stabilité API
  - remplacer catch(Exception) exposant ex.getMessage() par logging et message générique
  - mapper codes d'erreur interne en HTTP status corrects (E_NOT_FOUND -> 404, E_DB_CONN -> 503, E_INTERNAL -> 500)
  - ajouter Logger (SLF4J) dans services

- [ ] Nyeja — Tests & qualité
  - ajouter tests unitaires pour NoteService, EtudiantService
  - ajouter intégration (H2 ou Testcontainers) si possible

- [ ] Ewan — Optionnel : proposer image multi-stage Dockerfile (si prof accepte Dockerfile)
  - alternative propre à usage prof : `docker compose up --build` construit image app directement

## Priorité basse
- [ ] Nyeja — Documentation endpoints (README + snippets) / Swagger
- [ ] Ewan — Documenter instructions réseau (proxy / timeout) pour éviter TLS handshake timeout
- [ ] Nyeja — Nettoyage SQL / données réalistes (valeurs et FK cohérentes)

## Checklist de livraison (pour le prof)
- [ ] docker compose up --build -d fonctionne depuis la racine du repo
- [ ] scriptNyeja.sql valide et la base notes_db contient données de test cohérentes
- [ ] Postman collection incluse (Postman_collection.json) à la racine
- [ ] README.md mis à jour avec commandes d'exécution et points d'attention

## Hand-off / communication
- Ewan : pousser mise à jour docker-compose.yml + Postman_collection.json  
- Nyeja : pousser corrections backend (application.properties, pom.xml packaging=war, fixes services)  
- Tester ensemble : `docker compose up --build -d` -> `docker compose logs -f app` -> appeler endpoints Postman
