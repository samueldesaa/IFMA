package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Profissional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

public class ProfissionalRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Profissional profissional) {
        if (profissional.getId() == null) {
            entityManager.persist(profissional);
        } else {
            entityManager.merge(profissional);
        }
    }

    public Profissional findById(Integer id) {
        return entityManager.find(Profissional.class, id);
    }

    public List<Profissional> findAll() {
        TypedQuery<Profissional> query = entityManager.createQuery("SELECT p FROM Profissional p", Profissional.class);
        return query.getResultList();
    }
}
