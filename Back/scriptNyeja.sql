DROP DATABASE IF EXISTS notes_db;
CREATE DATABASE notes_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE notes_db;

CREATE TABLE Credit(
   id_credit INT PRIMARY KEY,
   valeur INT NOT NULL
);

CREATE TABLE Semestre(
   id_semestre INT PRIMARY KEY,
   libelle VARCHAR(50) NOT NULL
);

CREATE TABLE Filiere(
   id_filiere INT PRIMARY KEY,
   libelle VARCHAR(50) NOT NULL
);

CREATE TABLE Session(
   id_session INT PRIMARY KEY
);

CREATE TABLE Annee_universitaire(
   id_annee INT PRIMARY KEY,
   date_debut DATE NOT NULL,
   date_fin DATE NOT NULL
);

CREATE TABLE Etudiant(
   id_etudiant INT PRIMARY KEY,
   matricule VARCHAR(50) NOT NULL UNIQUE,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   date_inscription DATE NOT NULL,
   id_semestre INT NOT NULL,
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre)
);

CREATE TABLE UE (
  id_ue INT PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE Matiere(
   id_matiere INT PRIMARY KEY,
   libelle VARCHAR(100) NOT NULL,
   id_semestre INT NOT NULL,
   id_ue INT,
   optionnel INT(1) DEFAULT 0,
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre),
   FOREIGN KEY(id_ue) REFERENCES UE(id_ue)
);

CREATE TABLE Inscription(
   id_inscription INT PRIMARY KEY,
   id_etudiant INT NOT NULL,
   id_annee INT NOT NULL,
   id_semestre INT NOT NULL,
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_annee) REFERENCES Annee_universitaire(id_annee),
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre)
);

CREATE TABLE Note(
   id_note INT PRIMARY KEY,
   valeur DECIMAL(15,2) NOT NULL,
   date_insertion VARCHAR(50),
   id_inscription INT NOT NULL,
   id_matiere INT NOT NULL,
   FOREIGN KEY(id_inscription) REFERENCES Inscription(id_inscription),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere)
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

/* ===== Données réalistes pour la base notes_db ===== */

/* Credits */
INSERT INTO Credit (id_credit, valeur) VALUES
(1, 6),
(2, 4),
(3, 2);

/* Semestres */
INSERT INTO Semestre (id_semestre, libelle) VALUES
(1, 'S1'),
(2, 'S2'),
(3, 'S3'),
(4, 'S4');

/* Filières */
INSERT INTO Filiere (id_filiere, libelle) VALUES
(1, 'Informatique'),
(2, 'Design'),
(3, 'Reseau Telecom');

/* Sessions */
INSERT INTO Session (id_session) VALUES
(1),
(2);

/* Années universitaires */
INSERT INTO Annee_universitaire (id_annee, date_debut, date_fin) VALUES
(1, '2023-09-01', '2024-07-01'),
(2, '2024-09-01', '2025-07-01');

/* Étudiants */
INSERT INTO Etudiant (id_etudiant, matricule, nom, prenom, date_inscription, id_semestre) VALUES
(1, 'ETU2023001', 'Diallo', 'Moussa', '2023-09-10', 1),
(2, 'ETU2023002', 'Kone', 'Awa', '2023-09-15', 1),
(3, 'ETU2023003', 'Traore', 'Sarah', '2023-09-12', 1),
(4, 'ETU2023004', 'Barry', 'Idriss', '2023-09-18', 1);

/* UE pour chaque semestre et parcours */
INSERT INTO UE (id_ue, libelle) VALUES
(1, 'UE Informatique S1'),
(2, 'UE Math S1'),
(3, 'UE Communication S1'),
(4, 'UE Informatique S2'),
(5, 'UE Math S2'),
(6, 'UE Informatique S3'),
(7, 'UE Math S3'),
(8, 'UE Gestion S3'),
(9, 'UE Option Informatique S4'),
(10, 'UE Option Math S4'),
(11, 'UE Projet S4'),
(12, 'UE Web S4');

