DROP DATABASE IF EXISTS imobiliaria;
CREATE DATABASE IF NOT EXISTS imobiliaria /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE imobiliaria;

-- Table structure for table cliente
DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  id int(11) NOT NULL AUTO_INCREMENT,
  nome_cliente varchar(255) DEFAULT NULL,
  cpf varchar(255) DEFAULT NULL,
  telefone1 varchar(10) DEFAULT NULL,
  telefone2 varchar(10) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  dt_nascimento date DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table tipo_imovel
DROP TABLE IF EXISTS tipo_imovel;
CREATE TABLE tipo_imovel (
  id int(11) NOT NULL AUTO_INCREMENT,
  descricao varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table imovel
DROP TABLE IF EXISTS imovel;
CREATE TABLE imovel (
  id int(11) NOT NULL AUTO_INCREMENT,
  endereco varchar(255) DEFAULT NULL,
  cep varchar(10) DEFAULT NULL,
  dormitorios int(11) DEFAULT NULL,
  banheiros int(11) DEFAULT NULL,
  suites int(11) DEFAULT NULL,
  metragem int(11) DEFAULT NULL,
  valor_aluguel_sugerido decimal(10,2) DEFAULT NULL,
  obs mediumtext DEFAULT NULL,
  proprietario_id int(11) NOT NULL,
  tipo_imovel_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_imovel_cliente_idx (proprietario_id),
  KEY fk_imovel_tipo_imovel1_idx (tipo_imovel_id),
  FOREIGN KEY (proprietario_id) REFERENCES cliente (id),
  FOREIGN KEY (tipo_imovel_id) REFERENCES tipo_imovel (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table locacao
DROP TABLE IF EXISTS locacao;
CREATE TABLE locacao (
  id int(11) NOT NULL AUTO_INCREMENT,
  dt_inicio date DEFAULT NULL,
  dt_fim date DEFAULT NULL,
  valor_aluguel decimal(10,2) DEFAULT NULL,
  valor_condominio decimal(10,2) DEFAULT NULL,
  valor_iptu decimal(10,2) DEFAULT NULL,
  obs mediumtext DEFAULT NULL,
  cliente_id int(11) NOT NULL,
  imovel_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_locacao_cliente1_idx (cliente_id),
  KEY fk_locacao_imovel1_idx (imovel_id),
  FOREIGN KEY (cliente_id) REFERENCES cliente (id),
  FOREIGN KEY (imovel_id) REFERENCES imovel (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table aluguel
DROP TABLE IF EXISTS aluguel;
CREATE TABLE aluguel (
  id int(11) NOT NULL AUTO_INCREMENT,
  dt_vencimento date NOT NULL,
  valor_pago decimal(10,2) DEFAULT NULL,
  obs mediumtext DEFAULT NULL,
  locacao_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_aluguel_locacao1_idx (locacao_id),
  FOREIGN KEY (locacao_id) REFERENCES locacao (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table profissional
DROP TABLE IF EXISTS profissional;
CREATE TABLE profissional (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome varchar(45) DEFAULT NULL,
  profissao varchar(45) DEFAULT NULL,
  telefone1 varchar(12) DEFAULT NULL,
  telefone2 varchar(12) DEFAULT NULL,
  valor_hora decimal(10,2) DEFAULT NULL,
  obs text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Table structure for table servicos_imovel
DROP TABLE IF EXISTS servicos_imovel;
CREATE TABLE servicos_imovel (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_profissional int(11),
  id_imovel int(11),
  data_servico date DEFAULT NULL,
  valor_total decimal(10,2) DEFAULT NULL,
  obs text DEFAULT NULL,
  FOREIGN KEY (id_profissional) REFERENCES profissional(id),
  FOREIGN KEY (id_imovel) REFERENCES imovel(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dados para a tabela `cliente`
INSERT INTO `cliente` (nome_cliente, cpf, telefone1, telefone2, email, dt_nascimento) VALUES 
('Ana Silva','111.222.333-44','987654321','123456789','ana.silva@email.com','1995-08-20'),
('Carlos Oliveira','222.333.444-55','123456789','987654321','carlos.oliveira@email.com','1980-03-12'),
('Mariana Santos','333.444.555-66','555666777','444333222','mariana.santos@email.com','1992-11-25'),
('Ricardo Pereira','444.555.666-77','999888777','666555444','ricardo.pereira@email.com','1988-07-01'),
('Juliana Lima','555.666.777-88','111222333','777888999','juliana.lima@email.com','1997-04-05'),
('Pedro Souza','666.777.888-99','333222111','888999000','pedro.souza@email.com','1985-09-15'),
('Camila Pereira','777.888.999-00','777888999','222111333','camila.pereira@email.com','1990-12-30'),
('Fernando Santos','888.999.000-11','555444333','111000999','fernando.santos@email.com','1982-06-18'),
('Isabel Lima','999.000.111-22','111222333','333444555','isabel.lima@email.com','1994-02-28'),
('Lucas Oliveira','123.456.789-09','333444555','555666777','lucas.oliveira@email.com','1987-10-10'),
('Fernanda Rocha','987.654.321-09','9876543210','1234567890','fernanda.rocha@email.com','1993-06-08'),
('Rafael Oliveira','234.567.890-12','8765432109','2109876543','rafael.oliveira@email.com','1986-04-15'),
('Patricia Souza','345.678.901-23','7654321098','1098765432','patricia.souza@email.com','1991-10-22'),
('Anderson Santos','456.789.012-34','6543210987','0987654321','anderson.santos@email.com','1984-12-01'),
('Larissa Lima','567.890.123-45','5432109876','8765432109','larissa.lima@email.com','1996-02-14'),
('Roberto Pereira','678.901.234-56','4321098765','7654321098','roberto.pereira@email.com','1989-08-30'),
('Cristina Silva','789.012.345-67','3210987654','5432109876','cristina.silva@email.com','1990-03-25'),
('Luciano Oliveira','890.123.456-78','2109876543','4321098765','luciano.oliveira@email.com','1983-11-18'),
('Tatiane Souza','901.234.567-89','9876543210','6543210987','tatiane.souza@email.com','1995-07-28'),
('Marcos Santos','012.345.678-90','8765432109','1098765432','marcos.santos@email.com','1987-05-10'),
('Isabela Lima','123.456.789-01','9876543210','1234567890','isabela.lima@email.com','1990-09-15'),
('Alexandre Silva','234.567.890-12','8765432109','2109876543','alexandre.silva@email.com','1985-06-22'),
('Camila Santos','345.678.901-23','7654321098','1098765432','camila.santos@email.com','1993-03-01'),
('Ricardo Oliveira','456.789.012-34','6543210987','0987654321','ricardo.oliveira@email.com','1988-12-10'),
('Aline Pereira','567.890.123-45','5432109876','8765432109','aline.pereira@email.com','1995-01-28'),
('Eduardo Souza','678.901.234-56','4321098765','7654321098','eduardo.souza@email.com','1982-08-14'),
('Patricia Lima','789.012.345-67','3210987654','5432109876','patricia.lima@email.com','1997-05-05'),
('Fernando Oliveira','890.123.456-78','2109876543','4321098765','fernando.oliveira@email.com','1984-11-18'),
('Leticia Santos','901.234.567-89','9876543210','6543210987','leticia.santos@email.com','1990-07-22'),
('Gabriel Lima','012.345.678-90','8765432109','1098765432','gabriel.lima@email.com','1987-04-15'),
('Beatriz Pereira','123.456.789-01','9876543210','1234567890','beatriz.pereira@email.com','1992-12-25'),
('Andreia Silva','234.567.890-12','8765432109','2109876543','andreia.silva@email.com','1994-01-10'),
('Rafael Lima','345.678.901-23','7654321098','1098765432','rafael.lima@email.com','1991-08-05'),
('Roberta Souza','456.789.012-34','6543210987','0987654321','roberta.souza@email.com','1988-11-30'),
('Leonardo Oliveira','567.890.123-45','5432109876','8765432109','leonardo.oliveira@email.com','1993-09-17'),
('Tatiane Silva','678.901.234-56','4321098765','7654321098','tatiane.silva@email.com','1985-10-10'),
('Bruna Santos','789.012.345-67','3210987654','5432109876','bruna.santos@email.com','1989-06-02'),
('Samuel Lima','890.123.456-78','2109876543','4321098765','samuel.lima@email.com','1991-05-15'),
('Mariana Rocha','901.234.567-89','9876543210','6543210987','mariana.rocha@email.com','1984-11-08'),
('Eduardo Lima','012.345.678-90','8765432109','1098765432','eduardo.lima@email.com','1986-02-21');

-- Dados para a tabela `tipo_imovel`
INSERT INTO `tipo_imovel` (descricao) VALUES 
('Apartamento'),
('Casa'),
('Kitnet'),
('Cobertura'),
('Sítio'),
('Chácara'),
('Salão Comercial'),
('Terreno'),
('Loja'),
('Sala Comercial');

-- Dados para a tabela `imovel`
INSERT INTO `imovel` (endereco, cep, dormitorios, banheiros, suites, metragem, valor_aluguel_sugerido, obs, proprietario_id, tipo_imovel_id) VALUES 
('Rua A, 123','12345-678',3,2,1,90,1500.00,'Imóvel bem localizado',1,1),
('Rua B, 456','23456-789',2,1,1,60,1200.00,'Próximo ao metrô',2,2),
('Rua C, 789','34567-890',4,3,2,150,2500.00,'Com piscina e churrasqueira',3,3),
('Rua D, 101','45678-901',1,1,0,30,800.00,'Ideal para solteiros',4,4),
('Rua E, 202','56789-012',3,2,1,85,1400.00,'Próximo a faculdade',5,5),
('Rua F, 303','67890-123',2,1,1,70,1100.00,'Bem arejado',6,6),
('Rua G, 404','78901-234',5,4,2,200,3000.00,'Luxuoso e espaçoso',7,7),
('Rua H, 505','89012-345',1,1,0,40,900.00,'Ótimo para estudantes',8,8),
('Rua I, 606','90123-456',2,1,1,50,1000.00,'Próximo ao comércio',9,9),
('Rua J, 707','01234-567',3,2,1,75,1300.00,'Condomínio com segurança',10,10);

-- Dados para a tabela `locacao`
INSERT INTO `locacao` (dt_inicio, dt_fim, valor_aluguel, valor_condominio, valor_iptu, obs, cliente_id, imovel_id) VALUES 
('2024-01-01','2024-06-30',1500.00,300.00,200.00,'Contrato de 6 meses',1,1),
('2024-02-01','2024-07-31',1200.00,250.00,180.00,'Inclui taxa de manutenção',2,2),
('2024-03-01','2024-12-31',2500.00,500.00,350.00,'Imóvel com mais comodidades',3,3),
('2024-04-01','2024-09-30',800.00,150.00,100.00,'Ideal para estudantes',4,4),
('2024-05-01','2024-10-31',1400.00,280.00,220.00,'Boa localização',5,5),
('2024-06-01','2024-11-30',1100.00,260.00,190.00,'Perto de transporte público',6,6),
('2024-07-01','2024-12-31',3000.00,600.00,400.00,'Imóvel de luxo',7,7),
('2024-08-01','2024-12-31',900.00,180.00,150.00,'Apartamento pequeno',8,8),
('2024-09-01','2025-02-28',1000.00,200.00,160.00,'Próximo ao centro comercial',9,9),
('2024-10-01','2025-03-31',1300.00,270.00,210.00,'Bem localizado',10,10),
('2025-01-01', '2025-06-30', 1500.00, 300.00, 200.00, 'Renovação de contrato de 6 meses', 1, 1),
('2025-02-01', '2025-07-31', 1200.00, 250.00, 180.00, 'Contrato estendido com taxa de manutenção', 2, 2),
('2025-03-01', '2025-12-31', 2500.00, 500.00, 350.00, 'Renovação de contrato de imóvel com comodidades', 3, 3),
('2025-04-01', '2025-09-30', 800.00, 150.00, 100.00, 'Contrato renovado para estudantes', 4, 4),
('2025-05-01', '2025-10-31', 1400.00, 280.00, 220.00, 'Contrato renovado, ótima localização', 5, 5),
('2025-06-01', '2025-11-30', 1100.00, 260.00, 190.00, 'Renovação, próximo ao transporte público', 6, 6),
('2025-07-01', '2025-12-31', 3000.00, 600.00, 400.00, 'Renovação de contrato de imóvel de luxo', 7, 7),
('2025-08-01', '2025-12-31', 900.00, 180.00, 150.00, 'Contrato estendido para apartamento pequeno', 8, 8),
('2025-09-01', '2026-02-28', 1000.00, 200.00, 160.00, 'Renovação, próximo ao centro comercial', 9, 9),
('2025-10-01', '2026-03-31', 1300.00, 270.00, 210.00, 'Renovação de contrato, bem localizado', 10, 10),
('2026-01-01', '2026-06-30', 1550.00, 310.00, 210.00, 'Contrato renovado com ajuste de valor', 1, 1),
('2026-02-01', '2026-07-31', 1250.00, 260.00, 190.00, 'Renovação com manutenção inclusa', 2, 2),
('2026-03-01', '2026-12-31', 2600.00, 520.00, 360.00, 'Renovação de imóvel com mais comodidades', 3, 3),
('2026-04-01', '2026-09-30', 850.00, 160.00, 110.00, 'Estudantes, contrato estendido', 4, 4),
('2026-05-01', '2026-10-31', 1450.00, 290.00, 230.00, 'Boa localização, contrato renovado', 5, 5),
('2026-06-01', '2026-11-30', 1150.00, 270.00, 200.00, 'Renovação próxima ao transporte público', 6, 6),
('2026-07-01', '2026-12-31', 3100.00, 620.00, 420.00, 'Renovação de imóvel de luxo', 7, 7),
('2026-08-01', '2026-12-31', 950.00, 190.00, 160.00, 'Apartamento pequeno, contrato renovado', 8, 8),
('2026-09-01', '2027-02-28', 1050.00, 210.00, 170.00, 'Centro comercial, contrato estendido', 9, 9),
('2026-10-01', '2027-03-31', 1350.00, 280.00, 220.00, 'Bem localizado, renovação de contrato', 10, 10);

-- Dados para a tabela `aluguel`
INSERT INTO `aluguel` (dt_vencimento, valor_pago, obs, locacao_id) VALUES 
-- Pagamentos iniciais
('2024-01-31', 1500.00, 'Pago na data', 1),
('2024-02-29', 1200.00, 'Pago na data', 2),
('2024-03-31', 2500.00, 'Pago na data', 3),
('2024-04-30', 800.00, 'Pago na data', 4),
('2024-05-31', 1400.00, 'Pago na data', 5),
('2024-06-30', 1100.00, 'Pago na data', 6),
('2024-07-31', 3000.00, 'Pago na data', 7),
('2024-08-31', 900.00, 'Pago na data', 8),
('2024-09-30', 1000.00, 'Pago na data', 9),
('2024-10-31', 1300.00, 'Pago na data', 10),

-- Pagamentos antecipados
('2024-01-15', 1500.00, 'Pago antecipado', 1),
('2024-02-15', 1200.00, 'Pago antecipado', 2),
('2024-03-15', 2500.00, 'Pago antecipado', 3),
('2024-04-15', 800.00, 'Pago antecipado', 4),
('2024-05-15', 1400.00, 'Pago antecipado', 5),
('2024-06-15', 1100.00, 'Pago antecipado', 6),
('2024-07-15', 3000.00, 'Pago antecipado', 7),
('2024-08-15', 900.00, 'Pago antecipado', 8),
('2024-09-15', 1000.00, 'Pago antecipado', 9),
('2024-10-15', 1300.00, 'Pago antecipado', 10),

-- Pagamentos finais do ano
('2024-11-30', 1500.00, 'Pago na data', 1),
('2024-12-31', 1200.00, 'Pago na data', 2),
('2024-11-30', 2500.00, 'Pago na data', 3),
('2024-12-31', 800.00, 'Pago na data', 4),
('2024-11-30', 1400.00, 'Pago na data', 5),
('2024-12-31', 1100.00, 'Pago na data', 6),
('2024-11-30', 3000.00, 'Pago na data', 7),
('2024-12-31', 900.00, 'Pago na data', 8),
('2024-11-30', 1000.00, 'Pago na data', 9),
('2024-12-31', 1300.00, 'Pago na data', 10),

-- Pagamentos adicionais com IDs repetidos
('2024-01-31', 1550.00, 'Pago com atraso', 1),
('2024-02-29', 1250.00, 'Pago com atraso', 2),
('2024-03-31', 2550.00, 'Pago com atraso', 3),
('2024-04-30', 850.00, 'Pago com atraso', 4),
('2024-05-31', 1450.00, 'Pago com atraso', 5),
('2024-06-30', 1150.00, 'Pago com atraso', 6),
('2024-07-31', 3100.00, 'Pago com atraso', 7),
('2024-08-31', 950.00, 'Pago com atraso', 8),
('2024-09-30', 1050.00, 'Pago com atraso', 9),
('2024-10-31', 1350.00, 'Pago com atraso', 10),

('2024-01-15', 1600.00, 'Pago antecipado', 1),
('2024-02-15', 1300.00, 'Pago antecipado', 2),
('2024-03-15', 2600.00, 'Pago antecipado', 3),
('2024-04-15', 900.00, 'Pago antecipado', 4),
('2024-05-15', 1500.00, 'Pago antecipado', 5),
('2024-06-15', 1200.00, 'Pago antecipado', 6),
('2024-07-15', 3200.00, 'Pago antecipado', 7),
('2024-08-15', 950.00, 'Pago antecipado', 8),
('2024-09-15', 1100.00, 'Pago antecipado', 9),
('2024-10-15', 1400.00, 'Pago antecipado', 10);


-- Dados para a tabela `profissional`
INSERT INTO `profissional` (nome, profissao, telefone1, telefone2, valor_hora, obs) VALUES 
('João da Silva','Eletricista','123456789','987654321','50.00','Trabalha com qualidade'),
('Maria Santos','Encanadora','234567890','876543210','60.00','Experiência de 10 anos'),
('Carlos Oliveira','Pedreiro','345678901','765432109','55.00','Trabalha com rapidez'),
('Fernanda Lima','Pintora','456789012','654321098','45.00','Ótima qualidade de pintura'),
('Ricardo Souza','Jardineiro','567890123','543210987','40.00','Cuida bem dos jardins'),
('Larissa Rocha','Faxineira','678901234','432109876','35.00','Serviço de limpeza eficiente'),
('Eduardo Silva','Carpinteiro','789012345','321098765','65.00','Faz móveis sob medida'),
('Camila Pereira','Serralheiro','890123456','210987654','50.00','Trabalho de qualidade'),
('Roberto Santos','Mármore','901234567','109876543','70.00','Trabalha com mármore e granito'),
('Tatiane Costa','Vidraceiro','012345678','098765432','55.00','Instala vidros e espelhos');

-- Dados para a tabela `servicos_imovel`
INSERT INTO `servicos_imovel` (id_profissional, id_imovel, data_servico, valor_total, obs) VALUES 
(1,1,'2024-01-15',200.00,'Reparo elétrico geral'),
(2,2,'2024-02-10',300.00,'Conserto de encanamento'),
(3,3,'2024-03-05',400.00,'Reforma geral'),
(4,4,'2024-04-20',150.00,'Pintura interna'),
(5,5,'2024-05-15',250.00,'Jardinagem e paisagismo'),
(6,6,'2024-06-10',100.00,'Limpeza geral'),
(7,7,'2024-07-25',350.00,'Trabalho de carpintaria'),
(8,8,'2024-08-30',180.00,'Instalação de grades'),
(9,9,'2024-09-15',500.00,'Instalação de mármore'),
(10,10,'2024-10-05',220.00,'Troca de vidros e espelhos');
