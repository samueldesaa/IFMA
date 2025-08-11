# agente_adaptativo.py
class AgenteAdaptativo:
    def __init__(self, nome):
        self.nome = nome

    def escolher_acao(self, estado):
        posicoes, _ = estado
        minha_pos = posicoes[self.nome]
        lider = max(posicoes, key=posicoes.get)
        if posicoes[lider] - minha_pos > 2:
            return f'sabotar_{lider}'
        else:
            return 'correr_2'
