Etudiant(idEtudiant,Nom,Prenom,DateNaissance,NumeroInscription)

classe(idClasse,Libelle)

semestre(idSemestre,idClasse,nomSemestre,dateDebut,dateFin)

RelationSemestreEtudiant(idRelationSemestreEtudiant,idEtudiant,idSemestre)

UE(idUE,Libelle)

Optionnel(idOptionnel,Libelle)

matiereIntituler(idMatiereIntituler,idUE,idOptionnel,credit)

Mention(idMention,Libelle)

Resultat(idResultat,Libelle)

Datesession(idDateSession,DateSession)

Qualification(idQualification,Libelle)

ReleveNote(idRelevenote,idRelationSemestreEtudiant,idMatiereIntituler,Note,idResultat,idDateSession)

ResultatNote(idResultatNote,idEtudiant,idMention,credit,Moyenne,idQualification,idDateSession)