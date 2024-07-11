#include <stdlib.h>
#include "rb-tree.h"

#define RB_TREE_RED 0
#define RB_TREE_BLACK 1

// Definição da estrutura do nó da árvore rubro-negra
struct RBTreeNode {
    struct RBTreeNode *children[2];
    struct RBTreeNode *parent;
    RBTreeKey key;
    RBTreeValue value;
    int color;
};

// Definição da estrutura da árvore rubro-negra
struct RBTree {
    struct RBTreeNode *root_node;
    RBTreeCompareFunc compare_func;
    unsigned int num_nodes;
};

RBTree *rb_tree_new(RBTreeCompareFunc compare_func) {
    RBTree *new_tree = (RBTree *)malloc(sizeof(RBTree));
    if (new_tree == NULL) {
        return NULL;
    }

    new_tree->root_node = NULL;
    new_tree->compare_func = compare_func;
    new_tree->num_nodes = 0;

    return new_tree;
}

// Função auxiliar para criar um novo nó da árvore
static struct RBTreeNode *rb_tree_new_node(RBTreeKey key, RBTreeValue value) {
    struct RBTreeNode *new_node = (struct RBTreeNode *)malloc(sizeof(struct RBTreeNode));
    if (new_node == NULL) {
        return NULL;
    }

    new_node->key = key;
    new_node->value = value;
    new_node->color = RB_TREE_RED; // Por padrão, um novo nó é vermelho
    new_node->parent = NULL;
    new_node->children[0] = NULL;
    new_node->children[1] = NULL;

    return new_node;
}

// Função auxiliar para liberar os nós da árvore recursivamente
void rb_tree_free_nodes(struct RBTreeNode *node) {
    if (node != NULL) {
        rb_tree_free_nodes(node->children[0]);
        rb_tree_free_nodes(node->children[1]);
        free(node);
    }
}

void rb_tree_free(RBTree *tree) {
    rb_tree_free_nodes(tree->root_node);
    free(tree);
}

// Restante do código permanece igual


// Função auxiliar para realizar a rotação à esquerda
static void rb_tree_rotate_left(RBTree *tree, RBTreeNode *node) {
    RBTreeNode *child = node->children[1];
    node->children[1] = child->children[0];
    if (child->children[0] != NULL) {
        child->children[0]->parent = node;
    }
    child->parent = node->parent;
    if (node->parent == NULL) {
        tree->root_node = child;
    } else if (node == node->parent->children[0]) {
        node->parent->children[0] = child;
    } else {
        node->parent->children[1] = child;
    }
    child->children[0] = node;
    node->parent = child;
}

// Função auxiliar para realizar a rotação à direita
static void rb_tree_rotate_right(RBTree *tree, RBTreeNode *node) {
    RBTreeNode *child = node->children[0];
    node->children[0] = child->children[1];
    if (child->children[1] != NULL) {
        child->children[1]->parent = node;
    }
    child->parent = node->parent;
    if (node->parent == NULL) {
        tree->root_node = child;
    } else if (node == node->parent->children[1]) {
        node->parent->children[1] = child;
    } else {
        node->parent->children[0] = child;
    }
    child->children[1] = node;
    node->parent = child;
}

// Função auxiliar para balancear a árvore após a inserção de um nó
static void rb_tree_balance_insertion(RBTree *tree, RBTreeNode *node) {
    while (node->parent != NULL && node->parent->color == RB_TREE_RED) {
        if (node->parent == node->parent->parent->children[0]) {
            RBTreeNode *uncle = node->parent->parent->children[1];
            if (uncle != NULL && uncle->color == RB_TREE_RED) {
                node->parent->color = RB_TREE_BLACK;
                uncle->color = RB_TREE_BLACK;
                node->parent->parent->color = RB_TREE_RED;
                node = node->parent->parent;
            } else {
                if (node == node->parent->children[1]) {
                    node = node->parent;
                    rb_tree_rotate_left(tree, node);
                }
                node->parent->color = RB_TREE_BLACK;
                node->parent->parent->color = RB_TREE_RED;
                rb_tree_rotate_right(tree, node->parent->parent);
            }
        } else {
            RBTreeNode *uncle = node->parent->parent->children[0];
            if (uncle != NULL && uncle->color == RB_TREE_RED) {
                node->parent->color = RB_TREE_BLACK;
                uncle->color = RB_TREE_BLACK;
                node->parent->parent->color = RB_TREE_RED;
                node = node->parent->parent;
            } else {
                if (node == node->parent->children[0]) {
                    node = node->parent;
                    rb_tree_rotate_right(tree, node);
                }
                node->parent->color = RB_TREE_BLACK;
                node->parent->parent->color = RB_TREE_RED;
                rb_tree_rotate_left(tree, node->parent->parent);
            }
        }
    }
    tree->root_node->color = RB_TREE_BLACK;
}

