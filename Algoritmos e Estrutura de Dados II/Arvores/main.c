#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "arvAVL.h"
#include "arvBin.h"

#define MAX_ELEM 1000000

// Fun��o para gerar n�meros aleat�rios entre min e max
int rand_int(int min, int max) {
    return min + rand() % (max - min + 1);
}

// Fun��o para preencher uma �rvore bin�ria com elementos aleat�rios
void preencher_arvore_bin(ArvBin *raiz, int total_elems) {
    srand(time(NULL));
    for (int i = 0; i < total_elems; i++) {
        int valor = rand_int(1, MAX_ELEM);
        insere_ArvBin(raiz, valor);
    }
}

// Fun��o para comparar o tempo de inser��o em �rvores bin�rias
void comparar_insercao(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    // Inser��o na �rvore AVL (comentado)
    /*
    inicio = clock();
    preencher_arvore_bin(avl, MAX_ELEM);
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;
    */

    // Inser��o na �rvore bin�ria
    inicio = clock();
    preencher_arvore_bin(bin, MAX_ELEM);
    fim = clock();
    tempo_bin = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    printf("Tempo de insercao em AVL: nao executado\n");
    printf("Tempo de insercao em arvore binaria: %.6f segundos\n", tempo_bin);
}

// Fun��o para comparar o tempo de remo��o em �rvores bin�rias
void comparar_remocao(ArvAVL *avl, ArvBin *bin) {
    clock_t inicio, fim;
    double tempo_avl, tempo_bin;

    // Remo��o na �rvore AVL (comentado)
    /*
    inicio = clock();
    for (int i = 1; i <= MAX_ELEM; i++) {
        remove_ArvAVL(avl, i);
    }
    fim = clock();
    tempo_avl = ((double)(fim - inicio)) / CLOCKS_PER_SEC;
    */

    // Remo��o na �rvore bin�ria
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

    // Compara��o de inser��o
    comparar_insercao(avl, bin);

    // Compara��o de remo��o
    comparar_remocao(avl, bin);

    libera_ArvAVL(avl);
    libera_ArvBin(bin);

    return 0;
}
