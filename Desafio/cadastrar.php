<?php
require_once "includes/header.php";
?>

<body>
    <h1 class="title is-3" style="text-align: center; margin-top: 15px;"> Novo Cliente </h1>
    <div style="width: 50%; margin: auto;">
        <form action="php_action/create.php" method="post">
            <div class="field">
                <label class="label" for="nome">Nome <h11>*</h11></label>
                <div class="control">
                    <input class="input is-link" id="nome" name="nome" placeholder="Ex: Marcos" class="form-control input-md" required="" type="text">
                </div>
            </div>
            <div class="field">
                <label class="label" for="sobrenome">Sobrenome <h11>*</h11></label>
                <div class="control">
                    <input class="input is-link" id="sobrenome" name="sobrenome" placeholder="Ex: Andrade" class="form-control input-md" required="" type="text">
                </div>
            </div>
            <div class="field">
                <label class="label" for="email">Email <h11>*</h11></label>
                <div class="control">
                    <input class="input is-link" id="email" name="email" class="form-control" placeholder="email@email.com" required="" type="text" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
                </div>
            </div>
            <div class="field">
                <label class="label" for="idade">Idade <h11>*</h11></label>
                <div class="control">
                    <input class="input is-link" id="idade" name="idade" placeholder="Ex: 18" class="form-control input-md" required="" type="text">
                </div>
            </div>
            <br>
            <div class="content">
                <button type="submit" class="button is-link" name="btn-cadastro">Cadastrar</button>
                <a href="index.php" class="button is-success">Voltar</a>
            </div>
        </form>
        <!-- -->
</body>
<?php require_once "includes/footer.php"; ?>