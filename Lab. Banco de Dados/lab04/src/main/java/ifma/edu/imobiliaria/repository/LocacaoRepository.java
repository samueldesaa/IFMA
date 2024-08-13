package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Locacao;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class LocacaoRepository {

    private EntityManager entityManager;

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Locacao locacao) {
        entityManager.getTransaction().begin();
        if (locacao.getId() == null) {
            entityManager.persist(locacao);
        } else {
            entityManager.merge(locacao);
        }
        entityManager.getTransaction().commit();
    }

    public Locacao findById(Integer id) {
        return entityManager.find(Locacao.class, id);
    }

    public List<Locacao> findAll() {
        TypedQuery<Locacao> query = entityManager.createQuery(
                "SELECT l FROM Locacao l", Locacao.class);
        return query.getResultList();
    }

    public List<Locacao> findByClienteId(Integer clienteId) {
        TypedQuery<Locacao> query = entityManager.createQuery(
                "SELECT l FROM Locacao l WHERE l.cliente.id = :clienteId", Locacao.class);
        query.setParameter("clienteId", clienteId);
        return query.getResultList();
    }
}
