# Guide pour la Préparation du Rapport

Ce document vous guide pour compléter le projet et préparer votre rapport.

## Checklist de Vérification

### Partie 1: Git et GitHub ✅

- [x] Dépôt Git initialisé
- [x] README.md avec nom et prénom
- [x] Dépôt GitHub créé (Projet-DevOps-MohamedAmineElHarrak)
- [x] Branches main et dev créées
- [x] Application créée et commitée
- [ ] **À FAIRE**: Créer une Pull Request de dev vers main
- [ ] **À FAIRE**: Vérifier que GitHub Actions s'exécute

### Partie 2: Jenkins ⚠️

- [x] Jenkinsfile créé avec toutes les étapes
- [ ] **À FAIRE**: Configurer Jenkins
  - [ ] Installer les plugins nécessaires
  - [ ] Créer le projet PipeLine-MohamedAmineElHarrak
  - [ ] Configurer le pipeline
  - [ ] Configurer les credentials Slack
- [ ] **À FAIRE**: Créer une vue personnalisée pour les projets "PipeLine"
- [ ] **À FAIRE**: Exécuter le pipeline et capturer les écrans

### Docker ✅

- [x] Dockerfile créé
- [x] docker-compose.yml créé
- [ ] **À FAIRE**: Tester le build Docker (optionnel pour le rapport)

## Étapes pour Finaliser

### 1. Commiter et Pousser les Changements

```bash
# Assurez-vous d'être sur la branche dev
git checkout dev

# Ajouter tous les fichiers
git add .

# Commiter
git commit -m "Ajout des configurations DevOps complètes (Jenkins, Docker, GitHub Actions)"

# Pousser vers GitHub
git push origin dev
```

### 2. Créer une Pull Request

1. Allez sur GitHub : https://github.com/amiiiiiiiiiiiiiiin/Projet-DevOps-MohamedAmineElHarrak
2. Cliquez sur "Pull requests" > "New pull request"
3. Sélectionnez `dev` → `main`
4. Remplissez le titre et la description
5. Créez la PR
6. **Capturez l'écran** de la PR
7. Attendez que GitHub Actions s'exécute et **capturez l'écran** des résultats

### 3. Configuration Jenkins

#### a) Installation des Plugins

Dans Jenkins, allez dans "Manage Jenkins" > "Plugins" et installez :
- Git Plugin (généralement déjà installé)
- Pipeline Plugin
- Slack Notification Plugin
- JUnit Plugin
- Docker Pipeline Plugin (optionnel)

#### b) Configuration des Credentials Slack

1. Dans Jenkins : "Manage Jenkins" > "Credentials" > "System" > "Global credentials"
2. Cliquez sur "Add Credentials"
3. Type : "Secret text"
4. Secret : URL de votre webhook Slack
5. ID : `slack-webhook-url`
6. Description : "Slack Webhook URL"
7. Cliquez sur "OK"

#### c) Création du Projet Pipeline

1. Cliquez sur "New Item"
2. Nom : `PipeLine-MohamedAmineElHarrak`
3. Type : "Pipeline"
4. Cliquez sur "OK"
5. Configuration :
   - **Pipeline Definition** : "Pipeline script from SCM"
   - **SCM** : Git
   - **Repository URL** : `https://github.com/amiiiiiiiiiiiiiiin/Projet-DevOps-MohamedAmineElHarrak.git`
   - **Credentials** : (ajoutez si nécessaire)
   - **Branches to build** : `*/dev` ou `*/main`
   - **Script Path** : `Jenkinsfile`
6. Cliquez sur "Save"

#### d) Création d'une Vue Personnalisée

1. Dans Jenkins, cliquez sur "+" à côté de "All"
2. Nom de la vue : "Pipeline Projects"
3. Type : "List View"
4. Cliquez sur "OK"
5. Dans "Job Filters", ajoutez :
   - "Name" filter avec le pattern : `.*PipeLine.*`
6. Cliquez sur "OK"

#### e) Exécution du Pipeline

1. Allez dans votre projet Pipeline
2. Cliquez sur "Build Now"
3. **Capturez l'écran** du pipeline en cours d'exécution
4. Cliquez sur le build pour voir les détails
5. **Capturez l'écran** de chaque étape (Checkout, Build, Test, Package, Archive, Deploy)
6. **Capturez l'écran** des notifications Slack

### 4. Configuration Slack (si nécessaire)

Si vous n'avez pas encore configuré Slack :

