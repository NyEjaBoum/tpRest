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
