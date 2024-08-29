package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Cliente;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class ClienteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Cliente cliente) {
        entityManager.persist(cliente);
    }

    public Cliente findById(Integer id) {
        return entityManager.find(Cliente.class, id);
    }

    public void update(Cliente cliente) {
        entityManager.merge(cliente);
    }

    public void delete(Cliente cliente) {
        Cliente merged = entityManager.merge(cliente);
        entityManager.remove(merged);
    }

    public List<Cliente> findAll() {
        CriteriaQuery<Cliente> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(Cliente.class);
        Root<Cliente> root = criteriaQuery.from(Cliente.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }

    public Cliente findByCpf(String cpf) {
        return entityManager.createQuery("SELECT c FROM Cliente c WHERE c.cpf = :cpf", Cliente.class)
                .setParameter("cpf", cpf)
                .getSingleResult();
    }
}
