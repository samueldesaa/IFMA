#ifndef RB_TREE_H
#define RB_TREE_H

#include <stdio.h>
#include <stdlib.h>

typedef void* RBTreeKey;
typedef void* RBTreeValue;

typedef struct _RBTreeNode RBTreeNode;
typedef struct _RBTree RBTree;

typedef int (*RBTreeCompareFunc)(RBTreeKey a, RBTreeKey b);

#define RB_TREE_NULL ((void *)0)
#define RB_TREE_RED 0
#define RB_TREE_BLACK 1

#define RB_TREE_NODE_LEFT 0
#define RB_TREE_NODE_RIGHT 1

struct _RBTreeNode {
    struct _RBTreeNode *children[2];
    struct _RBTreeNode *parent;
    RBTreeKey key;
    RBTreeValue value;
    int color;
};

struct _RBTree {
    struct _RBTreeNode *root_node;
    RBTreeCompareFunc compare_func;
    unsigned int num_nodes;
};

RBTree *rb_tree_new(RBTreeCompareFunc compare_func);
void rb_tree_free(RBTree *tree);
RBTreeNode *rb_tree_insert(RBTree *tree, RBTreeKey key, RBTreeValue value);
void rb_tree_remove_node(RBTree *tree, RBTreeNode *node);
int rb_tree_remove(RBTree *tree, RBTreeKey key);
RBTreeNode *rb_tree_lookup_node(RBTree *tree, RBTreeKey key);
RBTreeValue rb_tree_lookup(RBTree *tree, RBTreeKey key);
void rb_tree_print(RBTree *tree);
RBTreeNode *rb_tree_root_node(RBTree *tree);
RBTreeKey rb_tree_node_key(RBTreeNode *node);
RBTreeValue rb_tree_node_value(RBTreeNode *node);
RBTreeNode *rb_tree_node_child(RBTreeNode *node, int index);
RBTreeNode *rb_tree_node_parent(RBTreeNode *node);
int rb_tree_node_color(RBTreeNode *node);
unsigned int rb_tree_num_entries(RBTree *tree);
int rb_tree_node_height(RBTreeNode *node);

#endif /* RB_TREE_H */
