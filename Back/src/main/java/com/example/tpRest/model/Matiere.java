package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Matiere")
@Data
public class Matiere {
    @Id
    @Column(name = "id_matiere")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idMatiere;

    @Column(name = "libelle")
    private String libelle;

    @ManyToOne
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    private Semestre semestre;
}
