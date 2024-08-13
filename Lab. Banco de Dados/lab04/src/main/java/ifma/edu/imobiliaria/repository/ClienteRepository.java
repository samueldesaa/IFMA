package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Cliente;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class ClienteRepository {

    private EntityManager entityManager;

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Cliente cliente) {
        entityManager.getTransaction().begin();
        if (cliente.getId() == null) {
            entityManager.persist(cliente);
        } else {
            entityManager.merge(cliente);
        }
        entityManager.getTransaction().commit();
    }

    public Cliente findById(Integer id) {
        return entityManager.find(Cliente.class, id);
    }

    public List<Cliente> findAll() {
        TypedQuery<Cliente> query = entityManager.createQuery(
                "SELECT c FROM Cliente c", Cliente.class);
        return query.getResultList();
    }
}
