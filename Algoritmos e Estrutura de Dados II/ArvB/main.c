#include <stdio.h>
#include "btree.h"

int main() {
    int n;
    // Número de chaves
    chaves = 101;
    MIN = (chaves + 1) / 2;
    // Número de elementos
    n = 1000000000;

    measureInsertionTime(n);
    int h = height(root);
    printf("Altura da árvore: %d\n\n", h);

    //for(int i=0;i<10;i++){
    //    measureInsertionTime(n);
    //    measureSearchTime(n);
    //    int h = height(root);
    //    printf("Altura da árvore: %d\n\n", h);
    //}
    return 0;
}
