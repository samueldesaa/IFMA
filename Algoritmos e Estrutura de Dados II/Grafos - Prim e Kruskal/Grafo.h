#ifndef GRAFO_H
#define GRAFO_H

#define INFINITY FLT_MAX

typedef struct {
    int origem, destino;
    float peso;
} Aresta;

typedef struct {
    int numVertices, numArestas;
    Aresta* arestas;
} Grafo;

typedef struct {
    int pai;
    int rank;
} Subconjunto;

Grafo* criaGrafo(int numVertices, int numArestas);
void adicionarAresta(Grafo* grafo, int origem, int destino, float peso, int indice);
void lerArquivo(char* nomeArquivo, Grafo* grafo);

int encontrar(Subconjunto subconjuntos[], int i);
void unir(Subconjunto subconjuntos[], int x, int y);

void kruskal(Grafo* grafo);
void prim(Grafo* grafo);
int minChave(float chave[], int visitado[], int V);

#endif
