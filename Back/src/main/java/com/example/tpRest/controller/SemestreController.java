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

    

    @GetMapping("/semestres/{id}/etudiants-moyennes")
    public List<Map<String, Object>> getEtudiantsMoyennes(@PathVariable Integer id) {
        return semestreService.getEtudiantsWithMoyennesBySemestre(id);
    }

}