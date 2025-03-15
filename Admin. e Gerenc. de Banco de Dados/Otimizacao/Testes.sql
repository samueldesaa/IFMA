USE sistema_vendas_avancado;

CREATE INDEX idx_produtos_categoria ON produtos (categoria_id);
CREATE INDEX idx_pagamentos_status ON pagamentos (status);
CREATE INDEX idx_estoque_movimentacao_produto ON estoque_movimentacao (produto_id);
CREATE INDEX idx_estoque_movimentacao_data ON estoque_movimentacao (produto_id, data_movimentacao DESC);
CREATE INDEX idx_produtos_id ON produtos (id);
CREATE INDEX idx_itens_pedido_produto ON itens_pedido (produto_id);
CREATE INDEX idx_itens_pedido_analise ON itens_pedido (produto_id, quantidade, preco_unitario);

SELECT * FROM produtos WHERE categoria_id = 1;

SELECT * FROM pagamentos WHERE status = 'Pendente';

SELECT * FROM estoque_movimentacao WHERE produto_id = 1;

SELECT em.produto_id, p.nome, em.tipo, em.quantidade, em.data_movimentacao
FROM estoque_movimentacao em
JOIN produtos p ON em.produto_id = p.id
WHERE em.produto_id = 1
ORDER BY em.data_movimentacao DESC;

SELECT pr.id, pr.nome, COUNT(ip.id) AS total_vendas,
       SUM(ip.quantidade) AS unidades_vendidas,
       SUM(ip.quantidade * ip.preco_unitario) AS receita_total
FROM itens_pedido ip
JOIN produtos pr ON ip.produto_id = pr.id
GROUP BY pr.id, pr.nome
ORDER BY receita_total DESC;


CREATE INDEX idx_produtos_categoria ON produtos (categoria_id);
CREATE INDEX idx_pagamentos_status ON pagamentos (status);
CREATE INDEX idx_estoque_movimentacao_produto ON estoque_movimentacao (produto_id);
CREATE INDEX idx_estoque_movimentacao_data ON estoque_movimentacao (produto_id, data_movimentacao DESC);
CREATE INDEX idx_produtos_id ON produtos (id);
CREATE INDEX idx_itens_pedido_produto ON itens_pedido (produto_id);
CREATE INDEX idx_itens_pedido_analise ON itens_pedido (produto_id, quantidade, preco_unitario);

EXPLAIN SELECT * FROM produtos WHERE categoria_id = 1;

EXPLAIN SELECT * FROM pagamentos WHERE status = 'Pendente';

EXPLAIN SELECT * FROM estoque_movimentacao WHERE produto_id = 1;

EXPLAIN SELECT em.produto_id, p.nome, em.tipo, em.quantidade, em.data_movimentacao
FROM estoque_movimentacao em
JOIN produtos p ON em.produto_id = p.id
WHERE em.produto_id = 1
ORDER BY em.data_movimentacao DESC;

EXPLAIN SELECT pr.id, pr.nome, COUNT(ip.id) AS total_vendas,
       SUM(ip.quantidade) AS unidades_vendidas,
       SUM(ip.quantidade * ip.preco_unitario) AS receita_total
FROM itens_pedido ip
JOIN produtos pr ON ip.produto_id = pr.id
GROUP BY pr.id, pr.nome
ORDER BY receita_total DESC;
