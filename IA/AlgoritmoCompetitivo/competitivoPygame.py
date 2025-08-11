import pygame
import sys
import random

# Configurações gerais
LARGURA = 1400
ALTURA = 300
FPS = 10
ESCALA = 5
ORIGEM_X = LARGURA // 2
AGENTE_Y = [80, 150, 220]

# Parâmetros configuráveis
PASSO_MAXIMO = 100  # Máximo valor de passo permitido
TESOURO_FIXO = -42  # Ou defina, por exemplo, TESOURO_FIXO = 42

# Cores
BRANCO = (255, 255, 255)
PRETO = (0, 0, 0)
AZUL = (0, 128, 255)
VERMELHO = (255, 0, 0)
VERDE = (0, 200, 0)
CINZA = (200, 200, 200)

# Inicialização
pygame.init()
tela = pygame.display.set_mode((LARGURA, ALTURA))
pygame.display.set_caption("Busca Competitiva - Tesouro Fixo")
clock = pygame.time.Clock()
fonte = pygame.font.SysFont(None, 22)

# Classe Agente
class Agente:
    def __init__(self, nome, estrategia, cor, linha):
        self.nome = nome
        self.estrategia = estrategia
        self.cor = cor
        self.y = linha
        self.posicao = 0
        self.passo = 1
        self.trajetoria = [0]
        self.tempo = 0
        self.encontrou = False

    def mover(self):
        nova_pos = self.estrategia(self)
        # Limita o passo máximo
        if abs(nova_pos - self.posicao) > PASSO_MAXIMO:
            nova_pos = self.posicao + PASSO_MAXIMO if nova_pos > self.posicao else self.posicao - PASSO_MAXIMO
        self.posicao = nova_pos
        self.trajetoria.append(nova_pos)
        self.tempo += 1
        if self.posicao == TESOURO_FIXO:
            self.encontrou = True

# Estratégias dos agentes
def estrategia_exponencial(agente):
    if agente.tempo % 2 == 0:
        return agente.posicao + agente.passo
    else:
        agente.passo = min(PASSO_MAXIMO, agente.passo * 2)
        return 0

def estrategia_zigzag(agente):
    if not hasattr(agente, 'direcao'):
        agente.direcao = 1  # Começa indo para a direita
        agente.passo = 1

    pos = agente.posicao + agente.direcao * agente.passo
    agente.direcao *= -1  # Alterna a direção
    agente.passo += 1     # Aumenta a distância gradualmente

    return pos

def estrategia_linear(agente):
    return agente.posicao + 1

# Lista de agentes
agentes = [
    Agente("Exponencial", estrategia_exponencial, AZUL, AGENTE_Y[0]),
    Agente("ZigZag", estrategia_zigzag, VERMELHO, AGENTE_Y[1]),
    Agente("Linear", estrategia_linear, VERDE, AGENTE_Y[2])
]

tesouro = TESOURO_FIXO
rodando = True
encontrado = False

# Desenha a linha com marcações
def desenhar_linha_numerica():
    for i in range(-100, 101, 20):
        x = ORIGEM_X + i * ESCALA
        pygame.draw.line(tela, CINZA, (x, 0), (x, ALTURA), 1)
        label = fonte.render(str(i), True, PRETO)
        tela.blit(label, (x - 10, 5))

# Loop principal
while rodando:
    for evento in pygame.event.get():
        if evento.type == pygame.QUIT:
            rodando = False

    tela.fill(BRANCO)
    desenhar_linha_numerica()
    pygame.draw.line(tela, PRETO, (ORIGEM_X, 0), (ORIGEM_X, ALTURA), 2)

    # Desenha o tesouro fixo
    pos_tesouro_x = ORIGEM_X + tesouro * ESCALA
    pygame.draw.circle(tela, PRETO, (int(pos_tesouro_x), ALTURA // 2), 8)
    tela.blit(fonte.render("Tesouro", True, PRETO), (pos_tesouro_x - 25, ALTURA // 2 + 10))

    for agente in agentes:
        if not agente.encontrou:
            agente.mover()
        x = ORIGEM_X + agente.posicao * ESCALA
        pygame.draw.circle(tela, agente.cor, (int(x), int(agente.y)), 10)
        texto = f"{agente.nome} ({agente.tempo})"
        tela.blit(fonte.render(texto, True, PRETO), (10, agente.y - 10))

        if agente.encontrou and not encontrado:
            encontrado = True
            vencedor = fonte.render(f"{agente.nome} encontrou o tesouro!", True, PRETO)
            tela.blit(vencedor, (LARGURA // 2 - 100, 10))

    pygame.display.flip()
    clock.tick(FPS)

    if encontrado:
        pygame.time.wait(3000)
        rodando = False

pygame.quit()
sys.exit()
