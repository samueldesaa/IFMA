# Carregamento das bibliotecas necessárias
library(ggplot2)
library(dplyr)

# 1. Definição das restrições isolando a variável x2
# R1: x1 + x2 >= 5 => x2 >= 5 - x1
constraint1 <- function(x1) { 
  5 - x1 
}

# R2: 20x1 + 10x2 <= 80
# => 10x2 <= 80 - 20x1
# => x2 <= 8 - 2*x1
constraint2 <- function(x1) { 
  8 - 2 * x1 
}

# 2. Definição do vetor x1 e criação do DataFrame base
x_vals <- seq(0, 6, by = 0.01)

data <- data.frame(
  x1 = x_vals,
  constraint1 = constraint1(x_vals),
  constraint2 = constraint2(x_vals)
)

# 3. Limites da região viável
# A região viável é limitada inferiormente por R1
# e superiormente por R2
data$ymin <- pmax(0, data$constraint1)
data$ymax <- data$constraint2

# Filtra apenas a região onde o limite superior
# é maior ou igual ao limite inferior
data$feasible_ymin <- ifelse(
  data$ymax >= data$ymin,
  data$ymin,
  NA
)

data$feasible_ymax <- ifelse(
  data$ymax >= data$ymin,
  data$ymax,
  NA
)

# 4. Data frame com os vértices
points_df <- data.frame(
  x = c(3, 0, 0),
  y = c(2, 5, 8),
  label = c(
    "P0 (3, 2) Z=110k",
    "P1 (0, 5) Z=50k",
    "P2 (0, 8) Z=80k"
  )
)

# 5. Visualização usando ggplot2
ggplot() +
  
  # Reta da restrição R1
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint1,
      color = "R1: x1 + x2 >= 5"
    ),
    linewidth = 1
  ) +
  
  # Reta da restrição R2
  geom_line(
    data = data,
    aes(
      x = x1,
      y = constraint2,
      color = "R2: 20x1 + 10x2 <= 80"
    ),
    linewidth = 1
  ) +
  
  # Preenchimento da região viável
  geom_ribbon(
    data = data,
    aes(
      x = x1,
      ymin = feasible_ymin,
      ymax = feasible_ymax
    ),
    fill = "lightgreen",
    alpha = 0.5
  ) +
  
  # Plotagem dos vértices
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
    hjust = -0.1,
    vjust = 1.2,
    fontface = "bold"
  ) +
  
  # Formatação do gráfico
  labs(
    title = "Resolução Gráfica - Problema 2 (Região Viável)",
    x = expression(x[1]),
    y = expression(x[2]),
    color = "Restrições"
  ) +
  
  # Cores das restrições
  scale_color_manual(
    values = c(
      "R1: x1 + x2 >= 5" = "orange",
      "R2: 20x1 + 10x2 <= 80" = "purple"
    )
  ) +
  
  # Eixo X: divisões de 1 em 1
  scale_x_continuous(
    breaks = seq(0, 6, by = 1),
    limits = c(0, 6)
  ) +
  
  # Eixo Y: divisões de 1 em 1
  scale_y_continuous(
    breaks = seq(0, 10, by = 1),
    limits = c(0, 10)
  ) +
  
  theme_minimal() +
  
  theme(
    legend.position = "bottom"
  )