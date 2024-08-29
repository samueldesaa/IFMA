package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Dependente;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class DependenteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Dependente dependente) {
        entityManager.persist(dependente);
    }

    public Dependente findById(Integer id) {
        return entityManager.find(Dependente.class, id);
    }

    public void update(Dependente dependente) {
        entityManager.merge(dependente);
    }

    public void delete(Dependente dependente) {
        Dependente merged = entityManager.merge(dependente);
        entityManager.remove(merged);
    }

    public List<Dependente> findAll() {
        CriteriaQuery<Dependente> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(Dependente.class);
        Root<Dependente> root = criteriaQuery.from(Dependente.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }
}
