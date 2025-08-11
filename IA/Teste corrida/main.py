# main.py
from ambiente import AmbienteCorrida
from agente_corredor import AgenteCorredor
from agente_sabotador import AgenteSabotador
from agente_adaptativo import AgenteAdaptativo

agentes = {
    'A': AgenteCorredor('A'),
    'B': AgenteSabotador('B'),
    'C': AgenteAdaptativo('C'),
}

ambiente = AmbienteCorrida(tamanho=10)

rodada = 1
while True:
    print(f"Rodada {rodada}")
    for nome, agente in agentes.items():
        estado = ambiente.estado()
        acao = agente.escolher_acao(estado)
        print(f"{nome} escolheu: {acao}")
        ambiente.aplicar_acao(nome, acao)

    for nome, pos in ambiente.posicoes.items():
        print(f"{nome}: posição {pos}")

    fim, vencedor = ambiente.terminou()
    if fim:
        print(f"\n🏆 VENCEDOR: {vencedor}")
        break

    print("-" * 30)
    rodada += 1
