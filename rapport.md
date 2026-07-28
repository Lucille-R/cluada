# CLUADA - Audit & Enquête

### Contexte
Adakor est une société de conseil de 35 salarié·e·s installée à Montreuil.
Dans son immeuble, tout fonctionne au badge nominatif : la porte principale, la porte arrière, le parking ainsi que la machine à café. Chaque passage de badge laisse alors une trace dans la base de données.

La direction d'Adakor a commandité un audit des usages du bâtiment : fréquentation, horaires, consommation de café.
Il s'agit d'un état des lieux chiffré, sur les 8 dernières semaines.

### Méthode
Analyse par requêtes SQL sur la base de donnée d'Adakor, exécutées via VS Code (extension PostgreSQL) dans un environnement Docker.

## Etat des lieux
Quelques requêtes basiques ont été effectuées. En voici la liste, avec leur numéro respectif :  
1- La liste des employé·e·s avec le nom de leur service, triée par service puis par nom  
2- Le nombre d'employé·e·s par service  
3- Le chiffre d'affaires total de la machine à café sur la période (en €)  
4- Le nombre de cafés tirés par boisson :  
***On remarque ici que l'espresso est la boisson la plus plébiscitée.***  
5- Le montant dépensé en café par personne (en €) :  
***Pour l'ensemble des employés, le montant dépensé sur la période va de 14€ à 28€. Un seul employé a un montant de depense très significativement plus élevé (143 €).***  
6- Les personnes qui tirent en moyenne plus de 4 cafés par jour de présence :  
***Cette requête fait apparaître un seul employé prenant plus de 4 boissons en moyenne par jour de présence : l'employé dont l'id est le numéro 3 prend en moyenne plus de 9 boissons.***  
8- Tous les badgeages effectués après 21h, triés par date  


## Les anomalies
### Nombre de boissons journalières
Suite au résultat de la requête "6" une requête complémentaire "7" a été effectuée afin de connaître les heures auxquelles les boissons ont été prises par l'employé concerné.  
>*Ainsi, le badge a été utilisé pour des boissons très variées et à des horaires paraissant incompatibles avec un usage individuel.*

### Le badgeage en soirée
Suite au résultat de la requête "8" faisant apparaître des badgeages tardifs (après 21h) une requête complémentaire a été effectuée :  
9- Seulement les badgeages en "entrée", après 21h, indiquant les informations suivantes : id, nom et prénom de l'employé ; jour et heure du badgeage ; porte concernée.  
***Une seule employée (Nadia Benali) est alors concernée par des badgeages tardifs. Ces derniers ont été réalisés sur la porte arrière du bâtiment***  

Grâce à la requête "10", nous avons croisé les tables **badgeage** et **conge** afin de vérifier si des badgeages ont été effectués sur les périodes d'absences de ces mêmes employés.  
***Ainsi, l'employée dont le badge a été utilisé en entrée après 21h, était en réalité en congé (CP) à cette même période***

La requête "11" nous a appris que des boissons ont été prises sur ces mêmes périodes et horaires tardifs (2 espresso par soir), également par le badge de Nadia Benali.

Nous avons cherché à savoir si une autre personne était présente ces soirs-là grâce aux accès parking (requête "12") :  
***En effet, le badge parking de l'employé Julien Weber fait apparaître des horodatages sur les périodes et horaires concernés***

Enfin, la requête "13" nous a permis de constater que cet employé (Julien Weber) a utilisé son propre badge sur l'entrée principale aux horaires dits "de journée" sur cette même période (du 16 au 18 juin 2026).

## Conclusion
Ces observations amènent à recommander un rappel auprès des employés sur le caractère strictement personnel du badge, quel que soit son usage (accès aux locaux, machine à café).