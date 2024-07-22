#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "avl-tree.h"
#include "rb-tree.h"

#define NUM_ELEMENTS 1560320

// Função para gerar números aleatórios
int rand_int(int min, int max) {
    return min + rand() % (max - min + 1);
}

// Função para comparar inteiros (AVL Tree)
int compare_ints(void *a, void *b) {
    int *pa = (int *)a;
    int *pb = (int *)b;
    return *pa - *pb;
}

// Função para comparar inteiros (RB Tree)
int compare_ints_rb(RBTreeKey a, RBTreeKey b) {
    int *pa = (int *)a;
    int *pb = (int *)b;
    return *pa - *pb;
}

// Função para inserção e busca em AVL Tree
void test_avl_tree() {
    AVLTree *avl_tree = avl_tree_new(compare_ints);
    clock_t start_insert_avl, end_insert_avl, start_search_avl, end_search_avl;
    double total_insert_time_avl, total_search_time_avl;

    srand(time(NULL));

    // Inserção de elementos aleatórios
    start_insert_avl = clock();
    for (int i = 0; i < NUM_ELEMENTS; ++i) {
        int *key = malloc(sizeof(int));
        *key = rand_int(1, 1000000);
        avl_tree_insert(avl_tree, key, NULL);
    }
    end_insert_avl = clock();
    total_insert_time_avl = ((double)(end_insert_avl - start_insert_avl)) / CLOCKS_PER_SEC;

    // Busca de elementos aleatórios
    start_search_avl = clock();
    for (int i = 0; i < NUM_ELEMENTS; ++i) {
        int key_to_find = rand_int(1, 1000000);
        avl_tree_lookup(avl_tree, &key_to_find);
    }
    end_search_avl = clock();
    total_search_time_avl = ((double)(end_search_avl - start_search_avl)) / CLOCKS_PER_SEC;

    // Imprimir tempo de inserção e busca da AVL Tree
    printf("AVL Tree Insertion Time: %.6f seconds\n", total_insert_time_avl);
    printf("AVL Tree Search Time: %.6f seconds\n", total_search_time_avl);

    // Imprimir altura da AVL Tree
    AVLTreeNode *avl_root = avl_tree_root_node(avl_tree);
    int avl_height = avl_tree_subtree_height(avl_root);
    printf("AVL Tree Height: %d\n", avl_height);

    // Liberar memória da AVL Tree
    avl_tree_free(avl_tree);
}

// Função para inserção e busca em Red-Black Tree
void test_rb_tree() {
    RBTree *rb_tree = rb_tree_new(compare_ints_rb);
    clock_t start_insert_rb, end_insert_rb, start_search_rb, end_search_rb;
    double total_insert_time_rb, total_search_time_rb;

    srand(time(NULL));

    // Inserção de elementos aleatórios
    start_insert_rb = clock();
    for (int i = 0; i < NUM_ELEMENTS; ++i) {
        int *key = malloc(sizeof(int));
        *key = rand_int(1, 1000000);
        rb_tree_insert(rb_tree, key, NULL);
    }
    end_insert_rb = clock();
    total_insert_time_rb = ((double)(end_insert_rb - start_insert_rb)) / CLOCKS_PER_SEC;

    // Busca de elementos aleatórios
    start_search_rb = clock();
    for (int i = 0; i < NUM_ELEMENTS; ++i) {
        int key_to_find = rand_int(1, 1000000);
        rb_tree_lookup(rb_tree, &key_to_find);
    }
    end_search_rb = clock();
    total_search_time_rb = ((double)(end_search_rb - start_search_rb)) / CLOCKS_PER_SEC;

    // Imprimir tempo de inserção e busca da RB Tree
    printf("Red-Black Tree Insertion Time: %.6f seconds\n", total_insert_time_rb);
    printf("Red-Black Tree Search Time: %.6f seconds\n", total_search_time_rb);

    // Imprimir altura da RB Tree
    RBTreeNode *rb_root = rb_tree_root_node(rb_tree);
    int rb_height = rb_tree_node_height(rb_root);
    printf("Red-Black Tree Height: %d\n", rb_height);

    // Liberar memória da RB Tree
    rb_tree_free(rb_tree);
}

int main() {
    //for(int i=0;i<2;i++)
    //test_avl_tree();
    //printf("\n");
    //for(int i=0;i<2;i++)
    test_rb_tree();
    printf("\n");

    return 0;
}
