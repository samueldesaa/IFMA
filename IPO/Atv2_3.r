# Carregamento das bibliotecas necessárias
library(ggplot2)
library(dplyr)

# 1. Definição das restrições isolando a variável x2
# R1: 2*x1 + x2 <= 1000 => x2 <= 1000 - 2*x1
constraint1 <- function(x1) { 
  1000 - 2 * x1 
}

# R2: x1 + x2 <= 800 => x2 <= 800 - x1
constraint2 <- function(x1) { 
  800 - x1 
}

# 2. Definição do vetor x1 e criação do DataFrame
x_vals <- seq(0, 900, by = 1)

data <- data.frame(
  x1 = x_vals,
  constraint1 = constraint1(x_vals),
  constraint2 = constraint2(x_vals)
)

# 3. Cálculo da região viável
# pmin compara R1, R2 e o teto da R4 (700)
data$feasible <- pmin(
  data$constraint1,
  data$constraint2,
  700
)

# Limitando a região viável pela restrição R3 (x1 <= 400)
# e pela não-negatividade
data$feasible <- ifelse(
  data$x1 <= 400 & data$feasible >= 0,
  data$feasible,
  NA
)

# 4. Data frame com os vértices
points_df <- data.frame(
  x = c(0, 0, 100, 200, 400, 400),
  y = c(0, 700, 700, 600, 200, 0),
  label = c(
    "P0(0,0) Z=0",
    "P1(0,700) Z=2100",
    "P2(100,700) Z=2500",
    "P3(200,600) Z=2600",
    "P4(400,200) Z=2200",
    "P5(400,0) Z=1600"
  ),
  
  # Ajustes da posição dos textos
  vjust_adj = c(
    -0.5, -1.0, 1.5, -0.8, 1.5, -0.5
  ),
  
  hjust_adj = c(
    -0.1, -0.1, -0.1, -0.1, -0.1, -0.1
  )
)

# 5. Visualização
ggplot() +
  
  # R1
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint1,
      color = "R1: 2x1 + x2 <= 1000"
    ),
    linewidth = 1
  ) +
  
  # R2
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint2,
      color = "R2: x1 + x2 <= 800"
    ),
    linewidth = 1
  ) +
  
  # R3: x1 <= 400
  geom_vline(
    aes(
      xintercept = 400,
      color = "R3: x1 <= 400"
    ),
    linewidth = 1,
    linetype = "dashed"
  ) +
  
  # R4: x2 <= 700
  geom_hline(
    aes(
      yintercept = 700,
      color = "R4: x2 <= 700"
    ),
    linewidth = 1,
    linetype = "dashed"
  ) +
  
  # Região viável
  geom_ribbon(
    data = data,
    aes(
      x = x1,
      ymin = 0,
      ymax = feasible
    ),
    fill = "lightblue",
    alpha = 0.5
  ) +
  
  # Pontos de busca
  geom_point(
    data = points_df,
    aes(x = x, y = y),
    color = "black",
    size = 3
  ) +
  
  # Rótulos dos pontos
  geom_text(
    data = points_df,
    aes(
      x = x,
      y = y,
      label = label,
      vjust = vjust_adj,
      hjust = hjust_adj
    ),
    fontface = "bold",
    size = 3.5
  ) +
  
  # Rótulos
  labs(
    title = "Resolução Gráfica - Problema 3 (Região Viável)",
    x = expression(x[1]),
    y = expression(x[2]),
    color = "Restrições"
  ) +
  
  # Cores das restrições
  scale_color_manual(
    values = c(
      "R1: 2x1 + x2 <= 1000" = "red",
      "R2: x1 + x2 <= 800" = "blue",
      "R3: x1 <= 400" = "darkgreen",
      "R4: x2 <= 700" = "orange"
    )
  ) +
  
  # Eixo X: divisões de 100 em 100
  scale_x_continuous(
    breaks = seq(0, 900, by = 100),
    limits = c(0, 900)
  ) +
  
  # Eixo Y: divisões de 100 em 100
  scale_y_continuous(
    breaks = seq(0, 1100, by = 100),
    limits = c(0, 1100)
  ) +
  
  theme_minimal() +
  
  theme(
    legend.position = "right"
  )