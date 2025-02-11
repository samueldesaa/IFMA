drop database if exists ERP_Corporativo;
create database ERP_Corporativo;

use ERP_Corporativo;

create table cliente(
	id int primary key auto_increment,
    nome varchar(200),
    telefone varchar(100),
    data_cadastro datetime
);

create table conta(
	id int primary key auto_increment,
    saldo bigint,
    data_abertura datetime,
    id_cliente int,
    foreign key(id_cliente) references cliente(id)
);

create table transacoes(
	id int primary key auto_increment,
    valor decimal(15,2),
    data_transacao datetime,
    tipo_operação varchar(200),
    id_conta int,
    foreign key(id_conta) references conta(id)
);

create table log_auditoria(
	id int primary key auto_increment,
    tabela_afetada varchar(50),
    operacao varchar(10),
    usuario varchar(100),
    data_hora datetime,
    detalhes text
);
/*TAREFA 1 - TRIGGERS*/
/*TRIGGERS CLIENTE*/
create trigger log_cliente_insert
after insert on cliente
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("cliente", "insert", user(), current_timestamp(), "Insert na tabela cliente");

create trigger log_cliente_update
after update on cliente
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("cliente", "update", user(), current_timestamp(), "Update na tabela cliente");
DELIMITER //
create trigger log_cliente_delete
before delete on cliente
for each row
if user() like '%localhost%' then
    insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
    values ("cliente", "delete", user(), current_timestamp(), "Tentativa de delete de um cliente bloqueada - usuário no localhost");
end if//
DELIMITER ;
create trigger log_conta_insert
after insert on conta
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("conta", "insert", user(), current_timestamp(), "Insert na tabela conta");

create trigger log_conta_update
after update on conta
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("conta", "update", user(), current_timestamp(), "Update na tabela conta");
DELIMITER //
create trigger log_conta_delete
before delete on conta
for each row
if user() like '%localhost%' then
    insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
    values ("conta", "delete", user(), current_timestamp(), "Tentativa de delete de uma conta bloqueada - usuário no localhost");
end if//
DELIMITER ;
create trigger log_transacoes_insert
after insert on transacoes
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("transacoes", "insert", user(), current_timestamp(), "Insert na tabela transacoes");

create trigger log_transacoes_update
after update on transacoes
for each row
insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes) 
values ("transacoes", "update", user(), current_timestamp(), "Update na tabela transacoes");
DELIMITER //
create trigger log_transacoes_delete
before delete on transacoes
for each row
if user() like '%localhost%' then
    insert into log_auditoria(tabela_afetada, operacao, usuario, data_hora, detalhes)
    value("transacoes", "delete", user(), current_timestamp(), "Tentativa de delete de uma transação bloqueada - usuário no localhost");
    
end if//
DELIMITER ;

/*TAREFA 2 - OPERAÇÕES*/
insert into cliente (nome, telefone, data_cadastro) values 
("João Silva", "11987654321", current_timestamp()),
("Maria Oliveira", "21987654321", current_timestamp()),
("Carlos Souza", "31987654321", current_timestamp()),
("Ana Santos", "41987654321", current_timestamp()),
("Pedro Lima", "51987654321", current_timestamp()),
("Juliana Costa", "61987654321", current_timestamp()),
("Fernando Alves", "71987654321", current_timestamp()),
("Patrícia Rocha", "81987654321", current_timestamp()),
("Roberto Nunes", "91987654321", current_timestamp()),
("Camila Mendes", "11976543210", current_timestamp());

insert into conta (saldo, data_abertura, id_cliente) values
(1000, current_timestamp(), 1),
(2500, current_timestamp(), 2),
(500, current_timestamp(), 3),
(7000, current_timestamp(), 4),
(300, current_timestamp(), 5),
(12000, current_timestamp(), 6),
(150, current_timestamp(), 7),
(800, current_timestamp(), 8),
(4200, current_timestamp(), 9),
(960, current_timestamp(), 10);

insert into transacoes (valor, data_transacao, tipo_operação, id_conta) values
(200, current_timestamp(), "Depósito", 3),
(150, current_timestamp(), "Saque", 2),
(500, current_timestamp(), "Depósito", 3),
(700, current_timestamp(), "Saque", 4),
(100, '2025-01-01 00:00:00', "Transferência", 5),
(600, current_timestamp(), "Depósito", 6),
(300, current_timestamp(), "Pagamento", 7),
(1200, current_timestamp(), "Transferência", 8),
(50, current_timestamp(), "Saque", 9),
(400, current_timestamp(), "Pagamento", 10);

update cliente set cliente.nome = "Fulaninho de Tal" where cliente.id = 1;
update cliente set cliente.nome = "EDURDINHA GAMEPLAY" where cliente.id = 5;

insert into transacoes(valor, data_transacao, tipo_operação, id_conta) values
(100, current_timestamp(),"Depósito",2),
(100, current_timestamp(),"Saque",5);



DELETE FROM transacoes
where id_conta = 3;
DELETE FROM conta
where id_cliente = 3;
DELETE FROM cliente
WHERE id = 3;

/*TAREFA 3 - CONSULTAS*/

select id,tabela_afetada,count(operacao) as qtd_Operacoes from log_auditoria
group by tabela_afetada
order by qtd_Operacoes desc
limit 3;

select *, count(id) from log_auditoria
group by usuario
limit 3;

select * from log_auditoria where operacao like "delete";

select usuario, count(*) as tentativas_sensiveis, data_hora
from log_auditoria
where operacao like 'delete'
or
operacao like 'update'
group by usuario, data_hora
having count(*) > 2;


select * from log_auditoria;
select * from transacoes;
select user() where user() like "%localhost%";