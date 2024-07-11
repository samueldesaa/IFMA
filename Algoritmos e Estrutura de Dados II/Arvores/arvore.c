#include <stdio.h>
#include <stdlib.h>
#include "arvAVL.h"

struct NO{
    int info;
    int alt;
    struct NO *esq;
    struct NO *dir;
};

ArvAVL* cria_ArvAVL() {
    ArvAVL* raiz = (ArvAVL*) malloc(sizeof(ArvAVL));
    if (raiz != NULL) {
        *raiz = NULL;
    }
    return raiz;
}

void libera_NO(struct NO* no) {
    if (no == NULL) {
        return;
    }
    libera_NO(no->esq);
    libera_NO(no->dir);
    free(no);
    no = NULL;
}

void libera_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL) {
        return;
    }
    libera_NO(*raiz);
    free(raiz);
}

int estaVazia_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 1;
    }
    return 0;
}

int altura_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    return (*raiz)->alt;
}

int totalNO_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    int alt_esq = totalNO_ArvAVL(&((*raiz)->esq));
    int alt_dir = totalNO_ArvAVL(&((*raiz)->dir));
    return (alt_esq + alt_dir + 1);
}

int consulta_ArvAVL(ArvAVL* raiz, int valor) {
    if (raiz == NULL || *raiz == NULL) {
        return 0;
    }
    struct NO* atual = *raiz;
    while (atual != NULL) {
        if (valor == atual->info) {
            return 1;
        }
        if (valor > atual->info) {
            atual = atual->dir;
        } else {
            atual = atual->esq;
        }
    }
    return 0;
}

void preOrdem_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    if (*raiz != NULL) {
        printf("%d\n", (*raiz)->info);
        preOrdem_ArvAVL(&((*raiz)->esq));
        preOrdem_ArvAVL(&((*raiz)->dir));
    }
}

void emOrdem_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    if (*raiz != NULL) {
        emOrdem_ArvAVL(&((*raiz)->esq));
        printf("%d\n", (*raiz)->info);
        emOrdem_ArvAVL(&((*raiz)->dir));
    }
}

void posOrdem_ArvAVL(ArvAVL* raiz) {
    if (raiz == NULL || *raiz == NULL) {
        return;
    }
    if (*raiz != NULL) {
        posOrdem_ArvAVL(&((*raiz)->esq));
        posOrdem_ArvAVL(&((*raiz)->dir));
        printf("%d\n", (*raiz)->info);
    }
}

int alt_NO(struct NO* no){
    if(no == NULL)
        return -1;
    else
        return no->alt;
}

int fatorBalanceamento_NO(struct NO* no){
    return labs(alt_NO(no->esq) - alt_NO(no->dir));
}

int maior(int x, int y){
    if( x > y)
        return x;
    else
        return y;
}

struct NO* procuraMenor(struct NO* atual){
    struct NO* no1 = atual, *no2 = atual->esq;
    while(no2 != NULL){
        no1 = no2;
        no2 = no2->esq;
    }
    return no1;
};

void RotacaoLL(ArvAVL *A){
    struct NO *B;
    B = (*A)->esq;
    (*A)->esq = B->dir;
    B->dir = *A;
    (*A)->alt = maior(alt_NO((*A)->esq), alt_NO((*A)->dir)) + 1;
    B->alt = maior(alt_NO(B->esq), (*A)->alt) + 1;
    *A = B;
}

void RotacaoRR(ArvAVL *A){
    struct NO *B;
    B = (*A)->dir;
    (*A)->dir = B->esq;
    B->esq = *A;
    (*A)->alt = maior(alt_NO((*A)->esq), alt_NO((*A)->dir)) + 1;
    B->alt = maior(alt_NO(B->dir), (*A)->alt) + 1;
    *A = B;
}

void RotacaoLR(ArvAVL *A){
    RotacaoRR(&(*A)->esq);
    RotacaoLL(A);
}

void RotacaoRL(ArvAVL *raiz){
    RotacaoLL(&(*raiz)->dir);
    RotacaoRR(raiz);
}

int insere_ArvAVL(ArvAVL *raiz, int valor) {
    int res;
    if(*raiz == NULL) {
        struct NO *novo;
        novo = (struct NO*)malloc(sizeof(struct NO));
        if(novo == NULL)
            return 0;

        novo->info = valor;
        novo->alt = 0;
        novo->esq = NULL;
        novo->dir = NULL;
        *raiz = novo;
        return 1;
    } else {
        struct NO *atual = *raiz;
        if(valor < atual->info){
            if((res = insere_ArvAVL(&atual->esq, valor)) == 1){
                if(fatorBalanceamento_NO(atual) >= 2){
                    if(valor < (*raiz)->esq->info ){
                        RotacaoLL(raiz);
                    }else{
                        RotacaoLR(raiz);
                    }
                }
            }
        } else if(valor > atual->info){
            if((res = insere_ArvAVL(&atual->dir, valor)) == 1){
                if(fatorBalanceamento_NO(atual) >= 2){
                    if((*raiz)->dir->info < valor){
                        RotacaoRR(raiz);
                    }else{
                        RotacaoRL(raiz);
                    }
                }
            }
        } else {
            return 0;
        }
        atual->alt = maior(alt_NO(atual->esq), alt_NO(atual->dir)) + 1;
        return res;
    }
}

int remove_ArvAVL(ArvAVL *raiz, int valor){
    if(*raiz == NULL)
        return 0;
    int res;
    if(valor < (*raiz)->info){
        if((res = remove_ArvAVL(&(*raiz)->esq,valor)) == 1){
            if(fatorBalanceamento_NO(*raiz) >= 2){
                if(alt_NO((*raiz)->dir->esq) <= alt_NO((*raiz)->dir->dir))
                    RotacaoRR(raiz);
                else
                    RotacaoRL(raiz);
            }
        }
    }
    if((*raiz)->info < valor){
        if((res = remove_ArvAVL(&(*raiz)->dir,valor)) == 1){
            if(fatorBalanceamento_NO(*raiz) >= 2){
                if(alt_NO((*raiz)->esq->dir) <= alt_NO((*raiz)->esq->esq))
                    RotacaoLL(raiz);
                else
                    RotacaoLR(raiz);
            }
        }
    }
    if((*raiz)->info == valor){
        if(((*raiz)->esq == NULL) && ((*raiz)->dir == NULL)){
            struct NO *oldNode = *raiz;
            if((*raiz)->esq != NULL)
                *raiz = (*raiz)->esq;
            else
                *raiz = (*raiz)->dir;
            free(oldNode);
        } else {
            struct NO *temp = procuraMenor((*raiz)->dir);
            (*raiz)->info = temp->info;
            remove_ArvAVL(&(*raiz)->dir, temp->info);
            if(fatorBalanceamento_NO(*raiz) >= 2){
                if(alt_NO((*raiz)->esq) <= alt_NO((*raiz)->dir))
                    RotacaoLL(raiz);
                else
                    RotacaoLR(raiz);
            }
        }
    }
    if(*raiz != NULL){
        (*raiz)->alt = maior(alt_NO((*raiz)->esq), alt_NO((*raiz)->dir)) + 1;
    }
    return res;
}
