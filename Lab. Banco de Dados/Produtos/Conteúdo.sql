use jogosdig;

INSERT INTO `jogo` (`titulo`) VALUES
('The Legend of Zelda: Breath of the Wild'), ('Super Mario Odyssey'), ('Minecraft'),
('The Witcher 3: Wild Hunt'), ('Red Dead Redemption 2'), ('Fortnite'),
('Overwatch'), ('Dark Souls III'), ('Sekiro: Shadows Die Twice'), ('Celeste'),
('Stardew Valley'), ('Hollow Knight'), ('Cuphead'), ('Super Smash Bros. Ultimate'),
('God of War'), ('Spider-Man'), ('The Elder Scrolls V: Skyrim'), ('Grand Theft Auto V'),
('Doom Eternal'), ('Control'), ('Death Stranding'), ('Cyberpunk 2077'),
('Ghost of Tsushima'), ('Final Fantasy VII Remake'), ('Resident Evil 2'),
('Animal Crossing: New Horizons'), ('Fall Guys: Ultimate Knockout'), ('Among Us'),
('Hades'), ('Assassin\'s Creed Valhalla');

INSERT INTO `plataforma` (`idPlat`, `nomePlat`) VALUES
(1, 'Nintendo Switch'),
(2, 'PlayStation 4'),
(3, 'Xbox One'),
(4, 'PC'),
(5, 'PlayStation 5'),
(6, 'Xbox Series X'),
(7, 'Nintendo 3DS'),
(8, 'PlayStation Vita');

INSERT INTO `jogo_plataforma` (`jogo_idJogo`, `plataforma_idPlat`, `precoDiario`) VALUES
(1, 1, 10), (2, 1, 15), (3, 1, 12),
(4, 2, 18), (5, 2, 20), (6, 2, 11),
(7, 3, 14), (8, 3, 16), (9, 3, 13),
(10, 4, 17), (11, 4, 19), (12, 4, 13),
(13, 5, 21), (14, 5, 23), (15, 5, 18),
(16, 6, 22), (17, 6, 24), (18, 6, 19),
(19, 7, 9), (20, 7, 10), (21, 7, 8),
(22, 8, 7), (23, 8, 6), (24, 8, 5),
(25, 1, 10), (26, 1, 15), (27, 1, 12),
(28, 2, 18), (29, 2, 20), (30, 2, 11);

INSERT INTO `cliente` VALUES
(12345678900, 'Ana Beatriz', 'ana.beatriz@email.com', '(11) 98765-4321'),
(12345678901, 'Carlos Eduardo', 'carlos.eduardo@email.com', '(21) 98765-4321'),
(12345678902, 'Fernanda Lima', 'fernanda.lima@email.com', '(31) 98765-4321'),
(12345678903, 'Diego Souza', 'diego.souza@email.com', '(41) 98765-4321'),
(12345678904, 'Elisa Martins', 'elisa.martins@email.com', '(51) 98765-4321'),
(12345678905, 'Gabriel Oliveira', 'gabriel.oliveira@email.com', '(61) 98765-4321'),
(12345678906, 'Helena Gomes', 'helena.gomes@email.com', '(71) 98765-4321'),
(12345678907, 'Ígor Santos', 'igor.santos@email.com', '(81) 98765-4321'),
(12345678908, 'Joana Machado', 'joana.machado@email.com', '(91) 98765-4321'),
(12345678909, 'Lucas Andrade', 'lucas.andrade@email.com', '(11) 98765-4322');

INSERT INTO `console` (`idCons`, `nomeCons`, `precoHora`, `plataforma_idPlat`) VALUES
(1, 'Nintendo Switch', 5, 1),
(2, 'PlayStation 4', 6, 2),
(3, 'Xbox One', 7, 3),
(4, 'PlayStation 5', 8, 5),
(5, 'Xbox Series X', 9, 6),
(6, 'Nintendo 3DS', 4, 7),
(7, 'PlayStation Vita', 3, 8),
(8, 'Nintendo Switch', 5, 1);

INSERT INTO `locacao` (`idLoc`, `idJogo`, `idPlat`, `cliente_idCli`) VALUES
(1, 1, 1, 12345678900),
(2, 2, 1, 12345678901),
(3, 3, 1, 12345678901),
(4, 4, 2, 12345678902),
(6, 6, 2, 12345678904),
(7, 7, 3, 12345678905),
(8, 8, 3, 12345678905),
(9, 9, 3, 12345678906),
(11, 1, 1, 12345678908),
(12, 2, 1, 12345678909);

INSERT INTO `cliente_console` (`cliente_idCli`, `console_idCons`, `inicio`, `fim`) VALUES
(12345678900, 1, '2024-03-08 10:00:00', '2024-03-08 12:00:00'),
(12345678901, 2, '2024-03-08 11:00:00', '2024-03-08 13:30:00'),
(12345678901, 3, '2024-03-08 14:00:00', '2024-03-08 15:00:00'),
(12345678902, 4, '2024-03-08 15:30:00', '2024-03-08 17:00:00'),
(12345678904, 5, '2024-03-08 17:30:00', '2024-03-08 18:30:00'),
(12345678905, 6, '2024-03-08 19:00:00', '2024-03-08 20:00:00'),
(12345678905, 7, '2024-03-08 20:30:00', '2024-03-08 22:00:00'),
(12345678906, 8, '2024-03-08 22:30:00', '2024-03-08 23:30:00');

INSERT INTO `acessorios` (`idAcess`, `nomeAcess`, `console_idCons`) VALUES
(1, 'Controle Sem Fio', 1),
(2, 'Headset Gamer', 2),
(3, 'Cabo HDMI', 3),
(4, 'Carregador de Controle', 4),
(5, 'Suporte Vertical', 5),
(6, 'Capa Protetora', 6),
(7, 'Cartão de Memória', 7),
(8, 'Bateria Externa', 8);

INSERT INTO `senha_cliente` (`senha`, `cliente_cpf`) VALUES
('senha123', 12345678900),
('abc$321', 12345678901),
('qwerty', 12345678902),
('123abc', 12345678903),
('xyz987', 12345678904),
('pass#456', 12345678905),
('senha!789', 12345678906),
('minhasenha', 12345678907),
('123senha', 12345678908),
('senha$ecure', 12345678909);

INSERT INTO `item_locacao` (`dias`, `quantidade`, `locacao_idLoc`, `jogo_plataforma_jogo_idJogo`, `jogo_plataforma_plataforma_idPlat`, `locacao_cliente_idCli`) VALUES
('2024-03-12', 1, 6, 6, 2, 12345678904),
('2024-03-13', 1, 7, 7, 3, 12345678905),
('2024-03-14', 1, 8, 8, 3, 12345678905),
('2024-03-15', 2, 9, 9, 3, 12345678906),
('2024-03-16', 1, 11, 1, 1, 12345678908),
('2024-03-17', 1, 12, 2, 1, 12345678909),
('2024-02-15', 2, 2, 2, 1, 12345678901),
('2024-03-09', 5, 3, 3, 1, 12345678901);

/*(1, 1, 1, 12345678900),
(2, 2, 1, 12345678901),
(3, 3, 1, 12345678901),
(4, 4, 2, 12345678902),
(6, 6, 2, 12345678904),
(7, 7, 3, 12345678905),
(8, 8, 3, 12345678905),
(9, 9, 3, 12345678906),
(11, 1, 1, 12345678908),
(12, 2, 1, 12345678909);*/