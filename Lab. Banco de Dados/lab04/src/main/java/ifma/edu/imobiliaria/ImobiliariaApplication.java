// src/main/java/ifma/edu/imobiliaria/ImobiliariaApplication.java
package ifma.edu.imobiliaria;

import ifma.edu.imobiliaria.model.TipoImovel;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class ImobiliariaApplication {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("imobiliariaPU");
        EntityManager em = emf.createEntityManager();

        // Exemplo de uso: criando um TipoImovel
        em.getTransaction().begin();
        TipoImovel tipoImovel = new TipoImovel();
        tipoImovel.setDescricao("Apartamento");
        em.persist(tipoImovel);
        em.getTransaction().commit();

        em.close();
        emf.close();
    }
}
