#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "arvAVL.h"
#include "
#include "tree_red_black.h"

int generate_random_number() {
    return rand() % 10000;
}

int main() {
    srand(time(NULL));

    int n = 1000;

    // ArvAVL* avl_tree = cria_ArvAVL();
    TNoRB *rb_tree = NULL;

    for (int i = 0; i < n; i++) {
        int num = generate_random_number();
        // insere_ArvAVL(avl_tree, num);
        insereNo(&rb_tree, NULL, &rb_tree, num);
    }

    int search_key = generate_random_number();

    // clock_t avl_start_time = clock();
    // int avl_found = consulta_ArvAVL(avl_tree, search_key);
    // clock_t avl_end_time = clock();

    clock_t rb_start_time = clock();
    TNoRB *rb_result = buscaNo(rb_tree, search_key);
    clock_t rb_end_time = clock();

    // double avl_execution_time = ((double)(avl_end_time - avl_start_time)) / CLOCKS_PER_SEC;
    double rb_execution_time = ((double)(rb_end_time - rb_start_time)) / CLOCKS_PER_SEC;

    // if (avl_found)
    //     printf("Elemento %d encontrado na AVL\n", search_key);
    // else
    //     printf("Elemento %d não encontrado na AVL\n", search_key);

    if (rb_result != NULL)
        printf("Elemento %d encontrado na Red-Black Tree\n", search_key);
    else
        printf("Elemento %d não encontrado na Red-Black Tree\n", search_key);

    // printf("Tempo de execução para busca na AVL: %.6f segundos\n", avl_execution_time);
    printf("Tempo de execução para busca na Red-Black Tree: %.6f segundos\n", rb_execution_time);

    // libera_ArvAVL(avl_tree);
    libera_RBT(rb_tree);

    return 0;
}
