CREATE TYPE motif_visite AS ENUM ('reunion', 'entretien', 'livraison', 'autre');

CREATE TABLE visiteur (
	id SERIAL PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	prenom VARCHAR(50) NOT NULL,
	societe VARCHAR(50),
	FOREIGN KEY (employe_id) REFERENCES employe(id)
);

CREATE TABLE reception (
	id SERIAL PRIMARY KEY,
	date DATE NOT NULL,
	motif motif_visite NOT NULL,
	FOREIGN KEY (employe_id) REFERENCES employe(id),
	FOREIGN KEY (visiteur_id) REFERENCES visiteur(id)
);