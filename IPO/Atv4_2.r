## Resolução em R Puro e Gráfico (Questão 2)

```{r q2_resolucao_e_grafico, echo=TRUE, fig.align='center', fig.height=5, fig.width=7, message=FALSE, warning=FALSE}
# --- Cenário Base ---
c_base <- c(5000, 4000)
A_q2 <- matrix(c(6, 4, 1, 2), nrow = 2, byrow = TRUE)
b_base <- c(24, 6)

sol_base <- resolver_pl_simples(c_base, A_q2, b_base)
cat("--- Cenário Base ---\n")
cat("Ótimo: Exteriores =", sol_base$ponto[1], "ton \vert{} Interiores =", sol_base$ponto[2], "ton\n")
cat("Lucro Base Z = R$", sol_base$maximo_z, "\n\n")

# --- Alínea a ---
b_m1_extra <- c(25, 6)
sol_m1 <- resolver_pl_simples(c_base, A_q2, b_m1_extra)
preco_dual_m1 <- sol_m1$maximo_z - sol_base$maximo_z

b_m2_extra <- c(24, 7)
sol_m2 <- resolver_pl_simples(c_base, A_q2, b_m2_extra)
preco_dual_m2 <- sol_m2$maximo_z - sol_base$maximo_z

cat("--- Alínea a ---\n")
cat("Preço Dual M1: R$", preco_dual_m1, "\n")
cat("Preço Dual M2: R$", preco_dual_m2, "\n")
cat("Conclusão: Vale mais a pena aumentar M1. O custo assumido pode ser de até R$ 750.\n\n")

# --- Alínea b ---
c_aumentado <- c(5500, 4000)
sol_aumentada <- resolver_pl_simples(c_aumentado, A_q2, b_base)

c_reduzido <- c(4500, 4000)
sol_reduzida <- resolver_pl_simples(c_reduzido, A_q2, b_base)

cat("--- Alínea b ---\n")
cat("Com Lucro x1 em R$ 5500 -> Ponto: (", sol_aumentada$ponto[1], ",", sol_aumentada$ponto[2], ") | Novo Z = R$", sol_aumentada$maximo_z, "\n")
cat("Com Lucro x1 em R$ 4500 -> Ponto: (", sol_reduzida$ponto[1], ",", sol_reduzida$ponto[2], ") | Novo Z = R$", sol_reduzida$maximo_z, "\n")
cat("Conclusão: Ambos mantêm o ponto ótimo inalterado (estão na faixa de otimalidade). O lucro de R$ 5500 seria o mais lucrativo.\n")

# --- Gráfico da Questão 2 ---
plot(0, 0, type = "n", xlim = c(0, 8), ylim = c(0, 8),
     xlab = "Tinta para Exteriores (x1)", ylab = "Tinta para Interiores (x2)",
     main = "Análise Gráfica - IF-Tintas (Questão 2)")

# Retas (Isolando x2)
# M1: 6x1 + 4x2 = 24 -> x2 = 6 - 1.5*x1
abline(a = 6, b = -1.5, col = "red", lwd = 2)

# M2: x1 + 2x2 = 6 -> x2 = 3 - 0.5*x1
abline(a = 3, b = -0.5, col = "blue", lwd = 2)

# Polígono da Região Viável
polygon(c(0, 4, 3, 0), c(0, 0, 1.5, 3), col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)

# Pontos de intersecção no primeiro quadrante
pontos_x_q2 <- c(0, 4, 6, 0, 3)
pontos_y_q2 <- c(3, 0, 0, 6, 1.5)

points(pontos_x_q2, pontos_y_q2, col = "black", pch = 19, cex = 1.2)

# Textos
text(0, 3, labels = "(0, 3)", pos = 4, cex = 0.8)
text(4, 0, labels = "(4, 0)", pos = 3, cex = 0.8)
text(6, 0, labels = "(6, 0)", pos = 3, cex = 0.8)
text(0, 6, labels = "(0, 6)", pos = 4, cex = 0.8)
text(3, 1.5, labels = "Ótimo (3, 1.5)", pos = 4, font = 2, cex = 0.9)

# Legenda
legend("topright", legend = c("M1 (6x1 + 4x2 <= 24)", "M2 (x1 + 2x2 <= 6)", "Região Viável"),
       col = c("red", "blue", "gray"),
       lty = c(1, 1, NA), pch = c(NA, NA, 15), lwd = 2, bg = "white")
```