package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Locacao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

public class LocacaoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Locacao locacao) {
        if (locacao.getId() == null) {
            entityManager.persist(locacao);
        } else {
            entityManager.merge(locacao);
        }
    }

    public Locacao findById(Integer id) {
        return entityManager.find(Locacao.class, id);
    }

    public List<Locacao> findByClienteId(Integer clienteId) {
        TypedQuery<Locacao> query = entityManager.createQuery(
                "SELECT l FROM Locacao l WHERE l.cliente.id = :clienteId", Locacao.class);
        query.setParameter("clienteId", clienteId);
        return query.getResultList();
    }
}
