#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"

int main() {
    int numVertices = 17827;
    int numArestas = 100000;
    Grafo* grafo = criaGrafo(numVertices, numArestas);

    lerArquivo("Benchmark-grafo.txt", grafo);

    prim(grafo);
    kruskal(grafo);

    free(grafo->arestas);
    free(grafo);

    return 0;
}
