INSERT INTO visiteur (id, nom, prenom, societe) VALUES
(1, 'Alison', 'Flisson', 'Livrvite'),
(2, 'Remy', 'Femy', 'Francetravail'),
(3, 'Aurélie', 'Folie', 'Myrh'),
(4, 'Julien', 'Jesouss', 'Tentretien'),
(5, 'Marin', 'Martin', 'Travailfrance');

INSERT INTO reception (id, date, motif, employe_id, visiteur_id) VALUES
(1, '2026-05-11', 'livraison', 32, 1),
(2, '2026-05-12', 'entretien', 22, 2),
(3, '2026-05-17', 'livraison', 32, 1),
(4, '2026-05-19', 'entretien', 22, 2),
(5, '2026-05-21', 'reunion', 22, 3),
(6, '2026-06-03', 'entretien', 2, 2),
(7, '2026-06-03', 'livraison', 32, 1),
(8, '2026-06-11', 'entretien', 23, 2),
(9, '2026-06-17', 'autre', 16, 4),
(10, '2026-06-25', 'autre', 7, 5);