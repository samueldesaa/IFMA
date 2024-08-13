package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Cliente;
import ifma.edu.imobiliaria.repository.ClienteRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Date;
import java.util.List;

public class ClienteTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static ClienteRepository clienteRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();

        clienteRepository = new ClienteRepository();

        clienteRepository.setEntityManager(entityManager);

        testInserirCliente();
        testAtualizarCliente();
        testListarTodosClientes();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirCliente() {
        Cliente cliente = new Cliente();
        cliente.setNome("João Silva");
        cliente.setCpf("123.456.789-00");
        cliente.setTelefone("98765-4321");
        cliente.setEmail("joao.silva@example.com");
        cliente.setDtNascimento(new Date());

        clienteRepository.save(cliente);
        System.out.println("Cliente inserido com sucesso!");
    }

    private static void testAtualizarCliente() {
        Cliente cliente = clienteRepository.findById(1);
        if (cliente != null) {
            cliente.setEmail("novo.email@example.com");
            clienteRepository.save(cliente);
            System.out.println("Cliente atualizado com sucesso!");
        } else {
            System.out.println("Cliente não encontrado.");
        }
    }

    private static void testListarTodosClientes() {
        List<Cliente> clientes = clienteRepository.findAll();
        if (clientes != null && !clientes.isEmpty()) {
            clientes.forEach(cliente -> System.out.println(cliente.toString()));
        } else {
            System.out.println("Nenhum cliente encontrado.");
        }
    }
}
