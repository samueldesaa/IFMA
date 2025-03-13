CREATE TABLE `bd_clientes`.`cliente` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nascimento` DATE NOT NULL,
    `nome` VARCHAR(100) NOT NULL,
    `endereco` VARCHAR(255) NOT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    `telefone` VARCHAR(14) NULL,
    `email` VARCHAR(100) NULL,
    `datacadastro` DATE NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO `cliente` (nascimento, nome, endereco, cpf, telefone, email, datacadastro)
VALUES('2023-11-23', 'Carlos Santos', 'Rua Xavante, quadra 34', '123.123.123-23', '(98)97777-0808', 'carlos@gmail.com', '2023-11-23');

INSERT INTO `cliente` (nascimento, nome, endereco, cpf, telefone, email, datacadastro)
VALUES('2023-11-23', 'José Pereira', 'Rua Flores, 34', '123.123.123-23', '(98)99999-0808', 'jp@gmail.com', '2023-11-23');

INSERT INTO `cliente` (nascimento, nome, endereco, cpf, telefone, email, datacadastro)
VALUES('2023-11-23', 'Ana Maria', 'Rua Pindorama, casa 3', '345.345.345-23', '(99)93423-1289', 'mari@gmail.com', '2023-11-23');

INSERT INTO `cliente` (nascimento, nome, endereco, cpf, telefone, email, datacadastro)
VALUES('2023-11-23', 'José Hugo', 'Rua Florianópolis, 4', '453.234.234-34', '(99)99999-0808', 'jhugo@gmail.com', '2023-11-23');

select * from cliente;