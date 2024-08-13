package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Imovel;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class ImovelRepository {

    private EntityManager entityManager;

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Imovel imovel) {
        entityManager.getTransaction().begin();
        if (imovel.getId() == null) {
            entityManager.persist(imovel);
        } else {
            entityManager.merge(imovel);
        }
        entityManager.getTransaction().commit();
    }

    public Imovel findById(Integer id) {
        return entityManager.find(Imovel.class, id);
    }

    public List<Imovel> findAll() {
        TypedQuery<Imovel> query = entityManager.createQuery(
                "SELECT i FROM Imovel i", Imovel.class);
        return query.getResultList();
    }
}
