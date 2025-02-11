use vendasdb;
select * from product;
select * from product, supplier where
    supplier.id = supplierid and country like "Brazil";

select * from relatorio_de_vendas_diarias;
select * from alerta_de_estoque_baixo;

SET GLOBAL event_scheduler = ON;


/*QUESTAO 1*/
CREATE EVENT IF NOT EXISTS `produtos_descontinuados`
ON SCHEDULE EVERY 1 DAY
DO
-- Atualizar produtos descontinuados
    UPDATE product
    SET isdiscontinued = 1
    WHERE unitprice < 1.00
      AND id IN (
          SELECT DISTINCT productid
          FROM orderitem
          WHERE orderid IN (
              SELECT id
              FROM `order`
              WHERE orderdate >= (NOW() - INTERVAL 30 DAY)
          )
      );
      
/*QUESTAO 2*/
create event aumenta_Brasil
on schedule every 1 month
do
	update product
    set unitprice = unitprice*1.05
    where id in (
    select product.id from product, supplier where
    supplier.id = supplierid and country like "Brazil");
      
/*QUESTÃO 3*/
drop table if exists relatorio_de_vendas_diarias;
create table relatorio_de_vendas_diarias(
	id int primary key not null auto_increment,
    qtd_pedidos_total int,
    val_vendas_total float,
    dia date
);
drop event if exists relatorioVendas;
CREATE EVENT IF NOT EXISTS `relatorioVendas`
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-10 00:00:00'
DO
    INSERT INTO relatorio_de_vendas_diarias (qtd_pedidos_total, val_vendas_total, dia)
    SELECT
        COUNT(o.id) AS qtd_pedidos_total,
        SUM(o.totalamount) AS val_vendas_total,
        CURDATE() - INTERVAL 1 hour AS dia
    FROM `order` o
    WHERE o.orderdate >= CURDATE() - INTERVAL 1 DAY
      AND o.orderdate < CURDATE();
      
/*QUESTAO 4*/
	CREATE EVENT IF NOT EXISTS relatorioSemanal
	ON SCHEDULE EVERY 1 WEEK
	DO
    INSERT INTO produtos_top_semanais (produtoid, qtdvendida, semanaIni, semanaFim)
    SELECT
        oi.productid AS produtoid,
        SUM(oi.quantity) AS qtdvendida,
        (curdate() - 7 ) AS semanaIni,
        curdate() AS semanaFim
    FROM orderitem oi
    JOIN `order` o ON oi.orderid = o.id
    WHERE o.orderdate >= (curdate() - 7 )
      AND o.orderdate < curdate()
    GROUP BY oi.productid
    ORDER BY qtdvendida DESC;
    
    /*QUESTAO 5*/
    CREATE EVENT IF NOT EXISTS `remover_pedidos_antigos`
	ON SCHEDULE EVERY 1 MONTH
	DO
    DELETE oi
    FROM orderitem oi
    JOIN `order` o ON oi.orderid = o.id
    WHERE o.orderdate < CURDATE() - INTERVAL 5 YEAR;
    DELETE FROM `order`
    WHERE orderdate < CURDATE() - INTERVAL 5 YEAR;
    
    /*QUESTAO 6*/
    CREATE TABLE IF NOT EXISTS alerta_de_estoque_baixo (
    alertaid INT AUTO_INCREMENT,          -- Identificador único do alerta
    produtoid INT NOT NULL,               -- ID do produto
    produto_nome VARCHAR(100) NOT NULL,   -- Nome do produto
    estoque_atual INT NOT NULL,           -- Estoque atual do produto
    data_alerta DATE NOT NULL,            -- Data do alerta
    PRIMARY KEY (alertaid)                -- Chave primária
);
    
    CREATE EVENT IF NOT EXISTS alertaEstoqueBaixo
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO alerta_de_estoque_baixo (produtoid, produto_nome, estoque_atual, data_alerta)
    SELECT 
        p.id AS produtoid,
        p.productname AS produto_nome,
        p.estoque AS estoque_atual,
        CURDATE() AS data_alerta
    FROM product p
    WHERE p.estoque <= 5;

    /*QUESTAO 7*/
    create table vendas_por_pais(
		id int not null auto_increment,
        country varchar(30),
        month int,
        total_sales float
    );
    
    CREATE EVENT IF NOT EXISTS relatorioMensalPorPais
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-02-01 00:00:00'
DO
    INSERT INTO vendas_por_pais (country, month, total_sales)
    SELECT 
        c.country,
        DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AS month,
        SUM(o.totalamount) AS total_sales
    FROM `order` o
    JOIN customer c ON o.customerid = c.id
    WHERE 
        o.orderdate >= LAST_DAY(CURDATE() - INTERVAL 2 MONTH) + INTERVAL 1 DAY
        AND o.orderdate < LAST_DAY(CURDATE() - INTERVAL 1 MONTH) + INTERVAL 1 DAY
    GROUP BY c.country;
    
    
SELECT 
  `orderitem`.`id` AS `orderitem_id`,
  `orderitem`.`orderid`,
  `orderitem`.`productid`,
  `orderitem`.`unitprice` AS `orderitem_unitprice`,
  `orderitem`.`quantity`,
  `order`.`orderdate`,
  `order`.`ordernumber`,
  `order`.`totalamount`,
  `customer`.`firstname`,
  `customer`.`lastname`,
  `customer`.`city` AS `customer_city`,
  `customer`.`country` AS `customer_country`,
  `product`.`productname`,
  `product`.`package`,
  `supplier`.`companyname` AS `supplier_companyname`,
  `supplier`.`country` AS `supplier_country`
FROM `orderitem`
JOIN `order` ON `orderitem`.`orderid` = `order`.`id`
JOIN `customer` ON `order`.`customerid` = `customer`.`id`
JOIN `product` ON `orderitem`.`productid` = `product`.`id`
JOIN `supplier` ON `product`.`supplierid` = `supplier`.`id`;