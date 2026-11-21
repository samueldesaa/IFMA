# ==============================================================================
# Atividade VI - Implementação do método Simplex
# Autor: Samuel Chaves de Sá (20231SI0011)
# Disciplina: Pesquisa Operacional / Otimização
# Instituição: Instituto Federal do Maranhão - IFMA
# ==============================================================================

# Função principal do Simplex
# c: vetor de coeficientes da função objetivo
# A: matriz de coeficientes das restrições (lado esquerdo)
# b: vetor de termos independentes (lado direito, b >= 0)
# tol: controle de tolerância numérica para evitar erros de ponto flutuante
# max_iter: limite de iterações como critério de parada por segurança
simplex_max <- function(c, A, b, tol = 1e-8, max_iter = 100) {
  
  m <- nrow(A) # número de restrições
  n <- ncol(A) # número de variáveis de decisão
  
  # 1. Criação do Tableau Inicial
  # matrix(): aloca o espaço bidimensional do tableau definindo linhas e colunas.
  tableau <- matrix(0, nrow = m + 1, ncol = n + m + 1)
  tableau[1:m, 1:n] <- A
  
  # diag(): cria a matriz identidade rapidamente para injetar as variáveis de folga.
  tableau[1:m, (n + 1):(n + m)] <- diag(m) 
  tableau[1:m, n + m + 1] <- b
  tableau[m + 1, 1:n] <- -c
  
  # Função auxiliar para limpar resíduos de ponto flutuante
  clean_zero <- function(x) ifelse(abs(x) < tol, 0, x)
  
  cat("=========================================
")
  cat("--- Tableau Inicial ---
")
  print(round(tableau, 4))
  
  iter <- 0
  status <- "LIMITE" # Estados possíveis: OTIMO, ILIMITADO, LIMITE
  
  # Loop principal do Simplex
  while (iter <= max_iter) {
    tableau <- clean_zero(tableau)
    linha_z <- tableau[m + 1, 1:(n + m)]
    
    # 2. Critério de Parada (Otimalidade)
    # all(): verifica de uma vez se todas as posições do vetor satisfazem a condição >= 0
    if (all(linha_z >= -tol)) {
      status <- "OTIMO"
      break
    }
    
    # 3. Limite de Iterações
    if (iter == max_iter) {
      status <- "LIMITE"
      break
    }
    
    # 4. Variável que Entra na Base (Regra de Bland)
    # which(): retorna os índices que satisfazem a lógica. 
    # [1] seleciona a de menor índice em caso de empate (primeiro elemento negativo).
    col_pivo <- which(linha_z < -tol)[1]
    col_valores <- tableau[1:m, col_pivo]
    
    # 5. Verificação de Problema Ilimitado
    # Se todos os coeficientes da coluna pivô são <= 0, Z pode crescer ao infinito.
    if (all(col_valores <= tol)) {
      status <- "ILIMITADO"
      break
    }
    
    # 6. Variável que Sai da Base (Teste da Razão Mínima)
    # rep(): inicializa o vetor de razões preenchendo as posições com Inf (infinito).
    razoes <- rep(Inf, m) 
    linhas_validas <- which(col_valores > tol) 
    razoes[linhas_validas] <- tableau[linhas_validas, n + m + 1] / tableau[linhas_validas, col_pivo]
    
    razao_min <- min(razoes[linhas_validas])
    linhas_empate <- linhas_validas[which(abs(razoes[linhas_validas] - razao_min) < tol)]
    
    # Regra de Bland para saída da base:
    # Se mais de uma restrição possuir a mesma razão mínima, deve sair da base 
    # a variável básica que tiver o menor índice numérico.
    linha_pivo <- linhas_empate[1]
    menor_var_basica <- Inf
    
    for (linha in linhas_empate) {
      for (j in 1:(n + m)) {
        coluna <- clean_zero(tableau[1:m, j])
        # Condição para ser a variável básica daquela linha:
        if (sum(coluna == 1) == 1 && sum(coluna == 0) == (m - 1) && coluna[linha] == 1) {
          if (j < menor_var_basica) {
            menor_var_basica <- j
            linha_pivo <- linha
          }
          break
        }
      }
    }
    
    # 7. Pivoteamento (Escalonamento de Linhas)
    # Laço inevitável para manipular as demais linhas com base no pivô
    pivo <- tableau[linha_pivo, col_pivo]
    tableau[linha_pivo, ] <- tableau[linha_pivo, ] / pivo
    
    for (i in 1:(m + 1)) {
      if (i != linha_pivo) {
        tableau[i, ] <- tableau[i, ] - tableau[i, col_pivo] * tableau[linha_pivo, ]
      }
    }
    
    iter <- iter + 1
    cat("
--- Tableau Iteração", iter, "---
")
    print(round(tableau, 4))
  }
  
  # 8. Extração da Solução e Saída do Programa
  if (status == "OTIMO") {
    cat("
>> Solução ótima encontrada na iteração", iter, "<<
")
    
    solucao <- rep(0, n)
    var_basicas <- c()
    
    for (j in 1:(n + m)) {
      coluna <- clean_zero(tableau[1:m, j])
      if (sum(coluna == 1) == 1 && sum(coluna == 0) == (m - 1)) {
        linha_idx <- which(coluna == 1)
        var_basicas <- c(var_basicas, j)
        if (j <= n) {
          solucao[j] <- tableau[linha_idx, n + m + 1]
        }
      }
    }
    
    Z <- tableau[m + 1, n + m + 1]
    
    cat("=========================================
")
    cat("--- Solução Final ---
")
    cat("Vetor das Variáveis de Decisão (x):", round(solucao, 4), "
")
    cat("Valor da Função Objetivo (Z):", round(Z, 4), "
")
    
    # Identificação de Soluções Ótimas Alternativas
    # setdiff(): obtém a diferença dos conjuntos (lista total de variáveis menos as básicas)
    var_nao_basicas <- setdiff(1:(n + m), var_basicas)
    custos_reduzidos_nb <- tableau[m + 1, var_nao_basicas]
    
    if (any(abs(custos_reduzidos_nb) < tol)) {
      cat(">> Soluções alternativas identificadas: custo reduzido nulo em variável não básica. <<
")
    }
    
  } else if (status == "ILIMITADO") {
    cat("
>> Problema Ilimitado. Z pode crescer ao infinito. <<
")
  } else {
    cat("
>> Limite máximo de iterações atingido sem convergência! <<
")
  }
  
  return(list(x = if (status == "OTIMO") solucao else NULL, 
              Z = if (status == "OTIMO") Z else NULL, 
              tableau = tableau, status = status))
}

# ==============================================================================
# CASOS DE VALIDAÇÃO
# ==============================================================================

cat("

################ CASO 1: Solução Ótima Única ################
")
c1 <- c(3, 5)
A1 <- matrix(c(1, 0, 
               0, 2, 
               3, 2), nrow=3, byrow=TRUE)
b1 <- c(4, 12, 18)
res1 <- simplex_max(c1, A1, b1)

cat("

################ CASO 2: Múltiplas Soluções Ótimas ################
")
c2 <- c(4, 2)
A2 <- matrix(c(2, 1, 
               1, 2), nrow=2, byrow=TRUE)
b2 <- c(4, 4)
res2 <- simplex_max(c2, A2, b2)

cat("

################ CASO 3: Degeneração ################
")
c3 <- c(3, 9)
A3 <- matrix(c(1, 4, 
               1, 2), nrow=2, byrow=TRUE)
b3 <- c(8, 4)
res3 <- simplex_max(c3, A3, b3)

cat("

################ CASO 4: Problema Ilimitado ################
")
c4 <- c(2, 1)
A4 <- matrix(c(1, -1, 
               2,  0), nrow=2, byrow=TRUE)
b4 <- c(10, 40)
res4 <- simplex_max(c4, A4, b4)