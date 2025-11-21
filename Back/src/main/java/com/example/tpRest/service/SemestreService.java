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

    public Map<String, Object> getAllSemestres() {
        Map<String, Object> resp = new HashMap<>();
        try{
            List<Semestre> semestres = semestreRepository.findAll();
            resp.put("status", "success");
            resp.put("data", semestres);
            resp.put("error", null);
        } catch (Exception ex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_INTERNAL", "message", ex.getMessage()));
            return resp;
        }
        return resp;
         
    }

   public Map<String, Object> getEtudiantsWithMoyennesBySemestre(Integer semestreId) {
        Map<String, Object> resp = new HashMap<>();

        try {
            List<Etudiant> etudiants = etudiantRepository.findBySemestreIdSemestre(semestreId);
            List<Semestre> semestres = semestreRepository.findAll();

            List<Map<String, Object>> result = new ArrayList<>();

            for (Etudiant etu : etudiants) {
                Map<String, Object> map = new HashMap<>();
                map.put("etudiant", etu);

                for (Semestre s : semestres) {
                    Double moyenne = noteRepository.getMoyenneByEtudiantAndSemestre(
                            etu.getIdEtudiant(),
                            s.getIdSemestre()
                    );
                    map.put("moyenne_" + s.getLibelle(), moyenne);
                }

                result.add(map);
            }

            resp.put("status", "success");
            resp.put("data", result);
            resp.put("error", null);

        } catch (Exception ex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of(
                    "code", "E_INTERNAL",
                    "message", ex.getMessage()
            ));
        }

        return resp;
    }
}