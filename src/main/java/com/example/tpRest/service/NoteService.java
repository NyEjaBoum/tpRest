package com.example.tpRest.service;

import com.example.tpRest.dto.*;
import com.example.tpRest.model.Note;
import com.example.tpRest.repository.NoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class NoteService {

    private final NoteRepository noteRepository;

    public Map<String, Object> getNotesBySemestre(Integer semestreId) {
        List<Note> notes = noteRepository.findNotesBySemestreId(semestreId);
        if (notes == null || notes.isEmpty()) {
            Map<String, Object> resp = new HashMap<>();
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", "Aucune note trouvée pour ce semestre");
            return resp;
        }

        NoteSemestreDto dto = new NoteSemestreDto();
        dto.setSemestreLibelle(notes.get(0).getMatiere().getSemestre().getLibelle());
        dto.setTotalNotes(notes.size());
        dto.setNotes(notes.stream().map(this::toNoteDto).collect(Collectors.toList()));

        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "success");
        resp.put("data", dto);
        resp.put("error", null);
        return resp;
    }

    public Map<String, Object> getNotesByAnnee(Integer anneeId) {
        List<Note> notes = noteRepository.findNotesByAnneeId(anneeId);
        if (notes == null || notes.isEmpty()) {
            Map<String, Object> resp = new HashMap<>();
            resp.put("status", "error");
            resp.put("data", null);
            resp.put("error", "Aucune note trouvée pour cette année");
            return resp;
        }

        Map<Object, List<Note>> grouped = notes.stream()
            .collect(Collectors.groupingBy(n -> n.getMatiere().getSemestre().getLibelle()));

        List<NoteSemestreDto> semestres = grouped.entrySet().stream().map(e -> {
            NoteSemestreDto s = new NoteSemestreDto();
            s.setSemestreLibelle((String) e.getKey());
            s.setNotes(e.getValue().stream().map(this::toNoteDto).collect(Collectors.toList()));
            s.setTotalNotes(e.getValue().size());
            return s;
        }).collect(Collectors.toList());

        NoteAnneeDto result = new NoteAnneeDto();
        result.setAnneeLibelle("Annee " + anneeId);
        result.setSemestres(semestres);
        result.setTotalNotes(notes.size());

        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "success");
        resp.put("data", result);
        resp.put("error", null);
        return resp;
    }

    private NoteDto toNoteDto(Note n) {
        NoteDto dto = new NoteDto();
        dto.setIdNote(n.getIdNote());
        dto.setValeur(n.getValeur());
        dto.setDateInsertion(n.getDateInsertion());
        dto.setMatiereLibelle(n.getMatiere().getLibelle());
        dto.setSemestreLibelle(n.getMatiere().getSemestre().getLibelle());
        return dto;
    }
}
