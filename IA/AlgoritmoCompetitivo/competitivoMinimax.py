import pygame
import sys

# --- Seu algoritmo competitivo ---

TESOURO_POS = 5
MAX_PROFUNDIDADE = 3
AÇÕES = [-1, 0, 1]

class Estado:
    def __init__(self, posicoes, turno):
        self.posicoes = list(posicoes)
        self.turno = turno

    def mover(self, acao):
        nova_pos = list(self.posicoes)
        nova_pos[self.turno] += acao
        return Estado(nova_pos, (self.turno + 1) % 3)

    def terminou(self):
        return TESOURO_POS in self.posicoes

    def vencedor(self):
        for i, pos in enumerate(self.posicoes):
            if pos == TESOURO_POS:
                return i
        return None

def utilidade(estado, agente):
    if estado.vencedor() == agente:
        return 100
    elif estado.vencedor() is not None:
        return -100
    return -abs(estado.posicoes[agente] - TESOURO_POS)

def minimax(estado, profundidade, agente_max):
    if profundidade == 0 or estado.terminou():
        return utilidade(estado, agente_max), None

    melhor_valor = float('-inf') if estado.turno == agente_max else float('inf')
    melhor_acao = None

    for acao in AÇÕES:
        novo_estado = estado.mover(acao)
        valor, _ = minimax(novo_estado, profundidade - 1, agente_max)

        if estado.turno == agente_max:
            if valor > melhor_valor:
                melhor_valor = valor
                melhor_acao = acao
        else:
            if valor < melhor_valor:
                melhor_valor = valor
                melhor_acao = acao

    return melhor_valor, melhor_acao


# --- Jogo Pygame ---

pygame.init()

# Tela e cores
LARGURA, ALTURA = 600, 200
TELA = pygame.display.set_mode((LARGURA, ALTURA))
pygame.display.set_caption("Corrida do Tesouro - Minimax vs Ingênuos")
BRANCO = (255, 255, 255)
PRETO = (0, 0, 0)
VERDE = (0, 200, 0)
VERMELHO = (200, 0, 0)
AZUL = (0, 0, 200)
AMARELO = (255, 255, 0)

# Posições na linha (convertendo posição lógica para pixels)
def pos_to_pixel(pos):
    start_x = 50
    spacing = 100
    return start_x + pos * spacing

# Estado inicial
posicoes = [0, -3, 3]  # A, B, C
turno = 0
estado = Estado(posicoes, turno)
agente_minimax = 0  # A é Minimax

font = pygame.font.SysFont(None, 36)
clock = pygame.time.Clock()

jogo_rodando = True

while jogo_rodando:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            jogo_rodando = False

    if estado.terminou():
        jogo_rodando = False
        continue

    # Ação do agente do turno atual
    if estado.turno == agente_minimax:
        _, acao = minimax(estado, MAX_PROFUNDIDADE, agente_minimax)
    else:
        alvo = TESOURO_POS
        pos_atual = estado.posicoes[estado.turno]
        if pos_atual < alvo:
            acao = 1
        elif pos_atual > alvo:
            acao = -1
        else:
            acao = 0

    estado = estado.mover(acao)

    # Desenho da tela
    TELA.fill(BRANCO)

    # Linha do caminho
    pygame.draw.line(TELA, PRETO, (50, ALTURA//2), (550, ALTURA//2), 4)

    # Marca o tesouro
    tesouro_x = pos_to_pixel(TESOURO_POS)
    pygame.draw.rect(TELA, AMARELO, (tesouro_x - 15, ALTURA//2 - 40, 30, 30))
    texto_tesouro = font.render("Tesouro", True, PRETO)
    TELA.blit(texto_tesouro, (tesouro_x - 35, ALTURA//2 - 70))

    # Desenha os agentes
    cores = [VERDE, VERMELHO, AZUL]
    nomes = ['A (Minimax)', 'B (Ingênuo)', 'C (Ingênuo)']
    for i, pos in enumerate(estado.posicoes):
        x = pos_to_pixel(pos)
        y = ALTURA//2 + 20 + i*30
        pygame.draw.circle(TELA, cores[i], (x, y), 15)
        texto = font.render(nomes[i], True, PRETO)
        TELA.blit(texto, (x - 50, y + 20))

    # Indica o turno atual
    turno_text = font.render(f"Turno: {nomes[estado.turno]}", True, PRETO)
    TELA.blit(turno_text, (20, 20))

    pygame.display.flip()
    clock.tick(1)  # 1 passo por segundo para facilitar visualização

# Mostrar resultado final
TELA.fill(BRANCO)
vencedor = estado.vencedor()
texto_final = font.render(f"Fim de jogo! Vencedor: {nomes[vencedor]}", True, PRETO)
TELA.blit(texto_final, (50, ALTURA//2 - 20))
pygame.display.flip()

# Espera fechar a janela
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