RBTreeNode *rb_tree_insert(RBTree *tree, RBTreeKey key, RBTreeValue value) {
    RBTreeNode *new_node = rb_tree_new_node(key, value);
    if (new_node == NULL) {
        return NULL;
    }

    RBTreeNode *parent = NULL;
    RBTreeNode *current = tree->root_node;
    while (current != NULL) {
        parent = current;
        if (tree->compare_func(key, current->key) < 0) {
            current = current->children[0];
        } else {
            current = current->children[1];
        }
    }

    new_node->parent = parent;
    if (parent == NULL) {
        tree->root_node = new_node;
    } else if (tree->compare_func(key, parent->key) < 0) {
        parent->children[0] = new_node;
    } else {
        parent->children[1] = new_node;
    }

    new_node->color = RB_TREE_RED;
    rb_tree_balance_insertion(tree, new_node);
    tree->num_nodes++;

    return new_node;
}

void rb_tree_transplant(RBTree *tree, RBTreeNode *u, RBTreeNode *v) {
    if (u->parent == NULL) {
        tree->root_node = v;
    } else if (u == u->parent->children[0]) {
        u->parent->children[0] = v;
    } else {
        u->parent->children[1] = v;
    }
    if (v != NULL) {
        v->parent = u->parent;
    }
}

RBTreeNode *rb_tree_minimum(RBTreeNode *node) {
    while (node->children[0] != NULL) {
        node = node->children[0];
    }
    return node;
}

void rb_tree_remove_node(RBTree *tree, RBTreeNode *node) {
    RBTreeNode *y = node;
    RBTreeNode *x;
    int y_original_color = y->color;
    if (node->children[0] == NULL) {
        x = node->children[1];
        rb_tree_transplant(tree, node, node->children[1]);
    } else if (node->children[1] == NULL) {
        x = node->children[0];
        rb_tree_transplant(tree, node, node->children[0]);
    } else {
        y = rb_tree_minimum(node->children[1]);
        y_original_color = y->color;
        x = y->children[1];
        if (y->parent == node) {
            if (x != NULL) {
                x->parent = y;
            }
        } else {
            rb_tree_transplant(tree, y, y->children[1]);
            y->children[1] = node->children[1];
            y->children[1]->parent = y;
        }
        rb_tree_transplant(tree, node, y);
        y->children[0] = node->children[0];
        y->children[0]->parent = y;
        y->color = node->color;
    }
    if (y_original_color == RB_TREE_BLACK) {
        while (x != tree->root_node && (x == NULL || x->color == RB_TREE_BLACK)) {
            if (x == x->parent->children[0]) {
                RBTreeNode *w = x->parent->children[1];
                if (w->color == RB_TREE_RED) {
                    w->color = RB_TREE_BLACK;
                    x->parent->color = RB_TREE_RED;
                    rb_tree_rotate_left(tree, x->parent);
                    w = x->parent->children[1];
                }
                if ((w->children[0] == NULL || w->children[0]->color == RB_TREE_BLACK) &&
                    (w->children[1] == NULL || w->children[1]->color == RB_TREE_BLACK)) {
                    w->color = RB_TREE_RED;
                    x = x->parent;
                } else {
                    if (w->children[1] == NULL || w->children[1]->color == RB_TREE_BLACK) {
                        w->children[0]->color = RB_TREE_BLACK;
                        w->color = RB_TREE_RED;
                        rb_tree_rotate_right(tree, w);
                        w = x->parent->children[1];
                    }
                    w->color = x->parent->color;
                    x->parent->color = RB_TREE_BLACK;
                    if (w->children[1] != NULL) {
                        w->children[1]->color = RB_TREE_BLACK;
                    }
                    rb_tree_rotate_left(tree, x->parent);
                    x = tree->root_node;
                }
            } else {
                RBTreeNode *w = x->parent->children[0];
                if (w->color == RB_TREE_RED) {
                    w->color = RB_TREE_BLACK;
                    x->parent->color = RB_TREE_RED;
                    rb_tree_rotate_right(tree, x->parent);
                    w = x->parent->children[0];
                }
                if ((w->children[0] == NULL || w->children[0]->color == RB_TREE_BLACK) &&
                    (w->children[1] == NULL || w->children[1]->color == RB_TREE_BLACK)) {
                    w->color = RB_TREE_RED;
                    x = x->parent;
                } else {
                    if (w->children[0] == NULL || w->children[0]->color == RB_TREE_BLACK) {
                        w->children[1]->color = RB_TREE_BLACK;
                        w->color = RB_TREE_RED;
                        rb_tree_rotate_left(tree, w);
                        w = x->parent->children[0];
                    }
                    w->color = x->parent->color;
                    x->parent->color = RB_TREE_BLACK;
                    if (w->children[0] != NULL) {
                        w->children[0]->color = RB_TREE_BLACK;
                    }
                    rb_tree_rotate_right(tree, x->parent);
                    x = tree->root_node;
                }
            }
        }
        if (x != NULL) {
            x->color = RB_TREE_BLACK;
        }
    }
    free(node);
    tree->num_nodes--;
}

