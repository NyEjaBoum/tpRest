package com.example.tpRest.controller;

import com.example.tpRest.service.EtudiantService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/etudiants")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class EtudiantController {

    private final EtudiantService etudiantService;

    @GetMapping("/{id}/infos-moyennes")
    public ResponseEntity<Map<String, Object>> getInfosEtudiantMoyennes(@PathVariable Integer id) {
        Map<String, Object> resp = etudiantService.getInfosEtudiantMoyennes(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAll() {
        Map<String, Object> resp = etudiantService.getAllEtudiants();
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/semestre/{id}")
    public ResponseEntity<Map<String, Object>> getBySemestre(@PathVariable Integer id) {
        Map<String, Object> resp = etudiantService.getEtudiantsBySemestre(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/{id}/notes")
    public ResponseEntity<Map<String, Object>> getNotes(@PathVariable Integer id) {
        Map<String, Object> resp = etudiantService.getNotesByEtudiant(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }
}
