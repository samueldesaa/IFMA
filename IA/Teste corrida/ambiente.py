# ambiente.py
class AmbienteCorrida:
    def __init__(self, tamanho=10):
        self.tamanho = tamanho
        self.posicoes = {'A': 0, 'B': 0, 'C': 0}
        self.sabotados = {'A': False, 'B': False, 'C': False}

    def estado(self):
        return self.posicoes.copy(), self.sabotados.copy()

    def aplicar_acao(self, agente, acao):
        if self.sabotados[agente]:
            self.sabotados[agente] = False  # perdeu a vez
            return

        if acao == 'correr_1':
            self.posicoes[agente] += 1
        elif acao == 'correr_2':
            self.posicoes[agente] += 2
        elif acao.startswith('sabotar_'):
            alvo = acao.split('_')[1]
            self.sabotados[alvo] = True

    def terminou(self):
        for agente, pos in self.posicoes.items():
            if pos >= self.tamanho:
                return True, agente
        return False, None
