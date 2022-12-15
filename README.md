# What's the weather like ?

## Technologies, environnement de travail
Nous avons choisi de développer une application mobile ios en swift. 
En effet, tous les membres du groupe possédant un mac et ayant déjà eu l'occasion de travailler avec cette technologie nous avons choisi swift au lieu des deux autres proposées.

Swift permet de réaliser des applications mobiles de deux manières différentes, il y a swift Storyboard et swift UI. Pour ce projet nous avions commencé à développer avec swift storyboard. 

Toutefois lors de la deuxième séance de travail nous nous sommes penchés sur swift UI qui nous a semblé plus simple et compréhensible (en effet la conception des pages ressemble plus au moins a du code type `html`, et nous avons réussi à organiser, découper notre code plus facilement que dans la verison Swift Storyboard).

Nous avons donc décidé de récupérer le début de récupération de donéées que nous avions réalisé pour passer sur un développement d'application en Swift UI.


Et pour finir, pour réaliser cette application météo nous avons fait appel à l'api `open weather map` afin de récupérer l'ensemble des données nécessaires. Nous avons également utilisé l'api google `Places API` nous permettant de mettre en place un système de recherche de localisation afin de proposer une application météo des plus complète.

## Architecture du projet.
Nous avons fait en sorte de découpé au mieux notre code, c'est pourquoi nous retrouvons une architecture relativement fournie.

Nous comptons sept dossiers à la racine, nous allons revenir brièvement sur l'utilité de chacun d'eux.

**1. Completion**
Dans ce dossier nous retrouvons toute la configuration permettant la mise en place de la barre de recherche avec les appels à l'api `google api maps`. Nous gérons donc la récupération des données ainsi que l'implémenation de l'autocomplétion afin d'améliorer l'expérience utilisateur.


**2. Config**
Dans config nous retrouvons un seul fichier qui réunit l'ensemble des fonctions que nous utilisons dans les différents fichier de l'application, ce sont principalement des fonctions que nous utilisons pour l'affichage des donées (ex: la fonction permettant de modifier le choix de l'unité de température, ou bien la fonction permettant d'arrondir les températures)


**3. Storage**
Dans ce dossier nous retrouvons toute la gestion "des favoris". En effet pour mettre en place les favoris de manière permanente (cad après redémarrage de l'application) nous avons utilisé la fonctionnalaité `Core Data`. 

Ainsi nous avons défini le model des données que nous sauvegardons. Ici pour récupérer la météo nous avons eu besoin d'enregistrer le nom de la ville mais surtout ses coordonnées géographique. Donc pour chaque ville ajouté en favoris nous récupérons ces données. 

Et pour finir, le fichier persistentData permet d'initialiser, implémenter cette fonctionnalité au projet.


**4. Service**
Dans ce dossier nous avons regroupé les appels à l'api `open weather map` ainsi que la configuration de l'option de géolocalisation. 


**5. Models**
Dans ce dossier nous retrouvons donc les différents models. qui nous permettent de décoder l'ensemble des données que nous pouvons récupérer des appels d'api. Ces models nous permettent de récupérer, lire et réutiliser les données reçues.


**6. ViewModels**
Dans ce dossier nous retrouvons principalement le fichier WeatherViewModel qui est en réalité une sorte de "passserelle" avant le fichier de `/views`. 

En effet c'est dans ce fichier que nous faisons appel aux fonctions du dossier `/Service` nous permettant de récupérer les données de l'api pour une localisation données.

C'est également dans ce fichier que nous préparons les données qui seront par le suite affichées dans la page finale.



**7. Views**
Et pour conclure l'architecture du projet le dossier principal, celui des "Views" qui contient donc l'ensemble des pages composant notre aplication.


## Organisation
Pour ce qui est de l'organisation, nous avons fait en sorte de travailler sur ce projet en même temps ce qui nous a facilité en terme d'organisation et de communication. 
La plupart du temps nous avons fait en sorte de travailler chacun sur une partie distincte du projet (récupération des données, affichages des données, design, gestion des favoris, gestion localisation, ajout de l'api google). 

Puis à certains moment nous nous sommes réunis lorsque cela était nécessaire afin de trouver un moyen de nous débloquer, avancer tous ensemble.

## Résultat du projet
Nous avons réussi à réaliser l'ensemble des fonctionnalitées demandées dans le sujet et avons réussi à metre en place ce dont nous avions traité lors du premier suivi.

Ainsi, notre application est composées de trois pages principales. La page "home" qui est active uniquement lorque la géolocalisation à été activée et qui affiche donc la météo actuelle et future en fonction de l'emplacement de la personne.

Ensuite nous avons donc une page de recherche qui nous permet par la suite de naviguer sur la page météo du lieu recherché.

Et pour finir, un onglet favoris qui permet à l'utilisateur de retrouver l'ensemble des villes qu'il a ajouté a ses favoris sous la forme d'un carrousel.

<img src="https://i.imgur.com/gWvslNb.jpg" width="228"/>
<img src="https://i.imgur.com/8r2DcCL.png" width="228"/>
<img src="https://i.imgur.com/tiG4ME4.png" width="228"/>
<img src="https://i.imgur.com/xNYVNoC.png" width="228"/>

<video src='https://user-images.githubusercontent.com/91067946/194086909-fd3c9428-ea1f-41b5-a81e-23692a6c0ab7.mp4' controls loop width=280 />


