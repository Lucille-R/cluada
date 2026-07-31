-- 1. La liste des employé·e·s avec le nom de leur service, triée par service puis par nom.
SELECT employe.nom, service.nom
FROM employe
JOIN service ON employe.service_id = service.id
ORDER BY service.nom, employe.nom;


-- 2. Le nombre d'employé·e·s par service.
SELECT service.nom, COUNT(employe.id) AS nb_employes
FROM service
JOIN employe ON employe.service_id = service.id
GROUP BY service.nom;


-- 3. Le chiffre d'affaires total de la machine à café sur la période, en euros.
SELECT ROUND((SUM(prix_centimes) / 100), 2) AS ca_total_euros
FROM transaction_cafe;


-- 4. Le nombre de cafés tirés par boisson — quelle est la boisson la plus populaire chez Adakor ?
SELECT boisson, COUNT(boisson)
FROM transaction_cafe
GROUP BY boisson
ORDER BY COUNT(boisson) DESC;


-- 5. Le montant dépensé en café par personne (nom, prénom, total en euros), du plus dépensier au moins dépensier.
SELECT employe.nom, employe.prenom, ROUND((SUM(transaction_cafe.prix_centimes) / 100), 2) AS montant_depense
FROM employe
LEFT JOIN transaction_cafe ON employe.id = transaction_cafe.employe_id
GROUP BY employe.nom, employe.prenom
ORDER BY montant_depense DESC;


-- 6. Les personnes qui tirent en moyenne plus de 4 cafés par jour de présence. Quelque chose te surprend ? Note-le en commentaire… puis va voir la question 7 avant de conclure.
WITH boisson AS (
	SELECT employe_id, COUNT(boisson) AS nb_boissons
	FROM transaction_cafe
	GROUP BY employe_id
),
presence AS (
	SELECT employe_id, COUNT(DISTINCT DATE(horodatage)) AS nb_jours
	FROM badgeage
	GROUP BY employe_id
)
SELECT employe.id, employe.nom, employe.prenom, (nb_boissons::NUMERIC / nb_jours) AS nb_moyen_boissons
FROM boisson
JOIN presence ON boisson.employe_id = presence.employe_id
JOIN employe ON employe.id = boisson.employe_id
WHERE (nb_boissons::NUMERIC / nb_jours) > 4;
-- Petit Marc est le seul à prendre > 4 boissons par jour, il en prend >9 ce qui peut parraître beaucoup.


-- 7. Pour la personne repérée en 6 : à quelles heures tire-t-elle ses cafés ? Toutes les boissons sont-elles pour elle ? (Indice : personne ne boit 4 cappuccinos ET 3 chocolats ET 2 thés par jour. Hypothèse plausible : elle badge pour tout son open space. Une anomalie n'est pas une preuve.)
SELECT *
FROM transaction_cafe
WHERE employe_id = 3;


-- 8. Tous les badgeages effectués après 21h, triés par date. Observe les sens : des sorties tardives, c'est normal. Et le reste ?
SELECT TO_CHAR(horodatage, 'YYYY-MM-DD') AS jour,
	TO_CHAR(horodatage, 'HH24:MI:SS') AS heure_badgeage, sens
FROM badgeage
WHERE TO_CHAR(horodatage, 'HH24:MI:SS') > '21:00:00'
ORDER BY TO_CHAR(horodatage, 'YYYY-MM-DD') ASC;


-- 9. Isole les entrées après 21h. Qui ? Quelle porte ? Quelles dates ?
SELECT employe_id, employe.nom, employe.prenom,
	TO_CHAR(horodatage, 'YYYY-MM-DD') AS jour,
	TO_CHAR(horodatage, 'HH24:MI:SS') AS heure_badgeage,
	sens, porte
FROM badgeage
JOIN employe ON badgeage.employe_id = employe.id
WHERE TO_CHAR(horodatage, 'HH24:MI:SS') > '21:00:00'
	AND sens = 'entree'
ORDER BY TO_CHAR(horodatage, 'YYYY-MM-DD') ASC;


-- 10. Cette personne était-elle censée être là ? Croise avec la table conge : liste les badgeages effectués par un·e employé·e pendant l'un de ses congés.
SELECT conge.employe_id, employe.nom, employe.prenom,
	conge.date_debut AS debut_conge,
	conge.date_fin AS fin_conge,
	conge.type,
	DATE(horodatage) AS jour_badgeage
FROM conge
JOIN badgeage ON badgeage.employe_id = conge.employe_id
JOIN employe ON employe.id = conge.employe_id
WHERE DATE(horodatage) BETWEEN conge.date_debut AND conge.date_fin;


-- 11. Le badge a aussi servi à la machine à café ces soirs-là. Prouve-le.
SELECT conge.employe_id, employe.nom, employe.prenom,
	conge.date_debut AS debut_conge,
	conge.date_fin AS fin_conge,
	conge.type,
	transaction_cafe.horodatage AS prise_boisson,
	transaction_cafe.boisson
FROM conge
JOIN transaction_cafe ON transaction_cafe.employe_id = conge.employe_id
JOIN employe ON employe.id = conge.employe_id
WHERE DATE(horodatage) BETWEEN conge.date_debut AND conge.date_fin


-- 12. La question à 1 million : qui était physiquement présent·e ces soirs-là ? Le badge de la porte peut s'emprunter… mais on vient en voiture avec son propre badge de parking. Croise les accès parking avec les horaires des badgeages suspects.
SELECT employe_id, employe.nom, employe.prenom, horodatage, sens
FROM acces_parking
JOIN employe ON acces_parking.employe_id = employe.id
WHERE DATE(horodatage) BETWEEN TO_DATE('2026-06-16', 'YYYY-MM-DD') AND TO_DATE('2026-06-18', 'YYYY-MM-DD')
	AND horodatage::TIME BETWEEN '21:00:00'::TIME AND '23:59:59'::TIME;
-- Weber Julien était présent ces soirs là. 


-- 13. Vérifie ton hypothèse : la personne suspectée a-t-elle badgé à une porte avec son propre badge ces soirs-là ? Que faisait-elle les jours en question (ses badgeages en journée) ?
SELECT employe_id, employe.nom, employe.prenom, horodatage, sens, porte
FROM badgeage
JOIN employe ON badgeage.employe_id = employe.id
WHERE employe_id = 16
	AND DATE(horodatage) BETWEEN TO_DATE('2026-06-16', 'YYYY-MM-DD') AND TO_DATE('2026-06-18', 'YYYY-MM-DD');



-- PHASE 3 : requêtes de vérification sur tables 'visiteur' et 'reception'
-- les visites avec le nom du/de la visiteur·se ET de l'employé·e qui reçoit :
SELECT reception.date AS date_visite,
	visiteur.nom AS nom_visiteur,
	visiteur.prenom AS prenom_visiteur,
	reception.motif AS motif_visite,
	employe.nom AS nom_employe
FROM reception
JOIN visiteur ON reception.visiteur_id = visiteur.id
JOIN employe ON reception.employe_id = employe.id;


-- le nombre de visites reçues par employé·e :
SELECT employe.nom AS nom_employe,
	COUNT(reception.id)
FROM reception
JOIN employe ON reception.employe_id = employe.id
GROUP BY employe.nom;