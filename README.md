# Projet dbt de Démonstration

Bienvenue dans ce projet de démonstration dbt.

Ce projet est un exemple d'utilisation de dbt (Data Build Tool) pour transformer des données dans un entrepôt de données BigQuery.

## Configuration

### 1. Prérequis

- Python 3.x
- dbt-bigquery

Installez les dépendances avec :
```
pip install dbt-bigquery
```

### 2. Profil de Connexion

Pour que dbt puisse se connecter à votre entrepôt de données, vous devez configurer un fichier `profiles.yml`. Ce projet est configuré pour utiliser un profil nommé `dbt_demo`.

Le fichier `profiles.yml` n'est pas versionné pour des raisons de sécurité. Vous devez créer le vôtre dans le dossier `~/.dbt/` ou l'inclure à la racine du projet (notez qu'il est dans le `.gitignore`).

Voici un exemple de configuration pour BigQuery en utilisant un compte de service :

```yaml
dbt_demo:
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: [votre-projet-gcp]
      dataset: [votre-dataset]
      location: [votre-location] # e.g., US
      threads: 1
      keyfile: [chemin-vers-votre-keyfile.json]
  target: dev
```

Remplacez les valeurs entre crochets `[]` par vos propres informations.

## Utilisation

Une fois votre profil configuré, vous pouvez exécuter les commandes dbt suivantes :

- **`dbt run`**: Exécute tous les modèles du projet. Cela construira les tables et les vues dans votre entrepôt de données.

- **`dbt test`**: Exécute tous les tests définis sur vos modèles pour garantir la qualité et l'intégrité des données.

## Structure du Projet

- **`models/`**: Contient les modèles SQL qui définissent les transformations de données.
  - **`staging/`**: Modèles pour nettoyer et préparer les données sources.
  - **`datawarehouse/`**: Modèles qui construisent les tables de faits et de dimensions.
  - **`example/`**: Modèles d'exemple fournis par dbt.

- **`seeds/`**: Contient les fichiers CSV qui peuvent être chargés dans l'entrepôt de données en utilisant `dbt seed`.

- **`tests/`**: Contient les tests de données personnalisés.

## Ressources

- Apprenez-en plus sur dbt [dans la documentation officielle](https://docs.getdbt.com/docs/introduction).
- Consultez le [blog dbt](https://blog.getdbt.com/) pour les dernières nouvelles et les meilleures pratiques.
