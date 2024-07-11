#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "btree.h"

int chaves;
int MIN;
struct BTreeNode *root = NULL;

// Cria um novo nó
struct BTreeNode *createNode(int item, struct BTreeNode *child) {
    struct BTreeNode *newNode;
    newNode = (struct BTreeNode *)malloc(sizeof(struct BTreeNode));
    newNode->item = (int *)malloc((chaves + 1) * sizeof(int));
    newNode->link = (struct BTreeNode **)malloc((chaves + 1) * sizeof(struct BTreeNode *));
    newNode->item[1] = item;
    newNode->count = 1;
    newNode->link[0] = root;
    newNode->link[1] = child;
    return newNode;
}

// Insere o valor no nó
void insertNode(int item, int pos, struct BTreeNode *node, struct BTreeNode *child) {
    int j = node->count;
    while (j > pos) {
        node->item[j + 1] = node->item[j];
        node->link[j + 1] = node->link[j];
        j--;
    }
    node->item[j + 1] = item;
    node->link[j + 1] = child;
    node->count++;
}

// Divide o nó
void splitNode(int item, int *pval, int pos, struct BTreeNode *node, struct BTreeNode *child, struct BTreeNode **newNode) {
    int median, j;

    if (pos > MIN)
        median = MIN + 1;
    else
        median = MIN;

    *newNode = (struct BTreeNode *)malloc(sizeof(struct BTreeNode));
    (*newNode)->item = (int *)malloc((chaves + 1) * sizeof(int));
    (*newNode)->link = (struct BTreeNode **)malloc((chaves + 1) * sizeof(struct BTreeNode *));
    j = median + 1;
    while (j <= chaves) {
        (*newNode)->item[j - median] = node->item[j];
        (*newNode)->link[j - median] = node->link[j];
        j++;
    }
    node->count = median;
    (*newNode)->count = chaves - median;

    if (pos <= MIN)
        insertNode(item, pos, node, child);
    else
        insertNode(item, pos - median, *newNode, child);

    *pval = node->item[node->count];
    (*newNode)->link[0] = node->link[node->count];
    node->count--;
}

// Define valor no nó
int setValue(int item, int *pval, struct BTreeNode *node, struct BTreeNode **child) {
    int pos;
    if (!node) {
        *pval = item;
        *child = NULL;
        return 1;
    }

    if (item < node->item[1]) {
        pos = 0;
    } else {
        for (pos = node->count; (item < node->item[pos] && pos > 1); pos--);
        if (item == node->item[pos]) {
            return 0; // Duplicates not allowed
        }
    }
    if (setValue(item, pval, node->link[pos], child)) {
        if (node->count < chaves) {
            insertNode(*pval, pos, node, *child);
        } else {
            splitNode(*pval, pval, pos, node, *child, child);
            return 1;
        }
    }
    return 0;
}

// Insere o valor
void insert(int item) {
    int flag, i;
    struct BTreeNode *child;

    flag = setValue(item, &i, root, &child);
    if (flag)
        root = createNode(i, child);
}

// Procura pelo valor
void search(int item, int *pos, struct BTreeNode *node) {
    if (!node) {
        return;
    }

    if (item < node->item[1]) {
        *pos = 0;
    } else {
        for (*pos = node->count; (item < node->item[*pos] && *pos > 1); (*pos)--);
        if (item == node->item[*pos]) {
            return;
        }
    }
    search(item, pos, node->link[*pos]);
    return;
}

// Travessia de forma central
void traversal(struct BTreeNode *node) {
    int i;
    if (node) {
        for (i = 0; i < node->count; i++) {
            traversal(node->link[i]);
            printf("%d ", node->item[i + 1]);
        }
        traversal(node->link[i]);
    }
}

// Insere n números aleatórios
void insertRandomNumbers(int n) {
    srand(time(0));
    for (int i = 0; i < n; i++) {
        int num = rand(); // Gera um número aleatório
        insert(num);
    }
}

// Medir o tempo de inserção de n números aleatórios
void measureInsertionTime(int n) {
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    insertRandomNumbers(n);
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Tempo de inserção de %d elementos: %f segundos\n", n, cpu_time_used);
}

// Medir o tempo de busca de n números aleatórios
void measureSearchTime(int n) {
    int pos;
    clock_t start, end;
    double cpu_time_used;

    srand(time(0));
    start = clock();
    for (int i = 0; i < n; i++) {
        int num = rand(); // Gera um número aleatório
        search(num, &pos, root);
    }
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Tempo de busca de %d elementos: %f segundos\n", n, cpu_time_used);
}

// Calcula a altura da árvore
int height(struct BTreeNode *node) {
    if (!node) {
        return 0;
    }
    int h = 0;
    for (int i = 0; i <= node->count; i++) {
        int temp_height = height(node->link[i]);
        if (temp_height > h) {
            h = temp_height;
        }
    }
    return h + 1;
}
