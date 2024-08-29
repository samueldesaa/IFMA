package ifma.edu.transportadora.service;

import ifma.edu.transportadora.model.CategoriaFrete;
import ifma.edu.transportadora.model.Cidade;
import ifma.edu.transportadora.model.Distancia;
import ifma.edu.transportadora.model.Frete;
import ifma.edu.transportadora.repository.CategoriaFreteRepository;
import ifma.edu.transportadora.repository.CidadeRepository;
import ifma.edu.transportadora.repository.DistanciaRepository;
import ifma.edu.transportadora.repository.FreteRepository;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.List;
import java.util.stream.Collectors;

public class FreteService {

    private final FreteRepository freteRepository;
    private final CidadeRepository cidadeRepository;
    private final CategoriaFreteRepository categoriaFreteRepository;
    private final DistanciaRepository distanciaRepository;

    public FreteService() {
        EntityManager entityManager = Persistence.createEntityManagerFactory("transportadoraPU").createEntityManager();
        this.freteRepository = new FreteRepository(entityManager);
        this.cidadeRepository = new CidadeRepository(entityManager);
        this.categoriaFreteRepository = new CategoriaFreteRepository(entityManager);
        this.distanciaRepository = new DistanciaRepository(entityManager);
    }

    public void registrarFrete(Frete frete) {
        // Calcular valor do frete antes de salvar
        BigDecimal valor = calcularValorFrete(frete);
        frete.setValorKmRodado(valor);
        freteRepository.save(frete);
    }

    private BigDecimal calcularValorFrete(Frete frete) {
        // Recuperar as cidades e categoria do frete
        Cidade cidadeOrigem = cidadeRepository.findById(frete.getIdCidadeOrigem());
        Cidade cidadeDestino = cidadeRepository.findById(frete.getIdCidadeDestino());
        CategoriaFrete categoriaFrete = categoriaFreteRepository.findById(frete.getIdCategoriaFrete());

        // Verificação se as cidades e a categoria foram encontradas
        if (cidadeOrigem == null || cidadeDestino == null || categoriaFrete == null) {
            throw new IllegalArgumentException("Cidades ou categoria do frete não encontradas.");
        }

        // Calcula a distância
        int distanciaKm = calcularDistancia(cidadeOrigem.getId(), cidadeDestino.getId());

        // Calcula o valor do frete com base na distância e na categoria
        return BigDecimal.valueOf(categoriaFrete.getPercentualAdicional()* distanciaKm);
    }

    private int calcularDistancia(int idCid1, int idCid2) {
        Optional<Distancia> distanciaOptional = distanciaRepository.findByCidades(idCid1, idCid2);
        return distanciaOptional.map(Distancia::getQuilometros).orElse(0);
    }


    public List<Frete> listarFretesPorCliente(int idCliente) {
        // Recupera todos os fretes e filtra pelo cliente
        List<Frete> todosFretes = freteRepository.findAll();
        return todosFretes.stream()
                .filter(frete -> frete.getIdCliente() == idCliente)
                .collect(Collectors.toList()); // Alternativa ao toList() para versões mais antigas
    }


    public Frete buscarFretePorId(int id) {
        return freteRepository.findById(id);
    }
}
