<?php
require_once "includes/header.php";
require_once "php_action/connect_db.php";

$campo = isset($_POST['campo']) ? $_POST['campo'] : 'nome';
$valorPesquisa = isset($_POST['valorPesquisa']) ? $_POST['valorPesquisa'] : '';

$query = "SELECT * FROM clientes";
if (!empty($valorPesquisa)) {
    if ($campo === "todos") {
        $query .= " WHERE nome LIKE '%$valorPesquisa%' OR sobrenome LIKE '%$valorPesquisa%' OR email LIKE '%$valorPesquisa%' OR idade LIKE '%$valorPesquisa%'";
    } else {
        $query .= " WHERE $campo LIKE '%$valorPesquisa%'";
    }
}
$result = mysqli_query($connect, $query);
?>

<body>
    <h1 class="title is-2 " style="text-align: center; margin-top: 15px;">Lista de Clientes</h1>
    <div style="width: 70%; margin: auto;">

        <div class="content">
            <a href="cadastrar.php" class="button is-link" role="button">Cadastrar</a>
        </div>

        <form method="POST" action="">
            <label><strong>Pesquisar por:</strong></label>
            <br>
            <label><input type="radio" name="campo" value="nome" <?= ($campo == 'nome') ? 'checked' : '' ?>> Nome</label>
            <label><input type="radio" name="campo" value="sobrenome" <?= ($campo == 'sobrenome') ? 'checked' : '' ?>> Sobrenome</label>
            <label><input type="radio" name="campo" value="email" <?= ($campo == 'email') ? 'checked' : '' ?>> E-mail</label>
            <label><input type="radio" name="campo" value="idade" <?= ($campo == 'idade') ? 'checked' : '' ?>> Idade</label>
            <label><input type="radio" name="campo" value="todos" <?= ($campo == 'todos') ? 'checked' : '' ?>> Todos</label>
            <input type="text" class="input" name="valorPesquisa" value="<?= htmlspecialchars($valorPesquisa) ?>" placeholder="Digite sua pesquisa...">
            <br>
            <button type="submit" class="button is-link mt-3 mb-3">Pesquisar</button>
        </form>

        <table class="table is-bordered is-striped is-hoverable is-fullwidth">
            <thead style="background-color: #696969;">
                <tr>
                    <th style="color: #FFFFFF;">Nome</th>
                    <th style="color: #FFFFFF;">Sobrenome</th>
                    <th style="color: #FFFFFF;">Email</th>
                    <th style="color: #FFFFFF; text-align: center;">Idade</th>
                    <th style="color: #FFFFFF; text-align: center; width: 250px">Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = mysqli_fetch_assoc($result)) : ?>
                    <tr>
                        <td><?= htmlspecialchars($row['nome']) ?></td>
                        <td><?= htmlspecialchars($row['sobrenome']) ?></td>
                        <td><?= htmlspecialchars($row['email']) ?></td>
                        <td style="text-align: center;"><?= $row['idade'] ?></td>
                        <td style="text-align: center;">
                            <a href="editar.php?id=<?= $row['id'] ?>" class="button is-warning">Editar</a>
                            <a href="php_action/delete.php?id=<?= $row['id'] ?>" class="button is-danger" onclick="return confirm('Tem certeza que deseja apagar?');">Apagar</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</body>

<?php require_once "includes/footer.php"; ?>
