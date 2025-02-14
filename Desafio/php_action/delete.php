<?php
require_once "connect_db.php";
require_once "clearInput.php";

if (isset($_GET['id'])) {
    $id = mysqli_real_escape_string($connect, $_GET['id']);

    $sql = "DELETE FROM clientes WHERE id = '$id'";

    if (mysqli_query($connect, $sql)) {
        header("Location: ../index.php");
        exit;
    } else {
        echo "<p style='color: red;'>Erro ao excluir cliente: " . mysqli_error($connect) . "</p>";
    }
} else {
    echo "<p style='color: red;'>ID não fornecido.</p>";
}
?>
