package ifma.edu.imobiliaria.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "ALUGUEIS")
public class Aluguel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_ALUGUEL")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "ID_CLIENTE", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "ID_IMOVEL", nullable = false)
    private Imovel imovel;

    @Column(name = "VALOR_ALUGUEL", precision = 10, scale = 2)
    private BigDecimal valorAluguel;

    @Column(name = "PERCENTUAL_MULTA", precision = 5, scale = 2)
    private BigDecimal percentualMulta;

    @Column(name = "DIA_VENCIMENTO")
    private Byte diaVencimento;

    @Temporal(TemporalType.DATE)
    @Column(name = "DATA_INICIO")
    private Date dataInicio;

    @Temporal(TemporalType.DATE)
    @Column(name = "DATA_FIM")
    private Date dataFim;

    @Column(name = "ATIVO")
    private Boolean ativo;

    @Column(name = "OBS", columnDefinition = "TEXT")
    private String obs;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Imovel getImovel() {
        return imovel;
    }

    public void setImovel(Imovel imovel) {
        this.imovel = imovel;
    }

    public BigDecimal getValorAluguel() {
        return valorAluguel;
    }

    public void setValorAluguel(BigDecimal valorAluguel) {
        this.valorAluguel = valorAluguel;
    }

    public BigDecimal getPercentualMulta() {
        return percentualMulta;
    }

    public void setPercentualMulta(BigDecimal percentualMulta) {
        this.percentualMulta = percentualMulta;
    }

    public Byte getDiaVencimento() {
        return diaVencimento;
    }

    public void setDiaVencimento(Byte diaVencimento) {
        this.diaVencimento = diaVencimento;
    }

    public Date getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(Date dataInicio) {
        this.dataInicio = dataInicio;
    }

    public Date getDataFim() {
        return dataFim;
    }

    public void setDataFim(Date dataFim) {
        this.dataFim = dataFim;
    }

    public Boolean getAtivo() {
        return ativo;
    }

    public void setAtivo(Boolean ativo) {
        this.ativo = ativo;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }
}
