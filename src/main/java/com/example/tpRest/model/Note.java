package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Entity
@Table(name = "Note")
@Data
public class Note {
    @Id
    @Column(name = "id_note")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idNote;

    @Column(name = "valeur")
    private BigDecimal valeur;

    @Column(name = "date_insertion")
    private String dateInsertion;

    @ManyToOne
    @JoinColumn(name = "id_matiere", referencedColumnName = "id_matiere")
    private Matiere matiere;
}
