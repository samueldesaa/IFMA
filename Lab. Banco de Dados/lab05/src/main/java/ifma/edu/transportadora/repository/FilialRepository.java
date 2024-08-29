package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Filial;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class FilialRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Filial filial) {
        entityManager.persist(filial);
    }

    public Filial findById(Integer id) {
        return entityManager.find(Filial.class, id);
    }

    public void update(Filial filial) {
        entityManager.merge(filial);
    }

    public void delete(Filial filial) {
        Filial merged = entityManager.merge(filial);
        entityManager.remove(merged);
    }

    public List<Filial> findAll() {
        CriteriaQuery<Filial> criteriaQuery = entityManager.getCriteriaBuilder().createQuery(Filial.class);
        Root<Filial> root = criteriaQuery.from(Filial.class);
        criteriaQuery.select(root);
        return entityManager.createQuery(criteriaQuery).getResultList();
    }

    public Filial findByNome(String nome) {
        return entityManager.createQuery("SELECT f FROM Filial f WHERE f.nome = :nome", Filial.class)
                .setParameter("nome", nome)
                .getSingleResult();
    }
}
