<?php
    require_once "includes/header.php";
    require_once "php_action/connect_db.php";

    $dados = [];
    $id = '';

    if (isset($_GET['id'])) {
        $id = mysqli_real_escape_string($connect, $_GET['id']);
        $sql = "SELECT * FROM clientes WHERE id = '$id'";
        $resultado = mysqli_query($connect, $sql);

        if ($resultado && mysqli_num_rows($resultado) > 0) {
            $dados = mysqli_fetch_array($resultado, MYSQLI_ASSOC);
        } else {
            echo "<p style='color: red; text-align: center;'>Cliente não encontrado.</p>";
            exit;
        }
    } else {
        echo "<p style='color: red; text-align: center;'>ID não fornecido.</p>";
        exit;
    }
?>

<h1 class="title is-3" style="text-align: center; margin-top: 15px;">Editar Cliente</h1>

<div style="width: 50%; margin: auto;">
    <form action="php_action/update.php" method="post">
        <input type="hidden" value="<?php echo htmlspecialchars($id); ?>" name="id">

        <div class="field">
            <label class="label" for="nome">Nome <span style="color: red;">*</span></label>
            <div class="control">
                <input id="nome" name="nome" placeholder="Ex: Marcos" class="input is-link" required type="text" value="<?php echo htmlspecialchars($dados['nome'] ?? ''); ?>">
            </div>
        </div>

        <div class="field">
            <label class="label" for="sobrenome">Sobrenome <span style="color: red;">*</span></label>
            <div class="control">
                <input id="sobrenome" name="sobrenome" placeholder="Ex: Silva" class="input is-link" required type="text" value="<?php echo htmlspecialchars($dados['sobrenome'] ?? ''); ?>">
            </div>
        </div>

        <div class="field">
            <label class="label" for="email">Email <span style="color: red;">*</span></label>
            <div class="control">
                <input id="email" name="email" placeholder="exemplo@gmail.com" class="input is-link" required type="email" value="<?php echo htmlspecialchars($dados['email'] ?? ''); ?>" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
            </div>
        </div>

        <div class="field">
            <label class="label" for="idade">Idade <span style="color: red;">*</span></label>
            <div class="control">
                <input id="idade" name="idade" placeholder="Ex: 30" class="input is-link" required type="number" value="<?php echo htmlspecialchars($dados['idade'] ?? ''); ?>">
            </div>
        </div>

        <div class="field is-grouped">
            <div class="control">
                <button type="submit" class="button is-warning" name="btn-editar">Editar</button>
            </div>
            <div class="control">
                <a href="index.php" class="button is-success">Voltar</a>
            </div>
        </div>
    </form>
</div>

<?php require_once "includes/footer.php"; ?>
