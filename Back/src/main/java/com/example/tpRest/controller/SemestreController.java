package com.example.tpRest.controller;

import com.example.tpRest.service.*;
import com.example.tpRest.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import com.example.tpRest.model.Semestre;
import java.util.Map;

@RestController
@RequestMapping("/api/semestres")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class SemestreController {

    @Autowired
    private final SemestreRepository semestreRepository;

    private final SemestreService semestreService;

    @GetMapping("/semestres")
    public ResponseEntity<Map<String, Object>> findAll(){
        Map<String, Object> resp = semestreService.getAllSemestres();
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    @GetMapping("/{id}/etudiants-moyennes")
    public ResponseEntity<Map<String, Object>> getEtudiantsMoyennes(@PathVariable Integer id) {
        Map<String, Object> resp = semestreService.getEtudiantsWithMoyennesBySemestre(id);
        if ("error".equals(resp.get("status"))) {
            return ResponseEntity.badRequest().body(resp);
        }
        return ResponseEntity.ok(resp);
    }

}