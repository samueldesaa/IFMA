-- Drop do banco de dados, removendo tudo
DROP DATABASE IF EXISTS Empresa;

-- Criação do banco de dados novamente
CREATE DATABASE Empresa;
USE Empresa;

-- Tabela DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    Dnome VARCHAR(50),
    Dnumero INT PRIMARY KEY,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE
);

-- Tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    Pnome VARCHAR(50),
    Minicial CHAR(1),
    Unome VARCHAR(50),
    Cpf CHAR(11) PRIMARY KEY,
    Datanasc DATE,
    Endereco VARCHAR(100),
    Sexo CHAR(1),
    Salario DECIMAL(10, 2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero)
);

-- Atualizando DEPARTAMENTO para referenciar FUNCIONARIO após sua criação
ALTER TABLE DEPARTAMENTO
ADD FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf);

-- Tabela LOCALIZACAO_DEP
CREATE TABLE LOCALIZACAO_DEP (
    Dnumero INT,
    Dlocal VARCHAR(50),
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);

-- Tabela PROJETO
CREATE TABLE PROJETO (
    Projnome VARCHAR(50),
    Projnumero INT PRIMARY KEY,
    Projlocal VARCHAR(50),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO(Dnumero)
);

-- Tabela TRABALHA_EM
CREATE TABLE TRABALHA_EM (
    Fcpf CHAR(11),
    Pnr INT,
    Horas DECIMAL(5, 2),
    PRIMARY KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);

-- Tabela DEPENDENTE
CREATE TABLE DEPENDENTE (
    Fcpf CHAR(11),
    Nome_dependente VARCHAR(50),
    Sexo CHAR(1),
    Datanasc DATE,
    Parentesco VARCHAR(20),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);



use empresa;

-- Remover usuários e views existentes
drop user if exists 'a'@'localhost';
drop user if exists 'b'@'localhost';
drop user if exists 'c'@'localhost';
drop user if exists 'd'@'localhost';
drop user if exists 'e'@'localhost';

drop view if exists funcionario_view;
drop view if exists departamento_view;
drop view if exists trabalha_em_view;
drop view if exists funcionario_dnr3_view;

-- Criar usuários
create user 'a'@'localhost' identified by 'A123';
grant all privileges on empresa.* to 'a'@'localhost' with grant option;
grant all privileges on empresa.dependente to 'a'@'localhost';
flush privileges;
revoke all privileges on empresa.dependente from 'a'@'localhost';
flush privileges;

create user 'b'@'localhost' identified by 'B123';

create view funcionario_view as
select 
    pnome, minicial, unome, datanasc, endereco, sexo, dnr
from funcionario;

create view departamento_view as
select 
    dnome, dnumero
from departamento;

grant select on funcionario_view to 'b'@'localhost';
grant select on departamento_view to 'b'@'localhost';
flush privileges;

create user 'c'@'localhost' identified by 'C123';

create view trabalha_em_view as
select 
    f.pnome, f.minicial, f.unome, f.cpf, p.projnome, p.projnumero
from trabalha_em t
join funcionario f on f.cpf = t.fcpf
join projeto p on p.projnumero = t.pnr;

grant select, insert, update, delete on trabalha_em_view to 'c'@'localhost';
flush privileges;

create user 'd'@'localhost' identified by 'D123';

grant select, update on empresa.dependente to 'd'@'localhost';
grant select on empresa.funcionario to 'd'@'localhost';
flush privileges;

create user 'e'@'localhost' identified by 'E123';

create view funcionario_dnr3_view as
select 
    pnome, minicial, unome, datanasc, endereco, sexo, salario, dnr
from funcionario
where dnr = 3;

grant select on funcionario_dnr3_view to 'e'@'localhost';
flush privileges;
