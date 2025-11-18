package com.example.tpRest.repository;

import com.example.tpRest.model.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Integer> {
    List<Etudiant> findBySemestreIdSemestre(Integer semestreId);
}
