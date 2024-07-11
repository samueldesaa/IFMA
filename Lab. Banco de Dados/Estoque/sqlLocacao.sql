/*
EQUIPE:
GUSTAVO DOS SANTOS(20231SI0006)
SAMUEL CHAVES(20231SI0011)
*/

drop database if exists jogosdig;
CREATE SCHEMA IF NOT EXISTS jogosdig;
USE jogosdig ;


CREATE TABLE IF NOT EXISTS jogo (
  idJogo INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(45) NULL,
  PRIMARY KEY (idJogo)
);

INSERT INTO jogo (idJogo, titulo) VALUES
(1, 'The Witcher 3: Wild Hunt'),
(2, 'Red Dead Redemption 2'),
(3, 'The Legend of Zelda: Breath of the Wild'),
(4, 'God of War'),
(5, 'Dark Souls III');

CREATE TABLE IF NOT EXISTS plataforma (
  idPlat INT NOT NULL,
  nomePlat VARCHAR(45) NULL,
  PRIMARY KEY (idPlat)
);

INSERT INTO plataforma (idPlat, nomePlat) VALUES
(1, 'PlayStation 4'),
(2, 'Xbox One'),
(3, 'Nintendo Switch'),
(4, 'PC'),
(5, 'PlayStation 5');

CREATE TABLE IF NOT EXISTS cliente (
  cpf INT NOT NULL,
  nomeCli VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  telefone VARCHAR(45) NULL,
  PRIMARY KEY (cpf)
);

INSERT INTO cliente (cpf, nomeCli, email, telefone)
VALUES
("63503676", "Wesley Rodgers", "leo@hotmail.couk", "(651) 366-2241"),
("56738189", "Sara Brady", "sed.nulla.ante@aol.couke", "1-645-291-9168"),
("29452984", "Zia Pickett", "egestas@outlook.edu", "(267) 403-7942"),
("41506233", "Liberty Dennis", "auctor.nunc.nulla@outlook.ca", "(681) 693-4689"),
("85482447", "Noelani Gould", "libero.dui@outlook.edu", "(815) 987-0772");

CREATE TABLE IF NOT EXISTS jogo_plataforma (
  jogo_idJogo INT NOT NULL,
  plataforma_idPlat INT NOT NULL,
  precoDiario DOUBLE NULL,
  PRIMARY KEY (jogo_idJogo, plataforma_idPlat),
  FOREIGN KEY (jogo_idJogo) REFERENCES jogo (idJogo),
  FOREIGN KEY (plataforma_idPlat) REFERENCES plataforma (idPlat)
);

INSERT INTO jogo_plataforma (jogo_idJogo, plataforma_idPlat, precoDiario) VALUES
(1, 1, 5.99),
(1, 4, 4.99),
(2, 1, 6.99),
(2, 2, 7.99),
(3, 3, 8.99),
(4, 1, 9.99),
(4, 5, 10.99),
(5, 4, 5.99),
(5, 3, 6.99);

CREATE TABLE IF NOT EXISTS console (
  idCons INT NOT NULL,
  nomeCons VARCHAR(45) NULL,
  precoHora DOUBLE NULL,
  plataforma_idPlat INT NOT NULL,
  PRIMARY KEY (idCons, plataforma_idPlat),
  FOREIGN KEY (plataforma_idPlat) REFERENCES plataforma (idPlat)
);

INSERT INTO console (idCons, nomeCons, precoHora, plataforma_idPlat) VALUES
(1, 'PlayStation 4', 2.99, 1),
(2, 'Xbox One', 3.49, 2),
(3, 'Nintendo Switch', 2.79, 3),
(4, 'PC', 2.99, 4),
(5, 'PlayStation 5', 4.99, 5);

CREATE TABLE IF NOT EXISTS locacao (
  idLoc INT NOT NULL,
  cliente_idCli INT NOT NULL,
  PRIMARY KEY (idLoc),
  FOREIGN KEY (cliente_idCli) REFERENCES cliente (cpf)
);

INSERT INTO locacao (idLoc, cliente_idCli) VALUES
(1,"63503676"), (2,"63503676"), (3,"56738189"), (4,"85482447"), (5,"29452984");

CREATE TABLE IF NOT EXISTS cliente_console (
  cliente_idCli INT NOT NULL,
  console_idCons INT NOT NULL,
  inicio DATETIME NOT NULL,
  fim DATETIME NOT NULL,
  PRIMARY KEY (cliente_idCli, console_idCons),
  FOREIGN KEY (cliente_idCli) REFERENCES cliente (cpf),
  FOREIGN KEY (console_idCons) REFERENCES console (idCons)
);

INSERT INTO cliente_console (cliente_idCli, console_idCons, inicio, fim) VALUES
("63503676", 1, '2024-03-01 10:00:00', '2024-03-01 13:00:00'),
("56738189", 2, '2024-03-01 14:00:00', '2024-03-01 15:00:00'),
("56738189", 3, '2024-03-02 09:00:00', '2024-03-02 12:30:00'),
("29452984", 4, '2024-03-03 16:00:00', '2024-03-03 18:00:00'),
("41506233", 5, '2024-03-04 11:00:00', '2024-03-04 12:30:00');

CREATE TABLE IF NOT EXISTS acessorios (
  idAcess INT NOT NULL,
  nomeAcess VARCHAR(255) NULL,
  console_idCons INT NULL,
  PRIMARY KEY (idAcess, console_idCons),
  FOREIGN KEY (console_idCons) REFERENCES console (idCons)
);

INSERT INTO acessorios (idAcess, nomeAcess, console_IdCons) VALUES
(1, 'Controle sem fio', 1),
(2, 'Headset gamer', 2),
(3, 'Case para cartuchos', 3),
(4, 'Mouse e teclado', 4),
(5, 'Controle DualSense', 5),
(6, 'Controle personalizado', 1),
(7, 'Kinect', 2),
(8, 'Pro controler', 3),
(9, 'Headset Gamer', 4),
(10, 'Headset Gamer', 5);

CREATE TABLE IF NOT EXISTS senha_cliente (
  senha VARCHAR(100) NULL,
  cliente_cpf INT NOT NULL,
  PRIMARY KEY (cliente_cpf),
  FOREIGN KEY (cliente_cpf) REFERENCES cliente (cpf)
);

CREATE TABLE IF NOT EXISTS item_locacao (
  dataInicio DATE NOT NULL,
  qtdDias INT NOT NULL,
  quantidadeJogos INT NOT NULL,
  idLoc INT NOT NULL,
  idCli INT NOT NULL,
  idJogo INT NOT NULL,
  idPlat INT NOT NULL,
  PRIMARY KEY (idLoc, idCli, idJogo, idPlat)
);

INSERT INTO item_locacao (dataInicio, qtdDias, quantidadeJogos, idLoc, idCli, idJogo, idPlat) VALUES
('2024-03-01', 5, 1, 1, 63503676, 1, 4),
('2024-03-01', 4, 1, 2, 63503676, 2, 2),
('2024-03-03', 7, 1, 3, 56738189, 4, 1),
('2024-03-04', 3, 2, 4, 85482447, 5, 3),
('2024-03-05', 2, 1, 5, 29452984, 5, 4),
('2024-03-05', 5, 2, 3, 56738189, 1, 1),
('2024-03-03', 4, 1, 3, 56738189, 2, 2),
('2024-03-06', 7, 1, 4, 85482447, 3, 3),
('2024-03-10', 3, 3, 2, 63503676, 1, 1);