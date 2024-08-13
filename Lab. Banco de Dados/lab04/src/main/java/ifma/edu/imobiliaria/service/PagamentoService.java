package ifma.edu.imobiliaria.service;

import ifma.edu.imobiliaria.model.Pagamento;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class PagamentoService {

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
            // Verifica se o pagamento existe antes de tentar removê-lo
            Pagamento managedPagamento = entityManager.find(Pagamento.class, pagamento.getId());
            if (managedPagamento != null) {
                entityManager.remove(managedPagamento);
            }
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

    public double calcularValorComMulta(double valorAluguel, LocalDate dataVencimento, LocalDate dataPagamento) {
        if (dataPagamento.isBefore(dataVencimento) || dataPagamento.isEqual(dataVencimento)) {
            return valorAluguel;
        }

        long diasAtraso = ChronoUnit.DAYS.between(dataVencimento, dataPagamento);
        double multa = valorAluguel * 0.0033 * diasAtraso;
        multa = Math.min(multa, valorAluguel * 0.20);

        return valorAluguel + multa;
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}
