package com.example.tpRest.dto;

import lombok.Data;
import java.util.List;

@Data
public class NoteAnneeDto {
    private String anneeLibelle;
    private List<NoteSemestreDto> semestres;
    private int totalNotes;
}
