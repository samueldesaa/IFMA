package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Veiculo;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class VeiculoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Veiculo veiculo) {
        entityManager.persist(veiculo);
    }

    public Veiculo findById(Integer id) {
        return entityManager.find(Veiculo.class, id);
    }

    public void update(Veiculo veiculo) {
        entityManager.merge(veiculo);
    }

    public void delete(Veiculo veiculo) {
        Veiculo merged = entityManager.merge(veiculo);
        entityManager.remove(merged);
    }

    public List<Veiculo> findAll() {
        CriteriaQuery<Veiculo> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(Veiculo.class);
        Root<Veiculo> root = criteriaQuery.from(Veiculo.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }
}
