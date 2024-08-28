#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>
#include "grafo.h"

Grafo* criaGrafo(int numVertices, int numArestas) {
    Grafo* grafo = (Grafo*)malloc(sizeof(Grafo));
    grafo->numVertices = numVertices;
    grafo->numArestas = numArestas;
    grafo->arestas = (Aresta*)malloc(numArestas * sizeof(Aresta));
    return grafo;
}

void adicionarAresta(Grafo* grafo, int origem, int destino, float peso, int indice) {
    grafo->arestas[indice].origem = origem;
    grafo->arestas[indice].destino = destino;
    grafo->arestas[indice].peso = peso;
}

int encontrar(Subconjunto subconjuntos[], int i) {
    if (subconjuntos[i].pai != i)
        subconjuntos[i].pai = encontrar(subconjuntos, subconjuntos[i].pai);
    return subconjuntos[i].pai;
}

void unir(Subconjunto subconjuntos[], int x, int y) {
    int raizX = encontrar(subconjuntos, x);
    int raizY = encontrar(subconjuntos, y);

    if (subconjuntos[raizX].rank < subconjuntos[raizY].rank)
        subconjuntos[raizX].pai = raizY;
    else if (subconjuntos[raizX].rank > subconjuntos[raizY].rank)
        subconjuntos[raizY].pai = raizX;
    else {
        subconjuntos[raizY].pai = raizX;
        subconjuntos[raizX].rank++;
    }
}

int compararArestas(const void* a, const void* b) {
    Aresta* arestaA = (Aresta*)a;
    Aresta* arestaB = (Aresta*)b;
    return (arestaA->peso > arestaB->peso) - (arestaA->peso < arestaB->peso);
}

void kruskal(Grafo* grafo) {
    int V = grafo->numVertices;
    Aresta* resultado = (Aresta*)malloc((V - 1) * sizeof(Aresta));
    int e = 0, i = 0;

    qsort(grafo->arestas, grafo->numArestas, sizeof(Aresta), compararArestas);

    Subconjunto* subconjuntos = (Subconjunto*)malloc(V * sizeof(Subconjunto));
    for (int v = 0; v < V; v++) {
        subconjuntos[v].pai = v;
        subconjuntos[v].rank = 0;
    }

    while (e < V - 1 && i < grafo->numArestas) {
        Aresta proximaAresta = grafo->arestas[i++];
        int x = encontrar(subconjuntos, proximaAresta.origem);
        int y = encontrar(subconjuntos, proximaAresta.destino);

        if (x != y) {
            resultado[e++] = proximaAresta;
            unir(subconjuntos, x, y);
        }
    }

    printf("Arvore Geradora Minima (Kruskal) - Primeiras 20 arestas:\n");
    for (int j = 0; j < e && j < 20; j++)
        printf("%d -- %d == %.2f\n", resultado[j].origem, resultado[j].destino, resultado[j].peso);

    free(subconjuntos);
    free(resultado);
}

int minChave(float chave[], int visitado[], int V) {
    int minIndice;
    float min = INFINITY;

    for (int v = 0; v < V; v++)
        if (visitado[v] == 0 && chave[v] < min) {
            min = chave[v];
            minIndice = v;
        }

    return minIndice;
}

void prim(Grafo* grafo) {
    int V = grafo->numVertices;
    float chave[V];
    int pai[V];
    int visitado[V];

    for (int i = 0; i < V; i++) {
        chave[i] = INFINITY;
        visitado[i] = 0;
    }

    chave[0] = 0;
    pai[0] = -1;

    for (int count = 0; count < V - 1; count++) {
        int u = minChave(chave, visitado, V);
        visitado[u] = 1;

        for (int i = 0; i < grafo->numArestas; i++) {
            int v = (grafo->arestas[i].origem == u) ? grafo->arestas[i].destino :
                     (grafo->arestas[i].destino == u) ? grafo->arestas[i].origem : -1;

            if (v != -1 && visitado[v] == 0 && grafo->arestas[i].peso < chave[v]) {
                chave[v] = grafo->arestas[i].peso;
                pai[v] = u;
            }
        }
    }

    printf("Arvore Geradora Minima (Prim) - Primeiras 20 arestas:\n");
    for (int i = 1; i < V && i < 20; i++)
        printf("%d -- %d == %.2f\n", pai[i], i, chave[i]);
}

void lerArquivo(char* nomeArquivo, Grafo* grafo) {
    FILE* arquivo = fopen(nomeArquivo, "r");
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo.\n");
        exit(1);
    }

    int maxCoord, numVertices;
    fscanf(arquivo, "%d %d", &maxCoord, &numVertices);

    int origem, destino, indice = 0;
    char label;
    while (fscanf(arquivo, " %c %d %d", &label, &origem, &destino) != EOF) {
        if (label == 'e') {
            adicionarAresta(grafo, origem - 1, destino - 1, 1.0, indice++);
        }
    }

    fclose(arquivo);
}