/* Matières S1 */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(1, 'INF101 Programmation procedurale', 1, 1, 0),
(2, 'INF104 HTML et Introduction au Web', 1, 1, 0),
(3, 'INF107 Informatique de Base', 1, 1, 0),
(4, 'MTH101 Arithmetique et nombres', 1, 2, 0),
(5, 'MTH102 Analyse mathematique', 1, 2, 0),
(6, 'ORG101 Techniques de communication', 1, 3, 0);

/* Matières S2 */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(7, 'INF102 Bases de donnees relationnelles', 2, 4, 0),
(8, 'INF103 Bases de administration systeme', 2, 4, 0),
(9, 'INF105 Maintenance materiel et logiciel', 2, 4, 0),
(10, 'INF106 Complements de programmation', 2, 4, 0),
(11, 'MTH103 Calcul vectoriel et matriciel', 2, 5, 0),
(12, 'MTH105 Probabilite et Statistique', 2, 5, 0);

/* Matières S3 */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(13, 'INF201 Programmation orientee objet', 3, 6, 0),
(14, 'INF202 Bases de donnees objets', 3, 6, 0),
(15, 'INF203 Programmation systeme', 3, 6, 0),
(16, 'INF208 Reseaux informatiques', 3, 6, 0),
(17, 'MTH201 Methodes numeriques', 3, 7, 0),
(18, 'ORG201 Bases de gestion', 3, 8, 0);

/* Matières S4 - Parcours Developpement (optionnelles marquées par 1) */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(19, 'INF204 Systeme information geographique', 4, 9, 1),
(20, 'INF205 Systeme information', 4, 9, 1),
(21, 'INF206 Interface Homme Machine', 4, 9, 1),
(22, 'INF207 Elements algorithmique', 4, 9, 0),
(23, 'INF210 Mini projet developpement', 4, 11, 0),
(24, 'MTH204 Geometrie', 4, 10, 1),
(25, 'MTH205 Equations differentielles', 4, 10, 1),
(26, 'MTH206 Optimisation', 4, 10, 1),
(27, 'MTH203 MAO', 4, 10, 0);

/* Matières S4 - Parcours BDR (optionnelles marquées par 1) */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(28, 'INF205 Systeme information', 4, 9, 0),
(29, 'INF204 Systeme information geographique', 4, 9, 1),
(30, 'INF206 Interface Homme Machine', 4, 9, 1),
(31, 'INF207 Elements algorithmique', 4, 9, 1),
(32, 'INF211 Mini projet bases de donnees et reseaux', 4, 11, 0),
(33, 'MTH202 Analyse des donnees', 4, 10, 1),
(34, 'MTH205 Equations differentielles', 4, 10, 1),
(35, 'MTH206 Optimisation', 4, 10, 1),
(36, 'MTH203 MAO', 4, 10, 0);

/* Matières S4 - Parcours Web et Design (optionnelles marquées par 1) */
INSERT INTO Matiere (id_matiere, libelle, id_semestre, id_ue, optionnel) VALUES
(37, 'INF204 Systeme information geographique', 4, 12, 1),
(38, 'INF205 Systeme information', 4, 12, 1),
(39, 'INF206 Interface Homme Machine', 4, 12, 1),
(40, 'INF209 Web dynamique', 4, 12, 0),
(41, 'INF212 Mini projet Web et design', 4, 12, 0),
(42, 'MTH202 Analyse des donnees', 4, 10, 1),
(43, 'MTH204 Geometrie', 4, 10, 1),
(44, 'MTH206 Optimisation', 4, 10, 1),
(45, 'MTH203 MAO', 4, 10, 0);

