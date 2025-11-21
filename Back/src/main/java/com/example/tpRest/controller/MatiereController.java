package com.example.tpRest.controller;

import com.example.tpRest.service.MatiereService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/matieres")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class MatiereController {

    private final MatiereService matiereService;

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getMatiere(@PathVariable Integer id) {
        Map<String, Object> resp = matiereService.getMatiere(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/{id}/notes")
    public ResponseEntity<Map<String, Object>> getNotes(@PathVariable Integer id) {
        Map<String, Object> resp = matiereService.getNotesByMatiere(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }
}
