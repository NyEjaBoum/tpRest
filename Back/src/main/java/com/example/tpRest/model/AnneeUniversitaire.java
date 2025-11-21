package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "Annee_universitaire")
@Data
public class AnneeUniversitaire {
    @Id
    @Column(name = "id_annee")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAnnee;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;
}
