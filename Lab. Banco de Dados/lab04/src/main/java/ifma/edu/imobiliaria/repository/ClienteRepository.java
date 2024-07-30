package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Cliente;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;

public class ClienteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void save(Cliente cliente) {
        if (cliente.getId() == null) {
            entityManager.persist(cliente);
        } else {
            entityManager.merge(cliente);
        }
    }

    @Transactional
    public void delete(Cliente cliente) {
        if (cliente.getId() != null) {
            entityManager.remove(entityManager.merge(cliente));
        }
    }

    public Cliente findById(Integer id) {
        return entityManager.find(Cliente.class, id);
    }

    public List<Cliente> findAll() {
        TypedQuery<Cliente> query = entityManager.createQuery("SELECT c FROM Cliente c", Cliente.class);
        return query.getResultList();
    }

    public boolean existsByCpf(String cpf) {
        TypedQuery<Long> query = entityManager.createQuery(
                "SELECT COUNT(c) FROM Cliente c WHERE c.cpf = :cpf", Long.class);
        query.setParameter("cpf", cpf);
        return query.getSingleResult() > 0;
    }

    public Cliente findByCpf(String cpf) {
        TypedQuery<Cliente> query = entityManager.createQuery(
                "SELECT c FROM Cliente c WHERE c.cpf = :cpf", Cliente.class);
        query.setParameter("cpf", cpf);
        return query.getSingleResult();
    }
}
