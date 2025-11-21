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

CREATE TABLE UE (
  id_ue INT PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
);

CREATE TABLE Matiere(
   id_matiere INT,
   libelle VARCHAR(50) NOT NULL,
   id_semestre INT NOT NULL,
   id_ue INT,
   optionnel INT(1) DEFAULT 0,
   PRIMARY KEY(id_matiere),
   FOREIGN KEY(id_semestre) REFERENCES Semestre(id_semestre),
   FOREIGN KEY(id_ue) REFERENCES UE(id_ue)
);

-- ALTER TABLE Matiere
--   ADD COLUMN id_ue INT,
--   ADD COLUMN optionnel TINYINT(1) DEFAULT 0,
--   ADD FOREIGN KEY(id_ue) REFERENCES UE(id_ue);

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
(3, 'Réseau & Télécom');

/* Sessions */
INSERT INTO Session (id_session) VALUES
(1),
(2);

/* Années universitaires */
INSERT INTO Annee_universitaire (id_annee, date_debut, date_fin) VALUES
(1, '2023-09-01', '2024-07-01'),
(2, '2024-09-01', '2025-07-01');

/* Étudiants (matricules réalistes, dates d'inscription plausibles) */
INSERT INTO Etudiant (id_etudiant, matricule, nom, prenom, date_inscription, id_semestre) VALUES
(1, 'ETU2023001', 'Diallo', 'Moussa', '2023-09-10', 1),
(2, 'ETU2023002', 'Kone', 'Awa', '2023-09-15', 1),
(3, 'ETU2023003', 'Traore', 'Sarah', '2023-09-12', 1),
(4, 'ETU2023004', 'Barry', 'Idriss', '2023-09-18', 1),
(5, 'ETU2024001', 'Nguyen', 'Linh', '2024-09-05', 3),
(6, 'ETU2024002', 'Martin', 'Paul', '2024-09-06', 3),
(7, 'ETU2024003', 'Moreau', 'Chloe', '2024-09-08', 3),
(8, 'ETU2024004', 'Sow', 'Fatou', '2024-09-09', 4),
(9, 'ETU2023005', 'Camara', 'Abdoulaye', '2023-09-11', 2),
(10,'ETU2023006', 'Bamba', 'Aminata', '2023-09-14', 2);

/* Matières (associe chaque matière à un semestre) */
/* S1 */
INSERT INTO Matiere (id_matiere, libelle, id_semestre) VALUES
(1, 'Algorithmes', 1),
(2, 'Programmation 1', 1),
(3, 'Mathématiques discrètes', 1),
(4, 'Anglais technique', 1),
/* S2 */
(5, 'Structures de données', 2),
(6, 'Programmation 2', 2),
(7, 'Architecture des ordinateurs', 2),
(8, 'Projet encadré 1', 2),
/* S3 */
(9, 'Base de données', 3),
(10,'Réseaux', 3),
(11,'Systèmes d’exploitation', 3),
(12,'Sécurité informatique', 3),
/* S4 */
(13,'Développement Web', 4),
(14,'Cloud & DevOps', 4),
(15,'IA & Machine Learning', 4),
(16,'Projet de fin d\'études', 4);

/* Notes (valeurs plausibles 0-20, dates d'insertion réalistes) */
/* Quelques notes par matière */
INSERT INTO Note (id_note, valeur, date_insertion, id_matiere) VALUES
(1, 14.5, '2023-10-01', 1),
(2, 12.0, '2023-10-02', 2),
(3, 16.0, '2023-10-05', 3),
(4, 13.5, '2023-10-06', 4),
(5, 15.0, '2024-02-10', 5),
(6, 11.0, '2024-02-11', 6),
(7, 17.0, '2024-02-12', 7),
(8, 14.0, '2024-02-15', 8),
(9, 13.0, '2024-10-03', 9),
(10, 10.5, '2024-10-05', 10),
(11, 18.0, '2024-10-06', 11),
(12, 14.5, '2024-10-07', 12),
(13, 15.5, '2025-03-12', 13),
(14, 12.5, '2025-03-14', 14),
(15, 19.0, '2025-03-15', 15),
(16, 16.0, '2025-03-17', 16),
(17, 9.0, '2023-11-01', 2),
(18, 17.5, '2023-11-02', 1),
(19, 8.0, '2024-03-01', 6),
(20, 13.2, '2024-03-05', 5),
(21, 15.8, '2024-11-10', 9),
(22, 11.4, '2024-11-12', 10),
(23, 16.7, '2025-04-01', 13),
(24, 14.9, '2025-04-03', 15),
(25, 12.0, '2023-12-01', 4),
(26, 18.5, '2024-02-20', 7),
(27, 10.0, '2024-10-10', 12),
(28, 17.0, '2025-03-20', 16),
(29, 13.7, '2024-11-20', 8),
(30, 9.5, '2023-11-15', 3),
(31, 14.2, '2025-03-25', 14),
(32, 12.6, '2024-02-25', 5);

/* Inscriptions (étudiant - année - semestre) */
/* On inscrit chaque étudiant sur les années et semestres correspondants */
INSERT INTO Inscription (id_inscription, id_etudiant, id_annee, id_semestre) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 9, 1, 2),
(6, 10,1, 2),
(7, 1, 1, 2),
(8, 2, 1, 2),

(9, 5, 2, 3),
(10,6, 2, 3),
(11,7, 2, 3),
(12,8, 2, 4),
(13,5, 2, 4),
(14,6, 2, 4);

/* Matiere - Credit - Filiere (liaisons réalistes) */
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
(16,1, 1); -- si nécessaire, adapte credit 8 ou remplace
