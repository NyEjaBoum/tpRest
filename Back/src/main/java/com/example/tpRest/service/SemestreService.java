package com.example.tpRest.service;

import com.example.tpRest.model.Etudiant;
import com.example.tpRest.model.Semestre;
import com.example.tpRest.repository.EtudiantRepository;
import com.example.tpRest.repository.NoteRepository;
import com.example.tpRest.repository.SemestreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class SemestreService {

    private final SemestreRepository semestreRepository;
    private final EtudiantRepository etudiantRepository;
    private final NoteRepository noteRepository;

    public List<Semestre> getAllSemestres() {
        return semestreRepository.findAll();
    }

    public List<Map<String, Object>> getEtudiantsWithMoyennesBySemestre(Integer semestreId) {
        List<Etudiant> etudiants = etudiantRepository.findBySemestreIdSemestre(semestreId);
        List<Map<String, Object>> result = new ArrayList<>();
        List<Semestre> semestres = semestreRepository.findAll();
        for (Etudiant etu : etudiants) {
            Map<String, Object> map = new HashMap<>();
            map.put("etudiant", etu);
            for (Semestre s : semestres) {
                Double moyenne = noteRepository.getMoyenneByEtudiantAndSemestre(etu.getIdEtudiant(), s.getIdSemestre());
                map.put("moyenne_" + s.getLibelle(), moyenne);
            }
            result.add(map);
        }
        return result;
    }
}