USE vendasdb;

-- Remover usuários e roles existentes
DROP USER IF EXISTS 'admin_vendas'@'localhost';
DROP USER IF EXISTS 'gerente_vendas'@'localhost';
DROP USER IF EXISTS 'atendente_vendas'@'localhost';

DROP ROLE IF EXISTS 'role_admin';
DROP ROLE IF EXISTS 'role_gerente';
DROP ROLE IF EXISTS 'role_atendente';

-- Criar novos usuários e roles
CREATE USER 'admin_vendas'@'localhost' IDENTIFIED BY 'adm1234';
CREATE USER 'gerente_vendas'@'localhost' IDENTIFIED BY 'ger1234';
CREATE USER 'atendente_vendas'@'localhost' IDENTIFIED BY 'ate1234';

CREATE ROLE 'role_admin';
CREATE ROLE 'role_gerente';
CREATE ROLE 'role_atendente';

-- Conceder permissões à role_admin
GRANT SHOW DATABASES ON *.* TO 'role_admin';  -- Permissão para ver bancos de dados
GRANT ALL PRIVILEGES ON vendasdb.* TO 'role_admin';  -- Permissão total no banco vendasdb

-- Conceder permissões à role_gerente
GRANT SELECT, UPDATE ON vendasdb.supplier TO 'role_gerente';
GRANT SELECT, UPDATE ON vendasdb.product TO 'role_gerente';
GRANT SELECT, UPDATE ON vendasdb.order TO 'role_gerente';

-- Conceder permissões à role_atendente
GRANT SELECT ON vendasdb.customer TO 'role_atendente';
GRANT SELECT ON vendasdb.order TO 'role_atendente';

-- Atribuir roles aos usuários
GRANT 'role_admin' TO 'admin_vendas'@'localhost';
GRANT 'role_gerente' TO 'gerente_vendas'@'localhost';
GRANT 'role_atendente' TO 'atendente_vendas'@'localhost';

-- Recarregar privilégios
FLUSH PRIVILEGES;