int rb_tree_remove(RBTree *tree, RBTreeKey key) {
    RBTreeNode *node = rb_tree_lookup_node(tree, key);
    if (node != NULL) {
        rb_tree_remove_node(tree, node);
        return 1;
    } else {
        return 0;
    }
}

RBTreeNode *rb_tree_lookup_node(RBTree *tree, RBTreeKey key) {
    RBTreeNode *current = tree->root_node;
    while (current != NULL && tree->compare_func(key, current->key) != 0) {
        if (tree->compare_func(key, current->key) < 0) {
            current = current->children[0];
        } else {
            current = current->children[1];
        }
    }
    return current;
}

RBTreeValue rb_tree_lookup(RBTree *tree, RBTreeKey key) {
    RBTreeNode *node = rb_tree_lookup_node(tree, key);
    if (node != NULL) {
        return node->value;
    } else {
        return RB_TREE_NULL;
    }
}

void rb_tree_print_util(RBTreeNode *node, int level) {
    if (node == NULL) {
        return;
    }

    rb_tree_print_util(node->children[1], level + 1);

    for (int i = 0; i < level; i++) {
        printf("    ");
    }
    printf("%d(%s)\n", *((int *)node->key), node->color == RB_TREE_RED ? "RED" : "BLACK");

    rb_tree_print_util(node->children[0], level + 1);
}

void rb_tree_print(RBTree *tree) {
    rb_tree_print_util(tree->root_node, 0);
}

RBTreeNode *rb_tree_root_node(RBTree *tree) {
    return tree->root_node;
}

RBTreeKey rb_tree_node_key(RBTreeNode *node) {
    return node->key;
}

RBTreeValue rb_tree_node_value(RBTreeNode *node) {
    return node->value;
}

RBTreeNode *rb_tree_node_child(RBTreeNode *node, int index) {
    if (index == 0 || index == 1) {
        return node->children[index];
    } else {
        return NULL;
    }
}

RBTreeNode *rb_tree_node_parent(RBTreeNode *node) {
    return node->parent;
}

int rb_tree_node_color(RBTreeNode *node) {
    return node->color;
}

unsigned int rb_tree_num_entries(RBTree *tree) {
    return tree->num_nodes;
}
int rb_tree_node_height(RBTreeNode *node) {
    if (node == NULL)
        return 0;

    // Recursivamente calcular a altura das subárvores esquerda e direita
    int left_height = rb_tree_node_height(node->children[RB_TREE_NODE_LEFT]);
    int right_height = rb_tree_node_height(node->children[RB_TREE_NODE_RIGHT]);

    // A altura do nó é a altura da maior subárvore mais um para o próprio nó
    return (left_height > right_height ? left_height : right_height) + 1;
}
