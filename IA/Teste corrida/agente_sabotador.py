# agente_sabotador.py
class AgenteSabotador:
    def __init__(self, nome):
        self.nome = nome

    def escolher_acao(self, estado):
        # Sempre sabota o agente mais à frente
        posicoes, _ = estado
        lider = max(posicoes, key=posicoes.get)
        if lider != self.nome:
            return f'sabotar_{lider}'
        return 'correr_1'