/* Inscriptions (exemple pour S1 à S4, étudiants 1 à 4) */
INSERT INTO Inscription (id_inscription, id_etudiant, id_annee, id_semestre) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 1, 1, 2),
(6, 2, 1, 2),
(7, 3, 1, 2),
(8, 4, 1, 2),
(9, 1, 1, 3),
(10,2, 1, 3),
(11,3, 1, 3),
(12,4, 1, 3),
(13,1, 1, 4),
(14,2, 1, 4),
(15,3, 1, 4),
(16,4, 1, 4);

/* Notes (exemple pour S1 à S4, étudiants 1 à 4, matières principales) */
/* Notes S1 (id_matiere 1 à 6) */
INSERT INTO Note (id_note, valeur, date_insertion, id_inscription, id_matiere) VALUES
(1, 14.5, '2023-10-01', 1, 1),
(2, 12.0, '2023-10-02', 1, 2),
(3, 16.0, '2023-10-03', 1, 3),
(4, 13.5, '2023-10-04', 1, 4),
(5, 15.0, '2023-10-05', 1, 5),
(6, 11.0, '2023-10-06', 1, 6),

(7, 13.0, '2023-10-01', 2, 1),
(8, 10.0, '2023-10-02', 2, 2),
(9, 15.0, '2023-10-03', 2, 3),
(10, 12.5, '2023-10-04', 2, 4),
(11, 14.0, '2023-10-05', 2, 5),
(12, 13.0, '2023-10-06', 2, 6),

(13, 16.5, '2023-10-01', 3, 1),
(14, 13.0, '2023-10-02', 3, 2),
(15, 14.0, '2023-10-03', 3, 3),
(16, 15.5, '2023-10-04', 3, 4),
(17, 12.0, '2023-10-05', 3, 5),
(18, 14.0, '2023-10-06', 3, 6),

(19, 15.0, '2023-10-01', 4, 1),
(20, 14.0, '2023-10-02', 4, 2),
(21, 13.0, '2023-10-03', 4, 3),
(22, 12.5, '2023-10-04', 4, 4),
(23, 13.0, '2023-10-05', 4, 5),
(24, 15.0, '2023-10-06', 4, 6);

/* Notes S2 (id_matiere 7 à 12) */
INSERT INTO Note (id_note, valeur, date_insertion, id_inscription, id_matiere) VALUES
(25, 14.0, '2024-02-01', 5, 7),
(26, 13.5, '2024-02-02', 5, 8),
(27, 15.0, '2024-02-03', 5, 9),
(28, 12.0, '2024-02-04', 5, 10),
(29, 16.0, '2024-02-05', 5, 11),
(30, 13.0, '2024-02-06', 5, 12),

(31, 12.5, '2024-02-01', 6, 7),
(32, 14.0, '2024-02-02', 6, 8),
(33, 13.0, '2024-02-03', 6, 9),
(34, 15.5, '2024-02-04', 6, 10),
(35, 14.0, '2024-02-05', 6, 11),
(36, 12.0, '2024-02-06', 6, 12),

(37, 13.0, '2024-02-01', 7, 7),
(38, 15.0, '2024-02-02', 7, 8),
(39, 14.5, '2024-02-03', 7, 9),
(40, 13.0, '2024-02-04', 7, 10),
(41, 15.0, '2024-02-05', 7, 11),
(42, 14.0, '2024-02-06', 7, 12),

(43, 14.5, '2024-02-01', 8, 7),
(44, 13.0, '2024-02-02', 8, 8),
(45, 12.0, '2024-02-03', 8, 9),
(46, 15.0, '2024-02-04', 8, 10),
(47, 13.5, '2024-02-05', 8, 11),
(48, 14.0, '2024-02-06', 8, 12);

/* Notes S3 (id_matiere 13 à 18) */
INSERT INTO Note (id_note, valeur, date_insertion, id_inscription, id_matiere) VALUES
(49, 15.0, '2024-06-01', 9, 13),
(50, 14.0, '2024-06-02', 9, 14),
(51, 13.5, '2024-06-03', 9, 15),
(52, 16.0, '2024-06-04', 9, 16),
(53, 15.5, '2024-06-05', 9, 17),
(54, 14.0, '2024-06-06', 9, 18),

