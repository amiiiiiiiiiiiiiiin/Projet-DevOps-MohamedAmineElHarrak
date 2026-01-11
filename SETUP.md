# Guide de Configuration - Projet DevOps

Ce document contient les instructions pour configurer et utiliser le projet DevOps.

## Structure du Projet

```
Projet-DevOps-MohamedAmineElHarrak/
├── devops-app/              # Application Java/Maven
│   ├── src/
│   │   ├── main/java/       # Code source
│   │   └── test/java/       # Tests unitaires
│   ├── pom.xml              # Configuration Maven
│   └── README.md
├── .github/
│   └── workflows/
│       └── ci.yml           # Workflow GitHub Actions
├── Jenkinsfile              # Pipeline Jenkins
├── Dockerfile               # Configuration Docker
├── docker-compose.yml       # Orchestration Docker
└── README.md
```

## Partie 1: Configuration Git et GitHub

### 1. Vérification de l'état Git

```bash
# Vérifier les branches
git branch -a

# Vérifier le remote
git remote -v
```

### 2. Commits et Push

```bash
# Ajouter les fichiers
git add .

# Commit
git commit -m "Ajout des configurations DevOps (Jenkins, Docker, GitHub Actions)"

# Push vers la branche dev
git push origin dev
```

### 3. Création d'une Pull Request

1. Allez sur GitHub dans votre dépôt
2. Cliquez sur "Pull requests" > "New pull request"
3. Sélectionnez `dev` comme source et `main` comme destination
4. Créez la PR et vérifiez que GitHub Actions s'exécute

## Partie 2: Configuration Jenkins

### 1. Installation des plugins nécessaires

Dans Jenkins, installez les plugins suivants :
- **Git Plugin** (généralement déjà installé)
- **Pipeline Plugin**
- **Slack Notification Plugin**
- **JUnit Plugin**
- **Docker Pipeline Plugin** (optionnel)

### 2. Configuration du projet Jenkins

1. **Créer un nouveau projet** :
   - Cliquez sur "New Item"
   - Nommez-le : `PipeLine-MohamedAmineElHarrak`
   - Sélectionnez "Pipeline"
   - Cliquez sur "OK"

2. **Configuration du Pipeline** :
   - Dans "Pipeline Definition", sélectionnez "Pipeline script from SCM"
   - **SCM** : Git
   - **Repository URL** : `https://github.com/amiiiiiiiiiiiiiiin/Projet-DevOps-MohamedAmineElHarrak.git`
   - **Branches to build** : `*/dev` ou `*/main`
   - **Script Path** : `Jenkinsfile`
   - Cliquez sur "Save"

3. **Configuration GitHub Webhook** (optionnel mais recommandé) :
   - Dans votre dépôt GitHub, allez dans Settings > Webhooks
   - Ajoutez un webhook pointant vers : `http://votre-jenkins-url/github-webhook/`
   - Content type : `application/json`

### 3. Configuration de Slack

1. **Créer un Webhook Slack** :
   - Allez sur https://api.slack.com/apps
   - Créez une nouvelle app ou utilisez une existante
   - Activez "Incoming Webhooks"
   - Créez un webhook et copiez l'URL

2. **Ajouter les credentials dans Jenkins** :
   - Dans Jenkins, allez dans "Manage Jenkins" > "Credentials"
   - Ajoutez une nouvelle credential de type "Secret text"
   - ID : `slack-webhook-url`
   - Secret : collez l'URL du webhook Slack
   - Cliquez sur "OK"

3. **Configuration du canal Slack** :
   - Le canal par défaut est `#devops-notifications`
   - Vous pouvez le modifier dans le `Jenkinsfile` (variable `SLACK_CHANNEL`)

### 4. Création d'une vue personnalisée

1. Dans Jenkins, cliquez sur "+" à côté de "All"
2. Nommez la vue : "Pipeline Projects"
3. Sélectionnez "List View"
4. Configurez le filtre :
   - **Job Filters** > Ajoutez un filtre par nom avec le pattern : `.*PipeLine.*`
5. Cliquez sur "OK"

## Utilisation de Docker

### Build de l'image Docker

```bash
docker build -t devops-app:latest .
```

### Exécution avec Docker

```bash
docker run --rm devops-app:latest
```

### Utilisation de Docker Compose

```bash
docker-compose up --build
```

Pour exécuter en arrière-plan :

```bash
docker-compose up -d
```

Pour voir les logs :

```bash
docker-compose logs -f
```

Pour arrêter :

```bash
docker-compose down
```

## Exécution locale

### Build et Test avec Maven

```bash
cd devops-app
mvn clean test package
```

### Exécution du JAR

```bash
java -jar devops-app/target/devops-app-1.0-SNAPSHOT.jar
```

## Workflow GitHub Actions

Le workflow GitHub Actions s'exécute automatiquement lors de :
- Push sur la branche `dev`
- Push sur la branche `main`
- Pull Request vers `main`

Il effectue :
1. Checkout du code
2. Configuration de Java 17
3. Build et tests avec Maven
4. Upload de l'artifact JAR

## Pipeline Jenkins

Le pipeline Jenkins comprend les étapes suivantes :

1. **Checkout** : Récupération du code depuis GitHub
2. **Build** : Compilation avec Maven
3. **Test** : Exécution des tests unitaires
4. **Package** : Création du JAR
5. **Archive** : Archivage des artifacts
6. **Deploy** : Déploiement (local ou Docker)
7. **Notify Slack** : Notification dans Slack (succès/échec)

## Notes importantes

- Assurez-vous que Maven et Java 17 sont installés sur votre machine Jenkins
- Pour Docker, assurez-vous que Docker est installé et que l'utilisateur Jenkins a les permissions
- Les notifications Slack nécessitent une URL de webhook valide
- Le pipeline Jenkins ne déploie que si les tests passent

## Dépannage

### Problème avec les tests
- Vérifiez que JUnit est bien configuré dans `pom.xml`
- Vérifiez que le répertoire `src/test/java` existe

### Problème avec Jenkins
- Vérifiez les logs de build dans Jenkins
- Vérifiez que tous les plugins sont installés
- Vérifiez les credentials pour Slack

### Problème avec Docker
- Vérifiez que Docker est en cours d'exécution
- Vérifiez les permissions Docker

