<?php
    $enderecoServer = "localhost";
    $username = "root";
    $password = "";
    $database = "clientes_db";

    $connect = mysqli_connect($enderecoServer, $username, $password, $database);

    if (mysqli_connect_error()) {
        echo "erro na conexao: " . mysqli_connect_error();
    }
?>