LISTE DE TRUCS A AJOUTER :

    - Envoyer les messages d'erreur précis dans les logs
    - Supprimer le compte sur lequel l'opération est effectué PEU IMPORTE LE NOM (donc pas seulement "admin")
    - Regex pour mettre des restrictions sur le mot de passe


# ***<p align="center">Scripts de setup</p>***

### <p align="center">Ces scripts Powershell vous permettront avec l'un de pouvoir faire un setup rapide de multiples applications, serveur GLPI ou compte administrateur sur un nouveau poste, ainsi que d'ajouter ou supprimer des applications pour le premier script avec l'autre. Ils disposent d'une interface graphique le rendant facilement utilisable par tout le monde. Le nom des applications et les lignes de commande pour l'installation de ces derniers sont stockées dans le dossier "array" et peuvent être modifiés manuellement si nécessaire. 
</p> 

## **<p align="center">AVERTISSEMENTS</p>**

#### *<p align="center">Ce script ne marche pas si ne serait ce qu'un seul des dossiers dans le chemin vers le script ont un espace à l'intérieur, veuillez soit mettre le script dans un dossier comme "Documents" ou remplacer les espaces par des "_" ou des "-".</p>*

#### *<p align="center">Le script d'installation peut être éxecuté à partir d'un disque amovible, il est donc possible de lancer le script et de le débrancher pour le mettre sur un autre poste.</p>* 

## **<p align="center">Explication</p>**

#### *<p align="center">Cette partie est réservé aux personnes intéréssé par le fonctionnement de ces deux scripts sans avoir à fouiller dans le code pour obtenir plus de détails.</p>*

## **<p align="center">Script d'installation</p>**

### **Étape 0 : Préparation**

Avant même que le script se lance, plusieurs choses doivent être effectué. Le script demande d'élever les privilèges sur l'ordinateur pour avoir accès au droits d'administrateurs. Cela permettra d'installer toutes les applications d'une seule traite sans avoir à revenir constamment pour autoriser une modification sur le poste.

Plusieurs choses sont ensuite mises en place :

    - Chargement des assemblies WPF pour avoir du style sur le formulaire
    - Récupère les noms des programmes et leur ligne de commande et les mets dans des variables
    - Initialise des variables à utiliser pour plus tard
    - Créer la fonction "Write-Log" pour pouvoir écrire des logs dans un document externe

En dessous, le code pour créer le GUI du formulaire, ce dernier est fait à partir de XAML et les éléments "dynamiques" ont la propriété "x:Name" et sont définis dans le Powershell pour pouvoir être modifié à partir de là.

Enfin, la fenêtre est créé et des variables pour le bouton "Précédent" et "Suivant" sont créé pour ajouter de l'intéractivité, ainsi qu'un label invisible utilisé pour envoyer des messages d'erreur.

### **Étape 1 : Applications**

C'est sur cette page que l'utilisateur peut sélectionner ses applications via des checkboxs, la liste est généré à partir du document "array_names.ps1" et lorsqu'une application est sélectionné et que l'utilisateur appuie sur "Suivant", une boucle *for* récupère les index de chaque application et l'utilise pour récupérer les lignes de commandes associé au nom d'un programme, contenu dans le document "array_cmd.ps1".

### **Étape 2 : GLPI**

Ce tableau n'apparait que si GLPI à été sélectionné sur la première étape. L'utilisateur doit y indiquer l'adresse du serveur GLPI ainsi que le tag qui apparaitra dessus.

### **Étape 3 & 4 : Compte administrateur**

Sur cette étape, le script demande à l'utilisateur si il souhaite créer un compte possédant tous les droits sur l'ordinateur.

Si il répond non, le script passe immédiatement à l'étape finale.

Si il répond oui, le script demande le nom du compte, ainsi que le mot de passe et de confirmer ce dernier.

### **Étape 5 : Finalisation**

Cette étape montre à l'utilisateur toutes les applications qu'il a sélectionné, le tag et l'adresse du serveur GLPI (si il à été sélectionné), le nom et mot de passe du compte administrateur (si sélectionné) et enfin donne l'option de redémarrer l'ordinateur.

### **Fonction "Show-Step"**

L'objectif principal de cette fonction est de permettre la navigation entre différentes étapes, en cachant toutes le autres et montrant celle qui est nécessaire en fonction de l'index.
Cependant, il est également pour mettre à jour de manière dynamique le formulaire, comme pour bloquer le bouton "Précédent" ou "Suivant" sur certaines étapes, cacher ou mettre à jour certains éléments dans la mémoire du système.

### **Évènements Add_Click**

Les évènements Add_Click sont essentiellement ce qui permet de donner de l'intéractivité au document.

Adresse serveur GLPI : http://glpi.e-secure.fr:8086/glpi/

Lien de téléchargement de Firefox : https://download.mozilla.org/?product=firefox-latest&os=win64&lang=fr

