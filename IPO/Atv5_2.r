
# Carregar o pacote para renderização gráfica
library(ggplot2)

# ==========================================
# 1. CÁLCULO ALGÉBRICO DOS VÉRTICES
# ==========================================

# Vértices candidatos
p_origem_q2 <- c(0, 0)
p_r1_x_q2 <- c(200, 0)
p_r1_y_q2 <- c(0, 100)
p_r2_x_q2 <- c(80, 0)
p_r2_y_q2 <- c(0, 160)

# Interseção entre R1 e R2
matriz_q2 <- matrix(
  c(2, 100, 4, 50),
  nrow = 2
)

termos_q2 <- c(400, 8000)

p_intersecao_q2 <- solve(
  matriz_q2,
  termos_q2
)

# Agrupar os vértices candidatos
vertices_q2 <- rbind(
  p_origem_q2,
  p_r1_x_q2,
  p_r1_y_q2,
  p_r2_x_q2,
  p_r2_y_q2,
  p_intersecao_q2
)

colnames(vertices_q2) <- c("x1", "x2")
vertices_q2 <- round(vertices_q2, 4)

# ==========================================
# 2. FILTRAR A REGIÃO VIÁVEL
# ==========================================

viaveis_q2 <- vertices_q2[
  2 * vertices_q2[, "x1"] +
    4 * vertices_q2[, "x2"] <= 400 &
    100 * vertices_q2[, "x1"] +
    50 * vertices_q2[, "x2"] <= 8000 &
    vertices_q2[, "x1"] >= 0 &
    vertices_q2[, "x2"] >= 0,
  ,
  drop = FALSE
]

# Remover pontos duplicados
viaveis_q2 <- unique(viaveis_q2)

# ==========================================
# 3. CALCULAR A FUNÇÃO OBJETIVO
# ==========================================

Z_q2 <- 50 * viaveis_q2[, "x1"] +
  30 * viaveis_q2[, "x2"]

resultados_q2 <- data.frame(
  x1 = viaveis_q2[, "x1"],
  x2 = viaveis_q2[, "x2"],
  Z = Z_q2
)

# Ordenar do maior para o menor Z
resultados_q2 <- resultados_q2[
  order(-resultados_q2$Z),
  ,
  drop = FALSE
]

rownames(resultados_q2) <- NULL

# Identificar a solução ótima
ponto_otimo_q2 <- resultados_q2[
  1,
  c("x1", "x2"),
  drop = FALSE
]

cat("--- Resultados Algébricos da Questão 2 ---\n")
print(resultados_q2)

cat("\n--- Solução Ótima ---\n")
cat("x1 =", ponto_otimo_q2$x1, "\n")
cat("x2 =", ponto_otimo_q2$x2, "\n")
cat("Z máximo =", resultados_q2$Z[1], "\n")


# ==========================================
# 4. PREPARAR AS RETAS DE RESTRIÇÃO
# ==========================================

# R1: 2x1 + 4x2 = 400
df_r1_q2 <- data.frame(
  x1 = seq(0, 200, by = 1)
)

df_r1_q2$x2 <- (400 - 2 * df_r1_q2$x1) / 4

# R2: 100x1 + 50x2 = 8000
df_r2_q2 <- data.frame(
  x1 = seq(0, 80, by = 1)
)

df_r2_q2$x2 <- (8000 - 100 * df_r2_q2$x1) / 50


# ==========================================
# 5. PREPARAR O POLÍGONO VIÁVEL
# ==========================================

df_poligono_q2 <- as.data.frame(viaveis_q2)

# Ordenar os vértices ao redor do polígono
df_poligono_q2 <- df_poligono_q2[
  chull(
    df_poligono_q2$x1,
    df_poligono_q2$x2
  ),
  ,
  drop = FALSE
]

# Fechar o polígono
df_poligono_q2 <- rbind(
  df_poligono_q2,
  df_poligono_q2[1, ]
)

# Preparar os rótulos dos vértices
df_vertices_q2 <- as.data.frame(viaveis_q2)

df_vertices_q2$rotulo <- paste0(
  "(",
  df_vertices_q2$x1,
  ", ",
  df_vertices_q2$x2,
  ")"
)


# ==========================================
# 6. RENDERIZAÇÃO DO GRÁFICO
# ==========================================

grafico_q2 <- ggplot() +

  # Área da região viável
  geom_polygon(
    data = df_poligono_q2,
    aes(x = x1, y = x2),
    fill = "lightgreen",
    alpha = 0.5
  ) +

  # Reta da primeira restrição
  geom_line(
    data = df_r1_q2,
    aes(
      x = x1,
      y = x2,
      color = "R1: 2x1 + 4x2 = 400"
    ),
    linewidth = 1
  ) +

  # Reta da segunda restrição
  geom_line(
    data = df_r2_q2,
    aes(
      x = x1,
      y = x2,
      color = "R2: 100x1 + 50x2 = 8000"
    ),
    linewidth = 1
  ) +

  # Vértices da região viável
  geom_point(
    data = df_vertices_q2,
    aes(x = x1, y = x2),
    color = "black",
    size = 2.5
  ) +

  # Identificação dos vértices
  geom_text(
    data = df_vertices_q2,
    aes(x = x1, y = x2, label = rotulo),
    color = "black",
    size = 3.5,
    nudge_y = 5,
    check_overlap = TRUE
  ) +

  # Destacar o ponto ótimo
  geom_point(
    data = ponto_otimo_q2,
    aes(x = x1, y = x2),
    color = "red",
    size = 4
  ) +

  # Rótulo da solução ótima
  annotate(
    "text",
    x = ponto_otimo_q2$x1 + 5,
    y = ponto_otimo_q2$x2 - 10,
    label = paste0(
      "Ótimo (",
      ponto_otimo_q2$x1,
      ", ",
      ponto_otimo_q2$x2,
      ")\nZ = ",
      resultados_q2$Z[1]
    ),
    color = "red",
    fontface = "bold",
    hjust = 0
  ) +

  # Cores das restrições
  scale_color_manual(
    name = "Restrições",
    values = c(
      "R1: 2x1 + 4x2 = 400" = "blue",
      "R2: 100x1 + 50x2 = 8000" = "darkgreen"
    )
  ) +

  # Limites dos eixos
  coord_cartesian(
    xlim = c(0, 100),
    ylim = c(0, 110)
  ) +

  # Títulos e rótulos
  labs(
    title = "Resolução Gráfica - Questão 2 (Guarda Tudo)",
    subtitle = "Região viável e solução ótima",
    x = expression(x[1] ~ "(Box Tamanho 1)"),
    y = expression(x[2] ~ "(Box Tamanho 2)")
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
print(grafico_q2)
