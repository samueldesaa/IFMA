#ifndef GRAFO_H_INCLUDED
#define GRAFO_H_INCLUDED

typedef struct grafo {
    int eh_ponderado;
    int nro_vert;
    int Gmax;
    int** arestas;
    float** pesos;
    int* grau;
} Grafo;

Grafo* cria_Grafo(int nro_vert, int Gmax, int eh_ponderado);
void libera_Grafo(Grafo* gr);
int insereAresta(Grafo* gr, int orig, int dest, int digrafo, float peso);
int removeAresta(Grafo* gr, int orig, int dest, int eh_digrafo);

#endif // GRAFO_H_INCLUDED
