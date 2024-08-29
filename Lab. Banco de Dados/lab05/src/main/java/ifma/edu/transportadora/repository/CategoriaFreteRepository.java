package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.CategoriaFrete;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class CategoriaFreteRepository {

    private final EntityManager entityManager;

    public CategoriaFreteRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public CategoriaFrete findById(int id) {
        return entityManager.find(CategoriaFrete.class, id);
    }

    public List<CategoriaFrete> findAll() {
        TypedQuery<CategoriaFrete> query = entityManager.createQuery("SELECT c FROM CategoriaFrete c", CategoriaFrete.class);
        return query.getResultList();
    }
}
