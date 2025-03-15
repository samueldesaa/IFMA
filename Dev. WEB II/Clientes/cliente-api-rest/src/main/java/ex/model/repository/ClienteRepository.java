package ex.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ex.model.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {
}