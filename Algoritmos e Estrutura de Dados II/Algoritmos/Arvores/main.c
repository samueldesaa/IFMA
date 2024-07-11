#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include "arvAVL.h"
#include "arvBin.h"

#define N 5000000
//Samuel Chaves De Sá(20231SI0011)

void preencher_arvore_bin(ArvBin *raiz, int total_elems) {
    srand(time(NULL));
    for (int i = 0; i < total_elems; i++) {
        int valor = 1 + rand();
        insere_ArvBin(raiz, valor);
    }
}

void preencher_arvore_avl(ArvAVL *raiz, int total_elems) {
    srand(time(NULL));
    for (int i = 0; i < total_elems; i++) {
        int valor = 1 + rand();
        insere_ArvAVL(raiz, valor);
    }
}

void comparar_insercao(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    inicio = clock();
    preencher_arvore_avl(avl, N);
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    inicio = clock();
    preencher_arvore_bin(bin, N);
    fim = clock();
    tempo_bin = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("Tempo de insercao em AVL: %.6f segundos\n", tempo_avl);
    printf("Tempo de insercao em arvore binaria: %.6f segundos\n", tempo_bin);
    printf("\nElementos Inseridos! Aperte qualquer tecla!");
    getchar();
}

void comparar_ordem(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    inicio = clock();
    printf("Arvore AVL:\n");
    emOrdem_ArvAVL(avl);
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("\nElementos Inseridos! Aperte qualquer tecla!");
    getchar();

    inicio = clock();
    printf("Arvore binaria:\n");
    emOrdem_ArvBin(bin);
    fim = clock();
    tempo_bin = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("\nArvores ordenadas!");
    printf("\nTempo de ordenacao durante a impressao em AVL: %.6f segundos\n", tempo_avl);
    printf("Tempo de ordenacao durante a impressao em arvore binaria: %.6f segundos\n", tempo_bin);
}

int main() {
    ArvAVL *avl = cria_ArvAVL();
    ArvBin *bin = cria_ArvBin();

    if (avl == NULL || bin == NULL) {
        printf("Erro ao criar as árvores AVL e binária.\n");
        return 1;
    }

    comparar_insercao(avl, bin);
    //comparar_ordem(avl, bin);
    libera_ArvAVL(avl);
    libera_ArvBin(bin);

    return 0;
}
