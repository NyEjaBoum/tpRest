package com.example.tpRest.dto;

import lombok.Data;
import java.util.List;

@Data
public class NoteSemestreDto {
    private String semestreLibelle;
    private List<NoteDto> notes;
    private int totalNotes;
}