1. Allez sur https://api.slack.com/apps
2. Créez une nouvelle app ou utilisez une existante
3. Allez dans "Incoming Webhooks"
4. Activez "Activate Incoming Webhooks"
5. Cliquez sur "Add New Webhook to Workspace"
6. Sélectionnez le canal (ex: #devops-notifications)
7. Copiez l'URL du webhook
8. Utilisez cette URL dans les credentials Jenkins (étape 3.b)

### 5. Captures d'Écran à Prendre

#### GitHub

1. **Structure du projet** :
   - Capture de la page principale du dépôt GitHub montrant la structure des fichiers
   - Ou capture de la vue "Code" du dépôt

2. **Historique des commits** :
   - Capture de la page "Commits" montrant l'historique
   - Montrez les commits sur les branches main et dev

3. **Pull Request** :
   - Capture de la PR créée (dev → main)
   - Capture de la liste des PRs
   - Capture des commentaires/revue (si applicable)

4. **GitHub Actions** :
   - Capture de la page "Actions" montrant les workflows
   - Capture d'un workflow en cours d'exécution
   - Capture des résultats d'un workflow (succès/échec)
   - Capture des détails d'une étape (build, test, etc.)

#### Scripts

1. **Jenkinsfile** :
   - Capture du contenu complet (ou les parties importantes)
   - Assurez-vous que le texte est lisible

2. **Workflow GitHub Actions** (`.github/workflows/ci.yml`) :
   - Capture du contenu complet
   - Assurez-vous que le texte est lisible

3. **Dockerfile** :
   - Capture du contenu complet
   - Assurez-vous que le texte est lisible

4. **docker-compose.yml** :
   - Capture du contenu complet
   - Assurez-vous que le texte est lisible

#### Jenkins

1. **Vue d'ensemble** :
   - Capture de la page principale Jenkins
   - Capture de la vue personnalisée "Pipeline Projects"

2. **Configuration du Pipeline** :
   - Capture de la page de configuration du projet
   - Montrez les paramètres principaux (SCM, script path, etc.)

3. **Exécution du Pipeline** :
   - Capture de la liste des builds
   - Capture d'un build en cours
   - Capture de chaque étape :
     - Checkout (avec logs si possible)
     - Build (avec logs si possible)
     - Test (avec logs si possible)
     - Package (avec logs si possible)
     - Archive (montrant les artifacts)
     - Deploy (avec logs si possible)

4. **Résultats** :
   - Capture de la vue "Console Output" complète
   - Capture de la vue "Test Results" (si disponible)
   - Capture de la vue "Artifacts"

#### Slack

1. **Notifications de succès** :
   - Capture du message Slack lorsqu'un pipeline réussit
   - Montrez le canal, le format du message

2. **Notifications d'échec** :
   - Capture du message Slack lorsqu'un pipeline échoue (si applicable)
   - Ou capture d'un message d'échec de test

3. **Intégration** :
   - Capture de la configuration Slack dans Jenkins (si visible)
   - Capture du canal Slack avec plusieurs notifications

## Structure Recommandée du Rapport

1. **Introduction**
   - Présentation du projet
   - Objectifs

2. **Partie 1: Git et GitHub**
   - Structure du projet (capture)
   - Historique des commits (capture)
   - Pull Request (capture)
   - GitHub Actions (captures)

3. **Partie 2: Jenkins**
   - Configuration (captures)
   - Pipeline (captures)
   - Vue personnalisée (capture)
   - Résultats (captures)

4. **Scripts et Configurations**
   - Jenkinsfile (capture/texte)
   - Workflow GitHub Actions (capture/texte)
   - Dockerfile (capture/texte)
   - docker-compose.yml (capture/texte)

5. **Notifications Slack**
   - Configuration (si applicable)
   - Messages de succès (captures)
   - Messages d'échec (captures si applicable)

6. **Conclusion**
   - Résumé
   - Difficultés rencontrées
   - Apprentissages

## Notes Importantes

- Assurez-vous que toutes les captures d'écran sont **claires et lisibles**
- Ajoutez des **légendes** ou **commentaires** aux captures importantes
- Organisez les captures par section
- Vérifiez que le texte dans les captures est lisible (zoom si nécessaire)
- Testez le pipeline plusieurs fois pour avoir des captures de différents états

## Lien du Dépôt GitHub

N'oubliez pas d'inclure le lien du dépôt dans votre rapport :
`https://github.com/amiiiiiiiiiiiiiiin/Projet-DevOps-MohamedAmineElHarrak`

