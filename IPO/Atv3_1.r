# Carregamento das bibliotecas necessárias
library(ggplot2)
library(dplyr)

# 1. Definição das restrições isolando a variável x2
# R1: x1/6 + x2/5 <= 1 => x2 <= 5 - (5 * x1) / 6
constraint1 <- function(x1) { 
  5 - (5 * x1) / 6 
}

# R2: 2*x1 + x2 <= 6 => x2 <= 6 - 2 * x1
constraint2 <- function(x1) { 
  6 - 2 * x1 
}

# 2. Definição do vetor x1 e criação do DataFrame
x_vals <- seq(0, 7, by = 0.01)

data <- data.frame(
  x1 = x_vals,
  constraint1 = constraint1(x_vals),
  constraint2 = constraint2(x_vals)
)

# Mantendo apenas valores não-negativos para a plotagem (x2 >= 0)
data$constraint1 <- pmax(0, data$constraint1)
data$constraint2 <- pmax(0, data$constraint2)

# 3. Cálculo da região viável
data$feasible <- pmin(data$constraint1, data$constraint2)

# 4. Data frame com os vértices
points_df <- data.frame(
  x = c(0, 0, 6/7, 3),
  y = c(0, 5, 30/7, 0),
  label = c(
    "P0 (0, 0) Z=0",
    "P1 (0, 5) Z=10",
    "P2 (6/7, 30/7) Z=12.85",
    "P3 (3, 0) Z=15"
  )
)

# 5. Visualização
ggplot() +
  
  # Retas das restrições
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint1,
      color = "R1: x1/6 + x2/5 <= 1"
    ),
    linewidth = 1
  ) +
  
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint2,
      color = "R2: 2x1 + x2 <= 6"
    ),
    linewidth = 1
  ) +
  
  # Região viável
  geom_ribbon(
    data = data,
    aes(
      x = x1,
      ymin = 0,
      ymax = feasible
    ),
    fill = "grey",
    alpha = 0.4
  ) +
  
  # Pontos de busca
  geom_point(
    data = points_df,
    aes(x = x, y = y),
    color = "black",
    size = 3
  ) +
  
  # Identificação dos pontos
  geom_text(
    data = points_df,
    aes(
      x = x,
      y = y,
      label = label
    ),
    hjust = -0.15,
    vjust = -0.5,
    fontface = "bold"
  ) +
  
  # Rótulos
  labs(
    title = "Resolução Gráfica - Problema 1 (Região Viável)",
    x = expression(x[1]),
    y = expression(x[2]),
    color = "Restrições"
  ) +
  
  # Cores das restrições
  scale_color_manual(
    values = c(
      "R1: x1/6 + x2/5 <= 1" = "red",
      "R2: 2x1 + x2 <= 6" = "blue"
    )
  ) +
  
  # Eixo X dividido de 1 em 1
  scale_x_continuous(
    breaks = seq(0, 7, by = 1),
    limits = c(0, 7)
  ) +
  
  # Eixo Y dividido de 1 em 1
  scale_y_continuous(
    breaks = seq(0, 7, by = 1),
    limits = c(0, 7)
  ) +
  
  theme_minimal() +
  
  theme(
    legend.position = "bottom"
  )