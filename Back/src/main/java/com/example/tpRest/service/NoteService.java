package com.example.tpRest.service;

import com.example.tpRest.model.Note;
import com.example.tpRest.repository.NoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class NoteService {

    private final NoteRepository noteRepository;

    public Map<String, Object> getNotesBySemestre(Integer semestreId) {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Note> notes = noteRepository.findNotesBySemestreId(semestreId);
            if (notes == null || notes.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Aucune note trouvée pour ce semestre"));
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

    public Map<String, Object> getNotesByAnnee(Integer anneeId) {
        Map<String, Object> resp = new HashMap<>();
        try {
            List<Note> notes = noteRepository.findNotesByAnneeId(anneeId);
            if (notes == null || notes.isEmpty()) {
                resp.put("status", "error");
                resp.put("data", null);
                resp.put("error", Map.of("code", "E_NOT_FOUND", "message", "Aucune note trouvée pour cette année"));
                return resp;
            }

            Map<String, List<Note>> grouped = notes.stream()
                .collect(Collectors.groupingBy(n -> n.getMatiere().getSemestre().getLibelle()));

            resp.put("status", "success");
            resp.put("data", grouped);
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
