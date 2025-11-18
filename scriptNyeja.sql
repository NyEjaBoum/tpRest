CREATE TABLE Credit(
   id_credit INT,
   valeur INT NOT NULL,
   PRIMARY KEY(id_credit)
);

CREATE TABLE Semestre(
   id_semestre INT,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_semestre)
);

CREATE TABLE Filiere(
   id_filiere INT,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_filiere)
);

CREATE TABLE Session(
   id_session INT,
   PRIMARY KEY(id_session)
);

CREATE TABLE Annee_universitaire(
   id_annee INT,
   date_debut DATE NOT NULL,
   date_fin DATE NOT NULL,
   PRIMARY KEY(id_annee)
);

CREATE TABLE Etudiant(
   id_etudiant INT,
   matricule VARCHAR(50) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   date_inscription DATE NOT NULL,
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_etudiant),
   UNIQUE(matricule),
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre)
);

CREATE TABLE Matiere(
   id_matiere INT,
   libelle VARCHAR(50) NOT NULL,
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_matiere),
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre)
);

CREATE TABLE Note(
   id_note INT,
   valeur DECIMAL(15,2) NOT NULL,
   date_insertion VARCHAR(50),
   id_matiere INT NOT NULL,
   PRIMARY KEY(id_note),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere)
);

CREATE TABLE Inscription(
   id_inscription INT,
   id_etudiant INT NOT NULL,
   id_annee INT NOT NULL,
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_inscription),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_annee) REFERENCES Annee_universitaire(id_annee),
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre)
);

CREATE TABLE Matiere_Credit(
   id_matiere INT,
   id_credit INT,
   id_filiere INT,
   PRIMARY KEY(id_matiere, id_credit, id_filiere),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere),
   FOREIGN KEY(id_credit) REFERENCES Credit(id_credit),
   FOREIGN KEY(id_filiere) REFERENCES Filiere(id_filiere)
);


INSERT INTO Credit (id_credit, valeur) VALUES
(1, 6),
(2, 4),
(3, 2);

/* ---- Semestre ---- */
INSERT INTO Semestre (id_semestre, libelle) VALUES
(1, 'S1'),
(2, 'S2'),
(3, 'S3'),
(4, 'S4');

/* ---- Filiere ---- */
INSERT INTO Filiere (id_filiere, libelle) VALUES
(1, 'Informatique'),
(2, 'Design');

/* ---- Session ---- */
INSERT INTO Session VALUES
(1),
(2);

/* ---- Annee Universitaire ---- */
INSERT INTO Annee_universitaire VALUES
(1, '2023-09-01', '2024-07-01'),
(2, '2024-09-01', '2025-07-01');

/* ---- Etudiant ---- */
INSERT INTO Etudiant VALUES
(1, 'ETU003333', 'Diallo', 'Moussa', '2023-09-10', 1),
(2, 'ETU003334', 'Kone', 'Awa', '2023-09-15', 1),
(3, 'ETU003335', 'Traore', 'Sarah', '2023-09-12', 1),
(4, 'ETU003336', 'Barry', 'Idriss', '2023-09-18', 1);

/* ---- Matiere ---- */
-- S1
INSERT INTO Matiere VALUES
(1, 'Algorithmes', 1),
(2, 'Programmation 1', 1),
(3, 'Dessin artistique', 1),
(4, 'Histoire de l’art', 1);

-- S2
INSERT INTO Matiere VALUES
(5, 'Structures de données', 2),
(6, 'Programmation 2', 2),
(7, 'Couleurs & Composition', 2),
(8, 'Design numérique', 2);

-- S3
INSERT INTO Matiere VALUES
(9, 'Base de données', 3),
(10, 'Réseaux', 3),
(11, 'UX/UI avancé', 3),
(12, 'Illustration numérique', 3);

-- S4
INSERT INTO Matiere VALUES
(13, 'Développement Web', 4),
(14, 'Sécurité informatique', 4),
(15, '3D Modeling', 4),
(16, 'Motion Design', 4);

/* ---- Notes ---- */
INSERT INTO Note VALUES
-- S1
(1, 14.5, '2023-10-01', 1),
(2, 12.0, '2023-10-02', 2),
(3, 16.0, '2023-10-05', 3),
(4, 13.5, '2023-10-06', 4),

-- S2
(5, 15.0, '2024-02-10', 5),
(6, 11.0, '2024-02-11', 6),
(7, 17.0, '2024-02-12', 7),
(8, 14.0, '2024-02-15', 8),

-- S3
(9, 13.0, '2024-10-03', 9),
(10, 10.5, '2024-10-05', 10),
(11, 18.0, '2024-10-06', 11),
(12, 14.5, '2024-10-07', 12),

-- S4
(13, 15.5, '2025-03-12', 13),
(14, 12.5, '2025-03-14', 14),
(15, 19.0, '2025-03-15', 15),
(16, 16.0, '2025-03-17', 16);

/* ---- Inscription ---- */
INSERT INTO Inscription VALUES
-- Année 2023–2024
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),

(5, 1, 1, 2),
(6, 2, 1, 2),
(7, 3, 1, 2),
(8, 4, 1, 2),

-- Année 2024–2025
(9, 1, 2, 3),
(10, 2, 2, 3),
(11, 3, 2, 3),
(12, 4, 2, 3),

(13, 1, 2, 4),
(14, 2, 2, 4),
(15, 3, 2, 4),
(16, 4, 2, 4);

/* ---- Matiere - Credit - Filiere ---- */
INSERT INTO Matiere_Credit VALUES
-- Informatique
(1, 1, 1),
(2, 1, 1),
(5, 1, 1),
(6, 1, 1),
(9, 2, 1),
(10, 2, 1),
(13, 1, 1),
(14, 2, 1),

-- Design
(3, 1, 2),
(4, 1, 2),
(7, 2, 2),
(8, 2, 2),
(11, 1, 2),
(12, 2, 2),
(15, 3, 2),
(16, 3, 2);



docker exec -it mysql-tprest mysql -uroot -p
# puis tapez : test

# Copier le script puis l’importer (recommandé sous PowerShell)
docker cp ./scriptNyeja.sql mysql-tprest:/tmp/scriptNyeja.sql
docker exec -i mysql-tprest sh -c 'mysql -uroot -ptest notes_db < /tmp/scriptNyeja.sql'

SELECT n FROM Note n JOIN n.Matiere m WHERE m.semestre.idSemestre = 1