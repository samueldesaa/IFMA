package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.ItemFrete;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class ItemFreteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(ItemFrete itemFrete) {
        entityManager.persist(itemFrete);
    }

    public ItemFrete findById(Integer id) {
        return entityManager.find(ItemFrete.class, id);
    }

    public void update(ItemFrete itemFrete) {
        entityManager.merge(itemFrete);
    }

    public void delete(ItemFrete itemFrete) {
        ItemFrete merged = entityManager.merge(itemFrete);
        entityManager.remove(merged);
    }

    public List<ItemFrete> findAll() {
        CriteriaQuery<ItemFrete> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(ItemFrete.class);
        Root<ItemFrete> root = criteriaQuery.from(ItemFrete.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }
}
