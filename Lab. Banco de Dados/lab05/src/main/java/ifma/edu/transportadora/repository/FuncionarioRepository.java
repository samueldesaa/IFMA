package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Funcionario;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class FuncionarioRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Funcionario funcionario) {
        entityManager.persist(funcionario);
    }

    public Funcionario findById(Integer id) {
        return entityManager.find(Funcionario.class, id);
    }

    public void update(Funcionario funcionario) {
        entityManager.merge(funcionario);
    }

    public void delete(Funcionario funcionario) {
        Funcionario merged = entityManager.merge(funcionario);
        entityManager.remove(merged);
    }

    public List<Funcionario> findAll() {
        CriteriaQuery<Funcionario> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(Funcionario.class);
        Root<Funcionario> root = criteriaQuery.from(Funcionario.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }
}
