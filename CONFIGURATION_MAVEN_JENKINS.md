# Configuration de Maven dans Jenkins

## Problème Rencontré

```
mvn: not found
```

Maven n'est pas installé ou configuré dans Jenkins.

## Solution : Configurer Maven dans Jenkins

### Option 1 : Configuration via l'Interface Jenkins (Recommandé)

1. **Aller dans la configuration globale de Jenkins** :
   - Cliquez sur "Manage Jenkins" (Gérer Jenkins)
   - Cliquez sur "Tools" (Outils) ou "Global Tool Configuration"

2. **Configurer Maven** :
   - Trouvez la section "Maven"
   - Cliquez sur "Add Maven"
   - **Name** : `M3` (ou le nom que vous préférez)
   - **Install automatically** : ✅ Cochez cette case
   - **Version** : Sélectionnez une version (ex: `3.9.5` ou la dernière disponible)
   - Cliquez sur "Save"

3. **Configurer JDK** (si nécessaire) :
   - Trouvez la section "JDK"
   - Cliquez sur "Add JDK"
   - **Name** : `JDK17`
   - **JAVA_HOME** : Chemin vers votre installation JDK 17
     - Sur Linux : `/usr/lib/jvm/java-17-openjdk` ou similaire
     - Sur Windows : `C:\Program Files\Java\jdk-17` ou similaire
   - OU cochez "Install automatically" et sélectionnez une version
   - Cliquez sur "Save"

4. **Relancer le pipeline** :
   - Retournez à votre projet Pipeline
   - Cliquez sur "Build Now"

### Option 2 : Installation Manuelle de Maven (si Option 1 ne fonctionne pas)

#### Sur Linux (Jenkins dans Docker/Linux)

1. **Se connecter au conteneur/serveur Jenkins** :
   ```bash
   docker exec -it jenkins-container bash
   # ou
   ssh user@jenkins-server
   ```

2. **Installer Maven** :
   ```bash
   # Sur Ubuntu/Debian
   apt-get update
   apt-get install -y maven
   
   # Vérifier l'installation
   mvn -version
   ```

3. **Configurer dans Jenkins** :
   - Allez dans "Manage Jenkins" > "Tools"
   - Section "Maven"
   - Ajoutez Maven avec :
     - **Name** : `M3`
     - **MAVEN_HOME** : `/usr/share/maven` ou `/usr/bin/maven` (vérifiez avec `which mvn`)
   - Cliquez sur "Save"

#### Sur Windows

1. **Télécharger Maven** :
   - Allez sur https://maven.apache.org/download.cgi
   - Téléchargez la version binaire (apache-maven-X.X.X-bin.zip)

2. **Extraire et configurer** :
   - Extrayez dans un dossier (ex: `C:\Program Files\Apache\maven`)
   - Ajoutez `C:\Program Files\Apache\maven\bin` au PATH système

3. **Configurer dans Jenkins** :
   - Allez dans "Manage Jenkins" > "Tools"
   - Section "Maven"
   - Ajoutez Maven avec :
     - **Name** : `M3`
     - **MAVEN_HOME** : `C:\Program Files\Apache\maven`
   - Cliquez sur "Save"

### Option 3 : Utiliser Docker Agent (Alternative)

Si vous préférez utiliser Docker, vous pouvez modifier le Jenkinsfile pour utiliser un agent Docker avec Maven pré-installé. Cependant, cela nécessite Docker dans Docker, ce qui peut être complexe.

## Vérification

Après configuration :

1. Allez dans votre projet Pipeline
2. Cliquez sur "Build Now"
3. Vérifiez les logs - vous ne devriez plus voir "mvn: not found"

## Notes sur le Jenkinsfile

Le Jenkinsfile a été mis à jour pour utiliser :
```groovy
tools {
    maven 'M3'
    jdk 'JDK17'
}
```

Assurez-vous que les noms (`M3` et `JDK17`) correspondent exactement aux noms configurés dans Jenkins.

## Si les Noms Ne Correspondent Pas

Si vos outils ont des noms différents dans Jenkins, modifiez le Jenkinsfile :

1. Allez dans "Manage Jenkins" > "Tools"
2. Notez les noms exacts de vos outils Maven et JDK
3. Modifiez le Jenkinsfile en conséquence :
   ```groovy
   tools {
       maven 'NomExactDansJenkins'
       jdk 'NomExactJDK'
   }
   ```
4. Commitez et poussez les changements
5. Relancez le pipeline

