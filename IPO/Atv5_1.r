
# Carregar o pacote para renderização gráfica
library(ggplot2)

# ==========================================
# 1. CÁLCULO ALGÉBRICO DOS VÉRTICES
# ==========================================

# Vértices candidatos
p_origem <- c(0, 0)
p_r1_x <- c(100, 0)
p_r1_y <- c(0, 100)
p_r2_x <- c(135, 0)
p_r2_y <- c(0, 90)

# Interseção entre R1 e R2
matriz_coeficientes <- matrix(
  c(1, 2, 1, 3),
  nrow = 2
)

termos_independentes <- c(100, 270)

p_intersecao <- solve(
  matriz_coeficientes,
  termos_independentes
)

# Agrupar todos os vértices candidatos
vertices <- rbind(
  p_origem,
  p_r1_x,
  p_r1_y,
  p_r2_x,
  p_r2_y,
  p_intersecao
)

colnames(vertices) <- c("x1", "x2")
vertices <- round(vertices, 4)

# Filtrar os vértices que respeitam todas as restrições
viaveis <- vertices[
  vertices[, "x1"] + vertices[, "x2"] <= 100 &
    2 * vertices[, "x1"] + 3 * vertices[, "x2"] <= 270 &
    vertices[, "x1"] >= 0 &
    vertices[, "x2"] >= 0,
  ,
  drop = FALSE
]

# Remover pontos duplicados
viaveis <- unique(viaveis)

# Calcular a função objetivo
Z <- 10 * viaveis[, "x1"] + 12 * viaveis[, "x2"]

resultados <- data.frame(
  x1 = viaveis[, "x1"],
  x2 = viaveis[, "x2"],
  Z = Z
)

# Ordenar do maior para o menor valor de Z
resultados <- resultados[
  order(-resultados$Z),
  ,
  drop = FALSE
]

rownames(resultados) <- NULL

# Identificar o ponto ótimo
ponto_otimo <- resultados[1, c("x1", "x2"), drop = FALSE]

cat("--- Resultados Algébricos da Questão 1 ---\n")
print(resultados)

cat("\n--- Solução Ótima ---\n")
cat("x1 =", ponto_otimo$x1, "\n")
cat("x2 =", ponto_otimo$x2, "\n")
cat("Z máximo =", resultados$Z[1], "\n")


# ==========================================
# 2. PREPARAÇÃO DAS RETAS DE RESTRIÇÃO
# ==========================================

x1_seq <- seq(0, 140, by = 1)

df_linhas <- data.frame(
  x1 = x1_seq,
  R1 = 100 - x1_seq,
  R2 = (270 - 2 * x1_seq) / 3
)

# Manter apenas os trechos das retas no primeiro quadrante
df_r1 <- data.frame(
  x1 = seq(0, 100, by = 1)
)
df_r1$x2 <- 100 - df_r1$x1

df_r2 <- data.frame(
  x1 = seq(0, 135, by = 1)
)
df_r2$x2 <- (270 - 2 * df_r2$x1) / 3


# ==========================================
# 3. PREPARAÇÃO DO POLÍGONO VIÁVEL
# ==========================================

df_poligono <- as.data.frame(viaveis)

# Ordenar os vértices ao redor do polígono
df_poligono <- df_poligono[
  chull(df_poligono$x1, df_poligono$x2),
  ,
  drop = FALSE
]

# Repetir o primeiro vértice para fechar o polígono
df_poligono <- rbind(
  df_poligono,
  df_poligono[1, ]
)

# Preparar os vértices para exibição no gráfico
df_vertices <- as.data.frame(viaveis)

df_vertices$rotulo <- paste0(
  "(",
  df_vertices$x1,
  ", ",
  df_vertices$x2,
  ")"
)


# ==========================================
# 4. RENDERIZAÇÃO DO GRÁFICO
# ==========================================

grafico_q1 <- ggplot() +

  # Região viável
  geom_polygon(
    data = df_poligono,
    aes(x = x1, y = x2),
    fill = "lightblue",
    alpha = 0.5
  ) +

  # Retas das restrições
  geom_line(
    data = df_r1,
    aes(x = x1, y = x2, color = "R1: x1 + x2 = 100"),
    linewidth = 1
  ) +

  geom_line(
    data = df_r2,
    aes(x = x1, y = x2, color = "R2: 2x1 + 3x2 = 270"),
    linewidth = 1
  ) +

  # Todos os vértices viáveis
  geom_point(
    data = df_vertices,
    aes(x = x1, y = x2),
    color = "black",
    size = 2.5
  ) +

  # Rótulos dos vértices
  geom_text(
    data = df_vertices,
    aes(x = x1, y = x2, label = rotulo),
    color = "black",
    size = 3.5,
    nudge_y = 4,
    check_overlap = TRUE
  ) +

  # Ponto ótimo
  geom_point(
    data = ponto_otimo,
    aes(x = x1, y = x2),
    color = "red",
    size = 4
  ) +

  # Rótulo do ponto ótimo
  annotate(
    "text",
    x = ponto_otimo$x1 + 8,
    y = ponto_otimo$x2 - 5,
    label = paste0(
      "Ótimo (",
      ponto_otimo$x1,
      ", ",
      ponto_otimo$x2,
      ")\nZ = ",
      resultados$Z[1]
    ),
    color = "red",
    fontface = "bold",
    hjust = 0
  ) +

  # Configurações dos eixos e da legenda
  scale_color_manual(
    name = "Restrições",
    values = c(
      "R1: x1 + x2 = 100" = "blue",
      "R2: 2x1 + 3x2 = 270" = "darkgreen"
    )
  ) +

  coord_cartesian(
    xlim = c(0, 140),
    ylim = c(0, 110)
  ) +

  labs(
    title = "Resolução Gráfica - Questão 1",
    subtitle = "Região viável e solução ótima",
    x = expression(x[1]),
    y = expression(x[2])
  ) +

  theme_minimal() +

  theme(
    plot.title = element_text(
      face = "bold",
      size = 14
    ),
    legend.position = "bottom"
  )

# Exibir o gráfico
print(grafico_q1)
