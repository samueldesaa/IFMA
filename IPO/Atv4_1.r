# Função em R puro para cálculo de solução ótima em PL de 2 variáveis
resolver_pl_simples <- function(c, A, b) {
  # Adiciona automaticamente as restrições de não-negatividade
  A_com_nao_neg <- rbind(A, c(-1, 0), c(0, -1))
  b_com_nao_neg <- c(b, 0, 0)
  num_restr <- nrow(A_com_nao_neg)
  pontos_viaveis <- list()
  
  # Calcula as interseções entre todas as combinações possíveis de restrições
  for (i in 1:(num_restr - 1)) {
    for (j in (i + 1):num_restr) {
      sis_A <- rbind(A_com_nao_neg[i, ], A_com_nao_neg[j, ])
      sis_b <- c(b_com_nao_neg[i], b_com_nao_neg[j])
      
      if (det(sis_A) != 0) {
        ponto <- solve(sis_A, sis_b)
        
        # Verifica a viabilidade do ponto perante todas as restrições
        viavel <- TRUE
        for (k in 1:num_restr) {
          if (sum(A_com_nao_neg[k, ] * ponto) > b_com_nao_neg[k] + 1e-8) {
            viavel <- FALSE
            break
          }
        }
        if (viavel) {
          pontos_viaveis[[length(pontos_viaveis) + 1]] <- ponto
        }
      }
    }
  }
  
  # Encontra o ponto que maximiza Z
  max_z <- -Inf
  melhor_ponto <- NULL
  
  for (p in pontos_viaveis) {
    z_atual <- sum(c * p)
    if (z_atual > max_z) {
      max_z <- z_atual
      melhor_ponto <- p
    }
  }
  
  return(list(ponto = melhor_ponto, maximo_z = max_z))
}

# Definição da Função Objetivo
vetor_custos <- c(120, 150)

cat("--- Resolução da Alínea A (Restrições 1 e 2) ---\n")
A_2restr <- matrix(c(2, 4, 3, 2), nrow = 2, byrow = TRUE)
b_2restr <- c(100, 90)
solucao_a <- resolver_pl_simples(vetor_custos, A_2restr, b_2restr)
cat("Ponto Ótimo: x1 = ", solucao_a$ponto[1], ", x2 = ", solucao_a$ponto[2], "\n")
cat("Lucro (Z): ", solucao_a$maximo_z, "\n\n")

cat("--- Resolução da Alínea B (Restrições 1, 2 e 3) ---\n")
A_3restr <- matrix(c(2, 4, 3, 2, 5, 3), nrow = 3, byrow = TRUE)
b_3restr <- c(100, 90, 120)
solucao_b <- resolver_pl_simples(vetor_custos, A_3restr, b_3restr)
cat("Ponto Ótimo: x1 = ", round(solucao_b$ponto[1], 2), ", x2 = ", round(solucao_b$ponto[2], 2), "\n")
cat("Lucro (Z): ", round(solucao_b$maximo_z, 2), "\n")