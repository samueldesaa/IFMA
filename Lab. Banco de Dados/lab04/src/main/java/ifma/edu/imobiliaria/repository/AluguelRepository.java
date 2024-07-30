package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Aluguel;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class AluguelRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void save(Aluguel aluguel) {
        if (aluguel.getId() == null) {
            entityManager.persist(aluguel);
        } else {
            entityManager.merge(aluguel);
        }
    }

    @Transactional
    public void delete(Aluguel aluguel) {
        if (aluguel.getId() != null) {
            entityManager.remove(entityManager.merge(aluguel));
        }
    }

    public Aluguel findById(Integer id) {
        return entityManager.find(Aluguel.class, id);
    }

    public List<Aluguel> findAll() {
        TypedQuery<Aluguel> query = entityManager.createQuery("SELECT a FROM Aluguel a", Aluguel.class);
        return query.getResultList();
    }

    public List<Aluguel> findByClienteNome(String nomeCliente) {
        TypedQuery<Aluguel> query = entityManager.createQuery(
                "SELECT a FROM Aluguel a WHERE a.cliente.nome = :nomeCliente", Aluguel.class);
        query.setParameter("nomeCliente", nomeCliente);
        return query.getResultList();
    }

    public List<Aluguel> findByValorAluguelLessThanEqual(BigDecimal valorMaximo) {
        TypedQuery<Aluguel> query = entityManager.createQuery(
                "SELECT a FROM Aluguel a WHERE a.valorAluguel <= :valorMaximo", Aluguel.class);
        query.setParameter("valorMaximo", valorMaximo);
        return query.getResultList();
    }

    public List<Aluguel> findByDataFimBefore(Date dataLimite) {
        TypedQuery<Aluguel> query = entityManager.createQuery(
                "SELECT a FROM Aluguel a WHERE a.dataFim < :dataLimite", Aluguel.class);
        query.setParameter("dataLimite", dataLimite);
        return query.getResultList();
    }
}
