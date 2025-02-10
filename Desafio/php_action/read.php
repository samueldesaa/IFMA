<?php
// session_start()
$sql = "SELECT * FROM clientes ORDER BY nome ASC";
$resultado = mysqli_query($connect, $sql);

while ($dados = mysqli_fetch_array($resultado)) {
?>
    <tbody>
        <tr>
            <td><?php echo $dados['nome']; ?></td>
            <td><?php echo $dados['sobrenome']; ?></td>
            <td><?php echo $dados['email']; ?></td>
            <td style="text-align: center"><?php echo $dados['idade'] ?></td>
            <!-- Ações -->
            <td style="text-align: center">
                <a class="button is-warning" href="editar.php?id=<?php echo $dados['id'] ?>">Editar</a>
                <form action="php_action/delete.php" method="POST" style="display: inline;">
                    <input type="hidden" name="id" value="<?php echo $dados['id']; ?>">
                    <button type="submit" class="button is-danger">Apagar</button>
                </form>
            </td>
        </tr>
    </tbody>
<?php } ?>