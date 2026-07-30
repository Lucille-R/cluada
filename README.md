# Cluada

## Structure du projet

```text
- cluada
    ├── adakor.sql
    ├── queries.sql
    ├── docker-compose.yml
    ├── migration_up.sql
    ├── migration_down.sql
    ├── rapport.md
    ├── README.md
    ├── schema-etendu.png
    └── seed.sql
```

## Utiliser le projet

### Lancer le projet

```bash
docker compose up -d
```

### Se connecter à la base de données

```bash
docker exec -it adakor-db psql -U ada -d adakor
```

### Couper le projet

```bash
docker compose down
```

## Avancé dans le projet

- [x] Partie 1 : Audit
- [x] Partie 2 : Exploration des données
- [ ] Partie 3 : Extension
  - [x] schéma entité-association
  - [x] Migration Up
  - [x] Migration Down
  - [ ] Seed
  - [ ] requêtes de vérification
- [ ] Bonus

## compétences

- [x] Je sais lire un schéma entité-association et le schéma relationnel qui en découle
- [x] Je sais écrire des requêtes SELECT avec différents filtres
- [x] Je sais utiliser les jointures SQL, y compris entre 3 tables
- [x] Je sais utiliser GROUP BY et HAVING pour détecter des anomalies
- [ ] Je sais créer des tables SQL avec contraintes, clés étrangères et enum
- [ ] Je sais insérer des données cohérentes dans une base existante
