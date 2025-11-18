package com.example.tpRest.service;

import com.example.tpRest.model.Etudiant;
import com.example.tpRest.model.Note;
import com.example.tpRest.repository.EtudiantRepository;
import com.example.tpRest.repository.NoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class EtudiantService {

    private final EtudiantRepository etudiantRepository;
    private final NoteRepository noteRepository;

    public Map<String, Object> getAllEtudiants() {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Etudiant> data = etudiantRepository.findAll();
            if (data == null || data.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Aucun etudiant trouvé"));
                return resp;
            }
            resp.put("status", "success");
            resp.put("data", data);
            resp.put("error", null);
            return resp;
        } catch (DataAccessException dex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_DB_CONN", "message", "Problème base de données: " + dex.getMessage()));
            return resp;
        } catch (Exception ex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_INTERNAL", "message", "Erreur interne: " + ex.getMessage()));
            return resp;
        }
    }

    public Map<String, Object> getEtudiantsBySemestre(Integer semestreId) {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Etudiant> data = etudiantRepository.findBySemestreIdSemestre(semestreId);
            if (data == null || data.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Aucun etudiant trouvé pour ce semestre"));
                return resp;
            }
            resp.put("status", "success");
            resp.put("data", data);
            resp.put("error", null);
            return resp;
        } catch (DataAccessException dex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_DB_CONN", "message", "Problème base de données: " + dex.getMessage()));
            return resp;
        } catch (Exception ex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_INTERNAL", "message", "Erreur interne: " + ex.getMessage()));
            return resp;
        }
    }

    public Map<String, Object> getNotesByEtudiant(Integer etudiantId) {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Note> notes = noteRepository.findNotesByEtudiantId(etudiantId);
            if (notes == null || notes.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Etudiant ou notes introuvables"));
                return resp;
            }
            resp.put("status", "success");
            resp.put("data", notes);
            resp.put("error", null);
            return resp;
        } catch (DataAccessException dex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_DB_CONN", "message", "Problème base de données: " + dex.getMessage()));
            return resp;
        } catch (Exception ex) {
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", Map.of("code", "E_INTERNAL", "message", "Erreur interne: " + ex.getMessage()));
            return resp;
        }
    }
}
