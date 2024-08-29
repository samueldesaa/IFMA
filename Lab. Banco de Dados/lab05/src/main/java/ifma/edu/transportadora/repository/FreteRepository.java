package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Frete;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class FreteRepository {

    private final EntityManager entityManager;

    public FreteRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Frete frete) {
        entityManager.getTransaction().begin();
        if (frete.getCodigo() == 0) {
            entityManager.persist(frete);
        } else {
            entityManager.merge(frete);
        }
        entityManager.getTransaction().commit();
    }

    public Frete findById(int id) {
        return entityManager.find(Frete.class, id);
    }

    public List<Frete> findAll() {
        TypedQuery<Frete> query = entityManager.createQuery("SELECT f FROM Frete f", Frete.class);
        return query.getResultList();
    }
}
