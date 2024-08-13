#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>
#include "Grafo.h"

typedef struct {
    int id; // Rótulo do vértice
    int x, y; // Coordenadas do vértice
} Vertice;

// Função para ler o arquivo de entrada
void lerArquivo(char* nomeArquivo, Vertice** vertices, int* numVertices, int* maxCoord) {
    FILE* arquivo = fopen(nomeArquivo, "r");
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo.\n");
        exit(1);
    }

    fscanf(arquivo, "%d %d", maxCoord, numVertices);

    *vertices = (Vertice*) malloc(*numVertices * sizeof(Vertice));
    if (*vertices == NULL) {
        printf("Erro ao alocar memória.\n");
        exit(1);
    }

    for (int i = 0; i < *numVertices; i++) {
        int id, x, y;
        fscanf(arquivo, "%d %d %d", &id, &x, &y);
        (*vertices)[i].id = id;
        (*vertices)[i].x = x;
        (*vertices)[i].y = y;
    }

    fclose(arquivo);
}

double calcularDistancia(Vertice v1, Vertice v2) {
    int xd = v1.x - v2.x;
    int yd = v1.y - v2.y;
    return round(sqrt(xd * xd + yd * yd));
}

bool existeAresta(Grafo* gr, int orig, int dest) {
    for (int i = 0; i < gr->grau[orig]; i++) {
        if (gr->arestas[orig][i] == dest) {
            return true;
        }
    }
    return false;
}

void criarGrafoSimples(Grafo* gr, Vertice* vertices, int numVertices) {
    srand(time(NULL));

    for (int i = 0; i < numVertices; i++) {
        int grau = 0;

        while (grau < 10) {
            int j = rand() % numVertices;

            if (i != j && !existeAresta(gr, i, j)) {
                double dist = calcularDistancia(vertices[i], vertices[j]);
                insereAresta(gr, i, j, 0, dist);
                grau++;
            }
        }
    }
}

void buscaEmLargura(Grafo* gr, int inicio, int destino) {
    bool* visitado = (bool*) malloc(gr->nro_vert * sizeof(bool));
    for (int i = 0; i < gr->nro_vert; i++) visitado[i] = false;

    int* fila = (int*) malloc(gr->nro_vert * sizeof(int));
    int frente = 0, tras = 0;

    fila[tras++] = inicio;
    visitado[inicio] = true;

    while (frente < tras) {
        int v = fila[frente++];
        if (v == destino) {
            free(fila);
            free(visitado);
            return;
        }
        for (int i = 0; i < gr->grau[v]; i++) {
            int adj = gr->arestas[v][i];
            if (!visitado[adj]) {
                visitado[adj] = true;
                fila[tras++] = adj;
            }
        }
    }
    free(fila);
    free(visitado);
}

void dfsUtil(Grafo* gr, int v, int destino, bool* visitado) {
    if (v == destino) return;
    visitado[v] = true;
    for (int i = 0; i < gr->grau[v]; i++) {
        int adj = gr->arestas[v][i];
        if (!visitado[adj]) {
            dfsUtil(gr, adj, destino, visitado);
        }
    }
}

void buscaEmProfundidade(Grafo* gr, int inicio, int destino) {
    bool* visitado = (bool*) malloc(gr->nro_vert * sizeof(bool));
    for (int i = 0; i < gr->nro_vert; i++) visitado[i] = false;

    dfsUtil(gr, inicio, destino, visitado);
    free(visitado);
}

double medirTempoBusca(Grafo* gr, int inicio, int destino, void (*busca)(Grafo*, int, int)) {
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    busca(gr, inicio, destino);
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    return cpu_time_used;
}

double calcularMedia(double* tempos, int n) {
    double soma = 0.0;
    for (int i = 0; i < n; i++) soma += tempos[i];
    return soma / n;
}

double calcularDesvioPadrao(double* tempos, int n) {
    double media = calcularMedia(tempos, n);
    double soma = 0.0;
    for (int i = 0; i < n; i++) soma += (tempos[i] - media) * (tempos[i] - media);
    return sqrt(soma / (n - 1));
}

double calcularTesteT(double* tempos1, double* tempos2, int n) {
    double media1 = calcularMedia(tempos1, n);
    double media2 = calcularMedia(tempos2, n);
    double desvio1 = calcularDesvioPadrao(tempos1, n);
    double desvio2 = calcularDesvioPadrao(tempos2, n);

    double erroPadrao = sqrt((desvio1 * desvio1 / n) + (desvio2 * desvio2 / n));
    return (media1 - media2) / erroPadrao;
}

#define NUM_EXECUCOES 50

int main() {
    Vertice* vertices;
    int numVertices, maxCoord;

    lerArquivo("Benchmark-grafo.txt", &vertices, &numVertices, &maxCoord);

    Grafo* gr = cria_Grafo(numVertices, numVertices * 10 / 2, 1);

    criarGrafoSimples(gr, vertices, numVertices);
    int inicio = rand() % 17827;
    int destino = rand() % 17827;
    printf("Ponto 1: %d\nPonto 2: %d\n", inicio, destino);

    double temposBFS[NUM_EXECUCOES];
    double temposDFS[NUM_EXECUCOES];

    FILE* arquivoCSV = fopen("relatorios.csv", "w");
    if (arquivoCSV == NULL) {
        printf("Erro ao criar o arquivo CSV.\n");
        return 1;
    }
    fprintf(arquivoCSV, "Execucao,TempoBFS,TempoDFS\n");

    for (int i = 0; i < NUM_EXECUCOES; i++) {
        temposBFS[i] = medirTempoBusca(gr, inicio, destino, buscaEmLargura);
        temposDFS[i] = medirTempoBusca(gr, inicio, destino, buscaEmProfundidade);
        fprintf(arquivoCSV, "%d,%f,%f\n", i + 1, temposBFS[i], temposDFS[i]);
    }

    fclose(arquivoCSV);

    double mediaBFS = calcularMedia(temposBFS, NUM_EXECUCOES);
    double mediaDFS = calcularMedia(temposDFS, NUM_EXECUCOES);
    double desvioBFS = calcularDesvioPadrao(temposBFS, NUM_EXECUCOES);
    double desvioDFS = calcularDesvioPadrao(temposDFS, NUM_EXECUCOES);
    double testeT = calcularTesteT(temposBFS, temposDFS, NUM_EXECUCOES);

    printf("Media Busca em Largura: %f segundos\n", mediaBFS);
    printf("Desvio Padrao Busca em Largura: %f segundos\n", desvioBFS);
    printf("Media Busca em Profundidade: %f segundos\n", mediaDFS);
    printf("Desvio Padrao Busca em Profundidade: %f segundos\n", desvioDFS);
    printf("Teste-T: %f\n", testeT);

    libera_Grafo(gr);
    free(vertices);

    return 0;
}
