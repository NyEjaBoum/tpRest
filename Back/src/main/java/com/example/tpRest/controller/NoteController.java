package com.example.tpRest.controller;

import com.example.tpRest.service.NoteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.tpRest.repository.NoteRepository;

import java.util.Map;

@RestController
@RequestMapping("/api/notes")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class NoteController {

    private final NoteService noteService;

    @Autowired
    private NoteRepository noteRepository;

    @GetMapping("/semestres/{id}")
    public ResponseEntity<Map<String, Object>> getNotesBySemestre(@PathVariable Integer id) {
        Map<String, Object> resp = noteService.getNotesBySemestre(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/annees/{id}")
    public ResponseEntity<Map<String, Object>> getNotesByAnnee(@PathVariable Integer id) {
        Map<String, Object> resp = noteService.getNotesByAnnee(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }
}
