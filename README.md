# 🔍 Cluada

Audit SQL des usages d'un bâtiment de bureaux, à partir des traces de badgeage.

## 📝 Description
*Exercice réalisé dans le cadre de la formation Concepteur Développeur d'Applications à Ada Tech School.*

Adakor est une société de conseil fictive de 35 salarié·e·s, dont l'immeuble fonctionne entièrement au badge nominatif : portes, parking et machine à café. Sa direction commande un état des lieux chiffré des 8 dernières semaines.

J'ai mené l'audit uniquement en SQL, d'abord avec des requêtes d'état des lieux, puis en croisant les données pour expliquer les anomalies. L'enquête a mis en évidence un badge utilisé le soir, par une autre personne, pendant les congés de sa titulaire. Le rapport complet est dans [`rapport.md`](rapport.md).

Dans un second temps, j'ai fait évoluer la base pour enregistrer les visiteurs : schéma entité-association, migrations, jeu de données et requêtes de vérification.

## 🛠️ Technologies utilisées
- PostgreSQL / SQL
- Docker

## 📂 Structure du projet

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

## 🚀 Utiliser le projet

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

## ✅ Avancement du projet

- [x] Partie 1 : Audit
- [x] Partie 2 : Exploration des données
- [x] Partie 3 : Extension
  - [x] schéma entité-association
  - [x] Migration Up
  - [x] Migration Down
  - [x] Seed
  - [x] requêtes de vérification

## 🎯 Compétences mises en oeuvre

- Lecture d'un schéma entité-association et du schéma relationnel qui en découle
- Requêtes SELECT avec différents filtres, tris et agrégations
- Jointures SQL, y compris entre 3 tables
- Détecter des anomalies avec GROUP BY et HAVING
- Création de tables avec contraintes, clés étrangères et types ENUM
- Insertion de données cohérentes dans une base existante

## 👤 Auteure

- **Lucille Richard** - Étudiante chez Ada Tech School

## 📄 Licence

Projet réalisé dans un cadre pédagogique - Ada Tech School.