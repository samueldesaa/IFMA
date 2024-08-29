package ifma.edu.transportadora.model;

import javax.persistence.*;

@Entity
@Table(name = "item_frete")
public class ItemFrete {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String descricao;

    private float peso;

    @Column(name = "id_frete")
    private int idFrete;

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public float getPeso() {
        return peso;
    }

    public void setPeso(float peso) {
        this.peso = peso;
    }

    public int getIdFrete() {
        return idFrete;
    }

    public void setIdFrete(int idFrete) {
        this.idFrete = idFrete;
    }
}
