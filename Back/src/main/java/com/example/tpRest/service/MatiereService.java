package com.example.tpRest.service;

import com.example.tpRest.model.Matiere;
import com.example.tpRest.model.Note;
import com.example.tpRest.repository.MatiereRepository;
import com.example.tpRest.repository.NoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MatiereService {

    private final MatiereRepository matiereRepository;
    private final NoteRepository noteRepository;

    public Map<String, Object> getMatiere(Integer id) {
        Map<String, Object> resp = new HashMap<>();
        try {
            Matiere m = matiereRepository.findById(id).orElse(null);
            if (m == null) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Matiere non trouvée"));
                return resp;
            }
            resp.put("status", "success");
            resp.put("data", m);
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

    public Map<String, Object> getNotesByMatiere(Integer id) {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Note> notes = noteRepository.findNotesByMatiereId(id);
            if (notes == null || notes.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Aucune note trouvée pour cette matiere"));
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
