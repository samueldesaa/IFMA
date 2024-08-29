package ifma.edu.transportadora.model;

import javax.persistence.*;

@Entity
@Table(name = "distancia")
public class Distancia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int quilometros;

    @Column(name = "id_cid1")
    private int idCid1;

    @Column(name = "id_cid2")
    private int idCid2;

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuilometros() {
        return quilometros;
    }

    public void setQuilometros(int quilometros) {
        this.quilometros = quilometros;
    }

    public int getIdCid1() {
        return idCid1;
    }

    public void setIdCid1(int idCid1) {
        this.idCid1 = idCid1;
    }

    public int getIdCid2() {
        return idCid2;
    }

    public void setIdCid2(int idCid2) {
        this.idCid2 = idCid2;
    }
}
