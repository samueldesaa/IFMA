drop database if exists jogosdig;
CREATE SCHEMA IF NOT EXISTS jogosdig;
USE jogosdig ;


CREATE TABLE IF NOT EXISTS `jogo` (
  `idJogo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  PRIMARY KEY (`idJogo`));

CREATE TABLE IF NOT EXISTS `plataforma` (
  `idPlat` INT NOT NULL,
  `nomePlat` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlat`));

CREATE TABLE IF NOT EXISTS `cliente` (
  `cpf` INT NOT NULL,
  `nomeCli` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`cpf`));

CREATE TABLE IF NOT EXISTS `jogo_plataforma` (
  `jogo_idJogo` INT NOT NULL,
  `plataforma_idPlat` INT NOT NULL,
  `precoDiario` INT NULL,
  PRIMARY KEY (`jogo_idJogo`, `plataforma_idPlat`),
    FOREIGN KEY (`jogo_idJogo`)
    REFERENCES `jogo` (`idJogo`),
    FOREIGN KEY (`plataforma_idPlat`)
    REFERENCES `plataforma` (`idPlat`));

CREATE TABLE IF NOT EXISTS `console` (
  `idCons` INT NOT NULL,
  `nomeCons` VARCHAR(45) NULL,
  `precoHora` INT NULL,
  `plataforma_idPlat` INT NOT NULL,
  PRIMARY KEY (`idCons`, `plataforma_idPlat`),
    FOREIGN KEY (`plataforma_idPlat`)
    REFERENCES `plataforma` (`idPlat`));

CREATE TABLE IF NOT EXISTS `locacao` (
  `idLoc` INT NOT NULL,
  `idJogo` INT NULL,
  `idPlat` INT NULL,
  `cliente_idCli` INT NOT NULL,
  PRIMARY KEY (`idLoc`, `cliente_idCli`),
    FOREIGN KEY (`cliente_idCli`)
    REFERENCES `cliente` (`cpf`));

CREATE TABLE IF NOT EXISTS `cliente_console` (
  `cliente_idCli` INT NOT NULL,
  `console_idCons` INT NOT NULL,
  `inicio` DATETIME NOT NULL,
  `fim` DATETIME NOT NULL,
  PRIMARY KEY (`cliente_idCli`, `console_idCons`),
    FOREIGN KEY (`cliente_idCli`)
    REFERENCES `cliente` (`cpf`),
    FOREIGN KEY (`console_idCons`)
    REFERENCES `console` (`idCons`));
    
CREATE TABLE IF NOT EXISTS `acessorios` (
  `idAcess` INT NOT NULL,
  `nomeAcess` VARCHAR(45) NULL,
  `console_idCons` INT NOT NULL,
  PRIMARY KEY (`idAcess`, `console_idCons`),
    FOREIGN KEY (`console_idCons`)
    REFERENCES `console` (`idCons`));

CREATE TABLE IF NOT EXISTS `senha_cliente` (
  `senha` VARCHAR(100) NULL,
  `cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`cliente_cpf`),
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `cliente` (`cpf`));
    
CREATE TABLE IF NOT EXISTS `item_locacao` (
  `dias` DATE NULL,
  `quantidade` INT NULL,
  `locacao_idLoc` INT NOT NULL,
  `locacao_cliente_idCli` INT NOT NULL,
  `jogo_plataforma_jogo_idJogo` INT NOT NULL,
  `jogo_plataforma_plataforma_idPlat` INT NOT NULL,
  PRIMARY KEY (`locacao_idLoc`, `locacao_cliente_idCli`, `jogo_plataforma_jogo_idJogo`, `jogo_plataforma_plataforma_idPlat`),
    FOREIGN KEY (`locacao_idLoc` , `locacao_cliente_idCli`)
    REFERENCES `locacao` (`idLoc` , `cliente_idCli`),
    FOREIGN KEY (`jogo_plataforma_jogo_idJogo` , `jogo_plataforma_plataforma_idPlat`)
    REFERENCES `jogo_plataforma` (`jogo_idJogo` , `plataforma_idPlat`));