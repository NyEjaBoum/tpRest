package com.example.tpRest.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Semestre")
@Data
public class Semestre {
    @Id
    @Column(name = "id_semestre")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idSemestre;

    @Column(name = "libelle")
    private String libelle;
}
