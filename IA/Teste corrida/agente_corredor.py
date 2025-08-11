# agente_corredor.py
class AgenteCorredor:
    def __init__(self, nome):
        self.nome = nome

    def escolher_acao(self, estado):
        # Sempre tenta correr 2
        return 'correr_2'
