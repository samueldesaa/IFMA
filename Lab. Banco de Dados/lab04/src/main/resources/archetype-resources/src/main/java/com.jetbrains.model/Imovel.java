package com.jetbrains.model;

import javax.persistence.*;

@Entity
@Table(name = "imoveis")
public class Imovel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_proprietario", nullable = false)
    private Integer idProprietario;

    @ManyToOne
    @JoinColumn(name = "id_tipo_imovel", nullable = false)
    private TipoImovel tipoImovel;

    @Column(name = "logradouro", length = 200)
    private String logradouro;

    @Column(name = "bairro", length = 45)
    private String bairro;

    @Column(name = "cep", length = 10)
    private String cep;

    @Column(name = "metragem")
    private Integer metragem;

    @Column(name = "dormitorios")
    private Integer dormitorios;

    @Column(name = "banheiros")
    private Integer banheiros;

    @Column(name = "suites")
    private Integer suites;

    @Column(name = "vagas_garagem")
    private Integer vagasGaragem;

    @Column(name = "valor_aluguel_sugerido", precision = 10, scale = 2)
    private Double valorAluguelSugerido;

    @Column(name = "obs")
    private String obs;

    // Getters and setters...
}

// Outras classes como TipoImovel, Cliente, Locacao, etc. devem ser criadas da mesma forma.
