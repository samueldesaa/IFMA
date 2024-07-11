/* SAMUEL CHAVES E GUSTAVO DOS SANTOS */

drop database if exists estoque;
CREATE SCHEMA IF NOT EXISTS estoque;
USE estoque;

drop table if exists Produtos;
CREATE TABLE Produtos (
    prd_codigo INT NOT NULL AUTO_INCREMENT,
    prd_nome VARCHAR (255) NULL,
    prd_qtd_estoque INT NULL,
    prd_valor DECIMAL(10, 2) NULL,
    prd_estoque_minimo INT NULL,
    prd_status INT NULL,
PRIMARY KEY (prd_codigo));

drop table if exists orcamentos;
	CREATE TABLE orcamentos (
    orc_id INT NOT NULL AUTO_INCREMENT,
    orc_data date NULL,
    orc_status TINYINT NULL,
primary key(orc_id));

drop table if exists orcamento_produtos;
CREATE TABLE orcamento_produtos (
    orc_id INT NOT NULL auto_increment,
    prd_codigo INT NOT NULL,
    orc_qtd INT,
    orc_valor DECIMAL,
    primary key(orc_id, prd_codigo),
    FOREIGN KEY (orc_id)
    REFERENCES orcamentos (orc_id),
    FOREIGN KEY (prd_codigo)
    REFERENCES produtos(prd_codigo)
);

drop table if exists orcamento_produtos_cancelados;
create table orcamento_produtos_cancelados (
orc_id int primary key auto_increment, 
prd_codigo int, 
orc_qtd int, 
orc_valor int
);

drop table if exists produtos_em_falta;
create table produtos_em_falta(
	falta_id int primary key auto_increment,
	prd_codigo int,
    prd_data date,
    qtd_estoque int
);

drop table if exists produtos_requisicao;
create table produtos_requisicao(
	req_id int primary key auto_increment,
	prd_codigo int,
    prd_estoque int,
    prd_acomprar int
);

drop table if exists Produtos_atualizados;
create table Produtos_atualizados(
	atual_id int primary key auto_increment,
	prd_codigo int,
    prd_qtd_anterior int,
    prd_qtd_atualizada int,
    prd_valor decimal(11,2)
);

drop table if exists Historico_Produtos_Excluidos;
create table Historico_Produtos_Excluidos(
hist_id int primary key,
prd_codigo int,
prd_qtd_estoque int, 
prd_preco_venda int
);

drop procedure if exists baixa_estoque;    
    DELIMITER //

CREATE PROCEDURE baixa_estoque(IN p_codigo INT, IN p_qtd_vendida INT)
BEGIN
    DECLARE estoque_atual INT;

    SELECT prd_qtd_estoque INTO estoque_atual FROM Produtos WHERE prd_codigo = p_codigo;

    IF estoque_atual > p_qtd_vendida THEN
        UPDATE Produtos SET prd_qtd_estoque = prd_qtd_estoque - p_qtd_vendida WHERE prd_codigo = p_codigo;
    ELSE
        INSERT INTO produtos_em_falta (prd_data, prd_codigo, qtd_estoque) VALUES (CURDATE(), p_codigo, estoque_atual);
    END IF;
END //

DELIMITER ;

drop procedure if exists compara_estoque_minimo;
DELIMITER $$

CREATE PROCEDURE compara_estoque_minimo(in prdCod int)
begin
	declare qtd int;
    declare mini int;
	select prd_qtd_estoque into qtd from Produtos where prd_codigo = prdCod;
    select prd_estoque_minimo into mini from Produtos where prd_codigo = prdCod;
    if mini > qtd then
		insert into produtos_requisicao (prd_codigo, prd_estoque, prd_acomprar) value(prdCod, qtd, mini-qtd);
	end if;
end $$

drop procedure if exists reajusta_preco;
delimiter //

CREATE PROCEDURE reajusta_preco(IN p_codigo INT, IN p_taxa DECIMAL(5,2))
BEGIN
	if p_taxa < 50 and p_taxa > -50 then
		UPDATE Produtos SET prd_valor = prd_valor * (1 + p_taxa / 100) WHERE prd_codigo = p_codigo;
	end if;
END //

DELIMITER ;

drop trigger if exists produtos_atualizados_trigger;
DELIMITER //

CREATE TRIGGER produtos_atualizados_trigger AFTER UPDATE ON Produtos
FOR EACH ROW
BEGIN
    IF NEW.prd_qtd_estoque = 0 THEN
        INSERT INTO produtos_em_falta (prd_data, prd_codigo, qtd_estoque)
        VALUES (CURDATE(), NEW.prd_codigo, NEW.prd_qtd_estoque);

        UPDATE Produtos SET prd_status = NULL WHERE prd_codigo = NEW.prd_codigo;

        UPDATE orcamento_produtos SET orc_status = NULL WHERE prd_codigo = NEW.prd_codigo;
    ELSE
        INSERT INTO Produtos_atualizados (prd_codigo, prd_qtd_anterior, prd_qtd_atualizada, prd_valor)
        VALUES (NEW.prd_codigo, OLD.prd_qtd_estoque, NEW.prd_qtd_estoque, NEW.prd_valor);
    END IF;
END //

DELIMITER ;

drop trigger if exists historico_produtos_excluidos_trigger;
DELIMITER //

CREATE TRIGGER historico_produtos_excluidos_trigger AFTER DELETE ON Produtos
FOR EACH ROW
BEGIN
    IF OLD.prd_qtd_estoque != 0 THEN
        SIGNAL SQLSTATE '45001' SET message_text = 'Não é possível excluir um produto sem estoque zero.';
    ELSE
        INSERT INTO Historico_Produtos_Excluidos (prd_codigo, prd_qtd_estoque, prd_preco_venda)
        VALUES (OLD.prd_codigo, OLD.prd_qtd_estoque, OLD.prd_valor);
    END IF;
END //

DELIMITER ;

drop trigger if exists cancelamento_orcamento_trigger;
DELIMITER //

CREATE TRIGGER cancelamento_orcamento_trigger AFTER UPDATE ON orcamentos
FOR EACH ROW
BEGIN
    IF NEW.orc_status = 0 THEN
        INSERT INTO orcamento_produtos_cancelados (orc_id, prd_codigo, orc_qtd, orc_valor)(SELECT NEW.orc_id, prd_codigo, orc_qtd, orc_valor FROM orcamento_produtos WHERE orc_id = NEW.orc_id);

        DELETE FROM orcamento_produtos WHERE orc_id = NEW.orc_id;
    END IF;
END //

DELIMITER ;
