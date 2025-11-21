package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "Etudiant")
@Data
public class Etudiant {
    @Id
    @Column(name = "id_etudiant")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idEtudiant;

    @Column(name = "matricule")
    private String matricule;

    @Column(name = "nom")
    private String nom;

    @Column(name = "prenom")
    private String prenom;

    @Column(name = "date_inscription")
    private LocalDate dateInscription;

    @ManyToOne
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    private Semestre semestre;
}
