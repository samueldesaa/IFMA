import time

# Loop da simulação
encontrado = False
MAX_PASSOS = 1000
# Posição desconhecida do tesouro
TESOURO_POS = -300

# Estado dos agentes
class Agente:
    def __init__(self, nome, estrategia):
        self.nome = nome
        self.estrategia = estrategia
        self.posicao = 0
        self.passo = 1
        self.trajetoria = [0]
        self.tempo = 0
        self.encontrou = False

    def mover(self):
        nova_pos = self.estrategia(self)
        self.posicao = nova_pos
        self.trajetoria.append(nova_pos)
        self.tempo += 1
        if self.posicao == TESOURO_POS:
            self.encontrou = True

# Estratégia 1: busca exponencial (só para direita)
def estrategia_exponencial(agente):
    if agente.tempo % 2 == 0:
        return agente.posicao + agente.passo
    else:
        agente.passo *= 2
        return 0

# Estratégia 2: alternada (zigzag simétrico)
def estrategia_zigzag(agente):
    direção = -1 if (agente.tempo % 2 == 1) else 1
    return 0 + direção * agente.passo

# Estratégia 3: linear constante para frente
def estrategia_linear(agente):
    return agente.posicao + 1

# Criando os agentes
# agentes = [
#     Agente("Exponencial", estrategia_exponencial),
#     Agente("ZigZag", estrategia_zigzag),
#     Agente("Linear", estrategia_linear)
# ]
agentes = [
    Agente("ZigZag", estrategia_zigzag)
]


for _ in range(MAX_PASSOS):
    for agente in agentes:
        if not agente.encontrou:
            agente.mover()
        if agente.encontrou and not encontrado:
            encontrado = True
            print(f"🎉 Tesouro encontrado por {agente.nome} em {agente.tempo} passos! 🏆")
            break
    if encontrado:
        break

# Mostrando resultados
print("\n📊 Trajetórias:")
for agente in agentes:
    print(f"{agente.nome}: {agente.trajetoria}")