(55, 13.0, '2024-06-01', 10, 13),
(56, 15.0, '2024-06-02', 10, 14),
(57, 14.0, '2024-06-03', 10, 15),
(58, 13.5, '2024-06-04', 10, 16),
(59, 12.0, '2024-06-05', 10, 17),
(60, 15.0, '2024-06-06', 10, 18),

(61, 14.5, '2024-06-01', 11, 13),
(62, 13.0, '2024-06-02', 11, 14),
(63, 15.0, '2024-06-03', 11, 15),
(64, 14.0, '2024-06-04', 11, 16),
(65, 13.5, '2024-06-05', 11, 17),
(66, 15.0, '2024-06-06', 11, 18),

(67, 13.0, '2024-06-01', 12, 13),
(68, 14.0, '2024-06-02', 12, 14),
(69, 15.5, '2024-06-03', 12, 15),
(70, 13.0, '2024-06-04', 12, 16),
(71, 14.0, '2024-06-05', 12, 17),
(72, 15.0, '2024-06-06', 12, 18);

/* Notes S4 (id_matiere 19 à 27) */
INSERT INTO Note (id_note, valeur, date_insertion, id_inscription, id_matiere) VALUES
(73, 14.0, '2024-10-01', 13, 19),
(74, 13.5, '2024-10-02', 13, 20),
(75, 15.0, '2024-10-03', 13, 21),
(76, 12.0, '2024-10-04', 13, 22),
(77, 16.0, '2024-10-05', 13, 23),
(78, 13.0, '2024-10-06', 13, 24),
(79, 15.0, '2024-10-07', 13, 25),
(80, 14.5, '2024-10-08', 13, 26),
(81, 13.0, '2024-10-09', 13, 27),

(82, 13.0, '2024-10-01', 14, 19),
(83, 14.0, '2024-10-02', 14, 20),
(84, 12.5, '2024-10-03', 14, 21),
(85, 15.0, '2024-10-04', 14, 22),
(86, 13.5, '2024-10-05', 14, 23),
(87, 14.0, '2024-10-06', 14, 24),
(88, 15.0, '2024-10-07', 14, 25),
(89, 13.0, '2024-10-08', 14, 26),
(90, 14.5, '2024-10-09', 14, 27),

(91, 15.0, '2024-10-01', 15, 19),
(92, 14.0, '2024-10-02', 15, 20),
(93, 13.0, '2024-10-03', 15, 21),
(94, 15.5, '2024-10-04', 15, 22),
(95, 14.0, '2024-10-05', 15, 23),
(96, 13.5, '2024-10-06', 15, 24),
(97, 15.0, '2024-10-07', 15, 25),
(98, 14.0, '2024-10-08', 15, 26),
(99, 13.0, '2024-10-09', 15, 27),

(100, 14.5, '2024-10-01', 16, 19),
(101, 13.0, '2024-10-02', 16, 20),
(102, 15.0, '2024-10-03', 16, 21),
(103, 14.0, '2024-10-04', 16, 22),
(104, 13.5, '2024-10-05', 16, 23),
(105, 15.0, '2024-10-06', 16, 24),
(106, 14.0, '2024-10-07', 16, 25),
(107, 13.0, '2024-10-08', 16, 26),
(108, 15.5, '2024-10-09', 16, 27);

/* Matiere - Credit - Filiere (exemple) */
INSERT INTO Matiere_Credit (id_matiere, id_credit, id_filiere) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 3, 2),
(5, 1, 1),
(6, 1, 1),
(7, 2, 3),
(8, 3, 1),
(9, 1, 1),
(10,2, 3),
(11,1, 1),
(12,2, 1),
(13,1, 1),
(14,2, 1),
(15,1, 1),
(16,1, 1);