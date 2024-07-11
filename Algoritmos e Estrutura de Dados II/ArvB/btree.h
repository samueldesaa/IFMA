#ifndef BTREE_H
#define BTREE_H

#include <stdbool.h>

extern int chaves;
extern int MIN;

struct BTreeNode {
    int *item;
    int count;
    struct BTreeNode **link;
};

extern struct BTreeNode *root;

struct BTreeNode *createNode(int item, struct BTreeNode *child);
void insertNode(int item, int pos, struct BTreeNode *node, struct BTreeNode *child);
void splitNode(int item, int *pval, int pos, struct BTreeNode *node, struct BTreeNode *child, struct BTreeNode **newNode);
int setValue(int item, int *pval, struct BTreeNode *node, struct BTreeNode **child);
void insert(int item);
void search(int item, int *pos, struct BTreeNode *node);
void traversal(struct BTreeNode *node);
void insertRandomNumbers(int n);
void measureInsertionTime(int n);
void measureSearchTime(int n);
int height(struct BTreeNode *node);

#endif
