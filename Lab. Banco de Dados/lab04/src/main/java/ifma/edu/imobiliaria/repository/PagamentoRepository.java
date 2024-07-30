package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Pagamento;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;

public class PagamentoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void save(Pagamento pagamento) {
        if (pagamento.getId() == null) {
            entityManager.persist(pagamento);
        } else {
            entityManager.merge(pagamento);
        }
    }

    @Transactional
    public void delete(Pagamento pagamento) {
        if (pagamento.getId() != null) {
            entityManager.remove(entityManager.merge(pagamento));
        }
    }

    public Pagamento findById(Integer id) {
        return entityManager.find(Pagamento.class, id);
    }

    public List<Pagamento> findAll() {
        TypedQuery<Pagamento> query = entityManager.createQuery("SELECT p FROM Pagamento p", Pagamento.class);
        return query.getResultList();
    }

    public List<Pagamento> findByLocacaoId(Integer locacaoId) {
        TypedQuery<Pagamento> query = entityManager.createQuery("SELECT p FROM Pagamento p WHERE p.locacao.id = :locacaoId", Pagamento.class);
        query.setParameter("locacaoId", locacaoId);
        return query.getResultList();
    }
}
