package ifma.edu.transportadora.repository;

import ifma.edu.transportadora.model.Distancia;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.Optional;

public class DistanciaRepository {

    private final EntityManager entityManager;

    public DistanciaRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public Optional<Distancia> findByCidades(int idCid1, int idCid2) {
        TypedQuery<Distancia> query = entityManager.createQuery(
                "SELECT d FROM Distancia d WHERE (d.idCid1 = :idCid1 AND d.idCid2 = :idCid2) OR (d.idCid1 = :idCid2 AND d.idCid2 = :idCid1)", Distancia.class
        );
        query.setParameter("idCid1", idCid1);
        query.setParameter("idCid2", idCid2);
        return query.getResultStream().findFirst();
    }
}
