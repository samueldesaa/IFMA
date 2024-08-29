package ifma.edu.transportadora.model;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "frete")
public class Frete {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigo;

    @Column(name = "numero_nota_fiscal")
    private int numeroNotaFiscal;

    @Column(name = "valor_km_rodado")
    private BigDecimal valorKmRodado;

    @Column(name = "id_cliente")
    private int idCliente;

    @Column(name = "id_veiculo")
    private int idVeiculo;

    @Column(name = "id_categoria_frete")
    private int idCategoriaFrete;

    @Column(name = "id_cidade_origem")
    private int idCidadeOrigem;

    @Column(name = "id_cidade_destino")
    private int idCidadeDestino;

    @Column(name = "id_funcionario")
    private int idFuncionario;

    // Getters e Setters
    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getNumeroNotaFiscal() {
        return numeroNotaFiscal;
    }

    public void setNumeroNotaFiscal(int numeroNotaFiscal) {
        this.numeroNotaFiscal = numeroNotaFiscal;
    }

    public BigDecimal getValorKmRodado() {
        return valorKmRodado;
    }

    public void setValorKmRodado(BigDecimal valorKmRodado) {
        this.valorKmRodado = valorKmRodado;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdVeiculo() {
        return idVeiculo;
    }

    public void setIdVeiculo(int idVeiculo) {
        this.idVeiculo = idVeiculo;
    }

    public int getIdCategoriaFrete() {
        return idCategoriaFrete;
    }

    public void setIdCategoriaFrete(int idCategoriaFrete) {
        this.idCategoriaFrete = idCategoriaFrete;
    }

    public int getIdCidadeOrigem() {
        return idCidadeOrigem;
    }

    public void setIdCidadeOrigem(int idCidadeOrigem) {
        this.idCidadeOrigem = idCidadeOrigem;
    }

    public int getIdCidadeDestino() {
        return idCidadeDestino;
    }

    public void setIdCidadeDestino(int idCidadeDestino) {
        this.idCidadeDestino = idCidadeDestino;
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }
}
