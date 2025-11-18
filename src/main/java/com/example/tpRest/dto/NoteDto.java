package com.example.tpRest.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class NoteDto {
    private Integer idNote;
    private BigDecimal valeur;
    private String dateInsertion;
    private String matiereLibelle;
    private String semestreLibelle;
}
