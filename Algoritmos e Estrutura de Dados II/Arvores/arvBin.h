#ifndef ARVBIN_H_INCLUDED
#define ARVBIN_H_INCLUDED

typedef struct NoArvBin* ArvBin;

ArvBin* cria_ArvBin();
void libera_NoArvBin(struct NoArvBin* no);
void libera_ArvBin(ArvBin* raiz);
int estaVazia_ArvBin(ArvBin* raiz);
int altura_ArvBin(ArvBin* raiz);
int totalNO_ArvBin(ArvBin* raiz);
int insere_ArvBin(ArvBin* raiz, int valor);
int remove_ArvBin(ArvBin* raiz, int valor);
void preOrdem_ArvBin(ArvBin* raiz);
void emOrdem_ArvBin(ArvBin* raiz);
void posOrdem_ArvBin(ArvBin* raiz);

#endif
