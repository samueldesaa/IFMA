<?php
$enderecoServer = "localhost";
$username = "root";
$password = "";
$database = "clientes_db";

$connect = mysqli_connect($enderecoServer, $username, $password);

if (!$connect) {
    die("Erro na conexão com o servidor MySQL: " . mysqli_connect_error());
}

$sql_drop_db = "DROP DATABASE IF EXISTS $database";
if (mysqli_query($connect, $sql_drop_db)) {
    echo "Banco de dados '$database' excluído com sucesso!<br>";
} else {
    die("Erro ao excluir o banco de dados: " . mysqli_error($connect));
}

$sql_create_db = "CREATE DATABASE $database";
if (mysqli_query($connect, $sql_create_db)) {
    echo "Banco de dados '$database' criado com sucesso!<br>";
} else {
    die("Erro ao criar o banco de dados: " . mysqli_error($connect));
}

mysqli_select_db($connect, $database);

$sql_create_table = "
CREATE TABLE IF NOT EXISTS clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  sobrenome VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  idade INT NOT NULL,
  PRIMARY KEY (id)
)";

if (mysqli_query($connect, $sql_create_table)) {
    echo "Tabela 'clientes' criada com sucesso!<br>";
} else {
    die("Erro ao criar a tabela: " . mysqli_error($connect));
}

$sql_insert = "
INSERT INTO clientes (nome, sobrenome, email, idade) VALUES
('Joao', 'Silva', 'joao.silva@email.com', 30),
('Maria', 'Oliveira', 'maria.oliveira@email.com', 25),
('Carlos', 'Souza', 'carlos.souza@email.com', 40),
('Ana', 'Pereira', 'ana.pereira@email.com', 35),
('Pedro', 'Santos', 'pedro.santos@email.com', 28),
('Julia', 'Ferreira', 'julia.ferreira@email.com', 22),
('Ricardo', 'Lima', 'ricardo.lima@email.com', 33),
('Fernanda', 'Gomes', 'fernanda.gomes@email.com', 27),
('Bruno', 'Almeida', 'bruno.almeida@email.com', 45),
('Camila', 'Martins', 'camila.martins@email.com', 32),
('Felipe', 'Rocha', 'felipe.rocha@email.com', 29),
('Lucas', 'Costa', 'lucas.costa@email.com', 31),
('Mariana', 'Mendes', 'mariana.mendes@email.com', 24),
('Gustavo', 'Ribeiro', 'gustavo.ribeiro@email.com', 34),
('Patricia', 'Araujo', 'patricia.araujo@email.com', 26),
('Eduardo', 'Barros', 'eduardo.barros@email.com', 37),
('Isabela', 'Cavalcante', 'isabela.cavalcante@email.com', 23),
('Roberto', 'Nascimento', 'roberto.nascimento@email.com', 42),
('Daniela', 'Farias', 'daniela.farias@email.com', 30),
('Thiago', 'Carvalho', 'thiago.carvalho@email.com', 36),
('Larissa', 'Vieira', 'larissa.vieira@email.com', 28),
('Henrique', 'Teixeira', 'henrique.teixeira@email.com', 41),
('Claudia', 'Brito', 'claudia.brito@email.com', 26),
('Marcelo', 'Leite', 'marcelo.leite@email.com', 39),
('Juliana', 'Nunes', 'juliana.nunes@email.com', 29),
('Renato', 'Fonseca', 'renato.fonseca@email.com', 38),
('Carla', 'Dias', 'carla.dias@email.com', 33),
('Rodrigo', 'Ramos', 'rodrigo.ramos@email.com', 44),
('Beatriz', 'Lopes', 'beatriz.lopes@email.com', 21),
('Fernando', 'Melo', 'fernando.melo@email.com', 40);
";

if (mysqli_query($connect, $sql_insert)) {
    echo "Dados inseridos com sucesso!<br>";
} else {
    echo "Erro ao inserir dados: " . mysqli_error($connect);
}

mysqli_close($connect);
?>
