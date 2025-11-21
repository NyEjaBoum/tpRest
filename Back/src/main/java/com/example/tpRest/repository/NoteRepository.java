package com.example.tpRest.repository;

import com.example.tpRest.model.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoteRepository extends JpaRepository<Note, Integer> {

    @Query("SELECT n FROM Note n JOIN n.matiere m WHERE m.semestre.idSemestre = :semestreId")
    List<Note> findNotesBySemestreId(@Param("semestreId") Integer semestreId);

    @Query("SELECT DISTINCT n FROM Note n JOIN n.matiere m, Inscription i WHERE i.semestre = m.semestre AND i.anneeUniversitaire.idAnnee = :anneeId")
    List<Note> findNotesByAnneeId(@Param("anneeId") Integer anneeId);

    @Query("SELECT n FROM Note n JOIN n.matiere m WHERE m.idMatiere = :matiereId")
    List<Note> findNotesByMatiereId(@Param("matiereId") Integer matiereId);

    @Query("SELECT DISTINCT n FROM Note n " +
        "JOIN n.matiere m " +
        "JOIN Inscription i ON i.semestre = m.semestre AND i.etudiant.idEtudiant = :etudiantId " +
        "WHERE i.etudiant.idEtudiant = :etudiantId")
    List<Note> findNotesByEtudiantId(@Param("etudiantId") Integer etudiantId);
    @Query("""
    SELECT n FROM Note n
    JOIN n.inscription i
    WHERE i.etudiant.idEtudiant = :etudiantId
      AND i.semestre.idSemestre = :semestreId
""")
List<Note> findNotesByEtudiantAndSemestre(@Param("etudiantId") Integer etudiantId, @Param("semestreId") Integer semestreId);

@Query("""
    SELECT AVG(n.valeur) FROM Note n
    JOIN n.inscription i
    WHERE i.etudiant.idEtudiant = :etudiantId
      AND i.semestre.idSemestre = :semestreId
""")
Double getMoyenneByEtudiantAndSemestre(@Param("etudiantId") Integer etudiantId, @Param("semestreId") Integer semestreId);

}
