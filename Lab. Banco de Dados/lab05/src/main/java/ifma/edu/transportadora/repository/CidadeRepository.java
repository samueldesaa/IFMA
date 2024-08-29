package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Cidade;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class CidadeRepository {

    private final EntityManager entityManager;

    public CidadeRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public Cidade findById(int id) {
        return entityManager.find(Cidade.class, id);
    }

    public List<Cidade> findAll() {
        TypedQuery<Cidade> query = entityManager.createQuery("SELECT c FROM Cidade c", Cidade.class);
        return query.getResultList();
    }
}
