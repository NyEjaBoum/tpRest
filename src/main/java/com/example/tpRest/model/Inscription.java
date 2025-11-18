package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Inscription")
@Data
public class Inscription {
    @Id
    @Column(name = "id_inscription")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idInscription;

    @ManyToOne
    @JoinColumn(name = "id_etudiant", referencedColumnName = "id_etudiant")
    private Etudiant etudiant;

    @ManyToOne
    @JoinColumn(name = "id_annee", referencedColumnName = "id_annee")
    private AnneeUniversitaire anneeUniversitaire;

    @ManyToOne
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    private Semestre semestre;
}
