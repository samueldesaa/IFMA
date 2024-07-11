#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "arvAVL.h"
#include "arvBin.h"

#define MAX_ELEM 1000000

// Função para gerar números aleatórios entre min e max
int rand_int(int min, int max) {
    return min + rand() % (max - min + 1);
}

// Função para preencher uma árvore binária com elementos aleatórios
void preencher_arvore_bin(ArvBin *raiz, int total_elems) {
    srand(time(NULL));
    for (int i = 0; i < total_elems; i++) {
        int valor = rand_int(1, MAX_ELEM);
        insere_ArvBin(raiz, valor);
    }
}

// Função para comparar o tempo de inserção em árvores binárias
void comparar_insercao(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    // Inserção na árvore AVL (comentado)
    /*
    inicio = clock();
    preencher_arvore_bin(avl, MAX_ELEM);
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;
    */

    // Inserção na árvore binária
    inicio = clock();
    preencher_arvore_bin(bin, MAX_ELEM);
    fim = clock();
    tempo_bin = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("Tempo de insercao em AVL: nao executado\n");
    printf("Tempo de insercao em arvore binaria: %.6f segundos\n", tempo_bin);
}

// Função para comparar o tempo de remoção em árvores binárias
void comparar_remocao(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    // Remoção na árvore AVL (comentado)
    /*
    inicio = clock();
    for (int i = 1; i <= MAX_ELEM; i++) {
        remove_ArvAVL(avl, i);
    }
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;
    */

    // Remoção na árvore binária
    inicio = clock();
    for (int i = 1; i <= MAX_ELEM; i++) {
        remove_ArvBin(bin, i);
    }
    fim = clock();
    tempo_bin = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("Tempo de remocao em AVL: nao executado\n");
    printf("Tempo de remocao em arvore binaria: %.6f segundos\n", tempo_bin);
}

int main() {
    ArvAVL *avl = cria_ArvAVL();
    ArvBin *bin = cria_ArvBin();

    // Comparação de inserção
    comparar_insercao(avl, bin);

    // Comparação de remoção
    comparar_remocao(avl, bin);

    libera_ArvAVL(avl);
    libera_ArvBin(bin);

    return 0;
}
