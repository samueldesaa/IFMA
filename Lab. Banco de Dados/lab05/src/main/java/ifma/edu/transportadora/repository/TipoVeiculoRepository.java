package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.TipoVeiculo;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class TipoVeiculoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(TipoVeiculo tipoVeiculo) {
        entityManager.persist(tipoVeiculo);
    }

    public TipoVeiculo findById(Integer id) {
        return entityManager.find(TipoVeiculo.class, id);
    }

    public void update(TipoVeiculo tipoVeiculo) {
        entityManager.merge(tipoVeiculo);
    }

    public void delete(TipoVeiculo tipoVeiculo) {
        TipoVeiculo merged = entityManager.merge(tipoVeiculo);
        entityManager.remove(merged);
    }

    public List<TipoVeiculo> findAll() {
        CriteriaQuery<TipoVeiculo> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(TipoVeiculo.class);
        Root<TipoVeiculo> root = criteriaQuery.from(TipoVeiculo.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }
}
