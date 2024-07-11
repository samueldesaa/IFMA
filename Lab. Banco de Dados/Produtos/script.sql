drop database if exists prod;
create database prod;
use prod;

drop table if exists produtos;
create table produtos(
	Prod_Codigo int primary key,
    Prod_Descricao varchar(255),
    Prod_Valor decimal(11,2),
    Prod_Status char(1),
    Prod_Estoque_Minimo int,
    Prod_Qtd_Estoque int
);
drop table if exists produtos_em_falta;
create table produtos_em_falta(
	Prd_Codigo int primary key,
    Prd_data date,
    Prd_qtd_estoque int
);

drop table if exists produtos_requisicao;
create table produtos_requisicao(
	Prd_Codigo int primary key,
    Prd_estoque int,
    Prd_acomprar int
);

drop table if exists orcamentos;
create table orcamentos(
	Orc_Codigo int primary key,
    Orc_Data date,
    Orc_Status tinyint
);

drop table if exists orcamentos_produtos;
create table orcamentos_produtos(
	Ord_Codigo int primary key,
    Orc_Status char(1),
    Orc_Qtd int,
    Orc_Valor decimal(11,2),
    Prod_Codigo int,
    Orc_Codigo int,
    foreign key(Prod_Codigo) references produtos(Prod_Codigo),
	foreign key(Orc_Codigo) references orcamentos(Orc_Codigo)
);
drop procedure if exists baixa_Estoque;
DELIMITER $$

CREATE PROCEDURE baixa_Estoque(in codPro int, in qtd int)
BEGIN
if (select Prod_Qtd_Estoque from produtos where Prod_Codigo = codpro)<qtd then
	insert into produtos_em_falta values(codPro,date(now()),0);
    update produtos set Prod_Qtd_Estoque = 0 where Prod_Codigo = codPro;
else
	update produtos set Prod_Qtd_Estoque = Prod_Qtd_Estoque-qtd where Prod_Codigo = codPro;
end if;
END $$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS verifica_Estoque$$
CREATE PROCEDURE verifica_Estoque(IN codPro INT)
BEGIN
    DECLARE estoq_e, estoq_m INT;
    SELECT Prod_Qtd_Estoque, Prod_Estoque_Minimo INTO estoq_e, estoq_m FROM produtos WHERE Prod_Codigo = codPro;
    IF estoq_e < estoq_m THEN
        INSERT INTO produtos_requisicao VALUES (codPro, estoq_e, estoq_m - estoq_e);
    END IF;
END$$

DELIMITER ;


call Baixa_Estoque(198, 100);
call verifica_Estoque(879);
select * from produtos;
select * from produtos_em_falta;
select * from produtos_requisicao;

insert into produtos values(879,'Oleo',16,1, 100,30);