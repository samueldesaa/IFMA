<?php
function clear($input){

    // Torna a variável $connect (uma conexão ao banco de dados)
    // acessível dentro da função.
    global $connect;

    // Evita ataques de injeção SQL escapando caracteres especiais do $input.
    $var = mysqli_escape_string($connect, $input);

    // Evita ataques XSS (Cross-Site Scripting) convertendo caracteres especiais
    // para entidades HTML.
    $var = htmlspecialchars($var);

    return $var; // Retorna o valor sanitizado.
}
?>
