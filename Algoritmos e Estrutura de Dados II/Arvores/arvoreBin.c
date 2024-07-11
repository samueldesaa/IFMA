#include <stdio.h>
#include <stdlib.h>
#include "ArvBin.h"

struct NoArvBin{
    int info;
    struct NoArvBin *esq;
    struct NoArvBin *dir;
};

ArvBin* cria_ArvBin() {
    ArvBin* raiz = (ArvBin*)malloc(sizeof(ArvBin));
    if (raiz != NULL) {
        *raiz = NULL;
    }
    return raiz;
}

void libera_NoArvBin(struct NoArvBin* no) {
    if (no == NULL) {
        return;
    }
    libera_NoArvBin(no->esq);
    libera_NoArvBin(no->dir);
    free(no);
    no = NULL;
}

void libera_ArvBin(ArvBin* raiz) {
    if (raiz == NULL) {
        return;
    }
    libera_NoArvBin(*raiz);
    free(raiz);
}

int estaVazia_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 1;
    }
    return 0;
}

int altura_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    int alt_esq = altura_ArvBin(&((*raiz)->esq));
    int alt_dir = altura_ArvBin(&((*raiz)->dir));
    if (alt_esq > alt_dir) {
        return alt_esq + 1;
    } else {
        return alt_dir + 1;
    }
}

int totalNO_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    int alt_esq = totalNO_ArvBin(&((*raiz)->esq));
    int alt_dir = totalNO_ArvBin(&((*raiz)->dir));
    return (alt_esq + alt_dir + 1);
}

int insere_ArvBin(ArvBin* raiz, int valor) {
    if (raiz == NULL) {
        return 0;
    }
    struct NoArvBin* novo;
    novo = (struct NoArvBin*)malloc(sizeof(struct NoArvBin));
    if (novo == NULL) {
        return 0;
    }
    novo->info = valor;
    novo->dir = NULL;
    novo->esq = NULL;

    if (*raiz == NULL) {
        *raiz = novo;
    } else {
        struct NoArvBin* atual = *raiz;
        struct NoArvBin* ant = NULL;
        while (atual != NULL) {
            ant = atual;
            if (valor == atual->info) {
                free(novo);
                return 0; // elemento já existe
            }
            if (valor > atual->info) {
                atual = atual->dir;
            } else {
                atual = atual->esq;
            }
        }
        if (valor > ant->info) {
            ant->dir = novo;
        } else {
            ant->esq = novo;
        }
    }
    return 1;
}

int remove_ArvBin(ArvBin* raiz, int valor) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    struct NoArvBin *ant = NULL; // ponteiro para o nó anterior
    struct NoArvBin *atual = *raiz; // ponteiro para o nó atual
    while (atual != NULL) {
        if (valor == atual->info) {
            break;
        }
        ant = atual;
        if (valor > atual->info) {
            atual = atual->dir;
        } else {
            atual = atual->esq;
        }
    }
    if (atual == NULL) {
        return 0; // não encontrou o elemento na árvore
    }
    if (atual->esq == NULL || atual->dir == NULL) {
        struct NoArvBin *noTemp = NULL; // nó temporário
        if (atual->esq != NULL) {
            noTemp = atual->esq;
        } else {
            noTemp = atual->dir;
        }
        if (ant == NULL) {
            free(atual);
            *raiz = noTemp;
        } else {
            if (atual == ant->esq) {
                ant->esq = noTemp;
            } else {
                ant->dir = noTemp;
            }
            free(atual);
        }
    } else {
        struct NoArvBin *sucessor = atual->dir;
        struct NoArvBin *antSucessor = atual;
        while (sucessor->esq != NULL) {
            antSucessor = sucessor;
            sucessor = sucessor->esq;
        }
        atual->info = sucessor->info;
        if (antSucessor == atual) {
            atual->dir = sucessor->dir;
        } else {
            antSucessor->esq = sucessor->dir;
        }
        free(sucessor);
    }
    return 1;
}


void preOrdem_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    printf("%d\n", (*raiz)->info);
    preOrdem_ArvBin(&((*raiz)->esq));
    preOrdem_ArvBin(&((*raiz)->dir));
}

void emOrdem_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    emOrdem_ArvBin(&((*raiz)->esq));
    printf("%d\n", (*raiz)->info);
    emOrdem_ArvBin(&((*raiz)->dir));
}

void posOrdem_ArvBin(ArvBin* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    posOrdem_ArvBin(&((*raiz)->esq));
    posOrdem_ArvBin(&((*raiz)->dir));
    printf("%d\n", (*raiz)->info);
}
