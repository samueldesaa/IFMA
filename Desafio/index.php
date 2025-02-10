<?php
require_once "includes/header.php";
require_once "php_action/connect_db.php";
?>

<body>
    <h1 class="title is-3" style="text-align: center; margin-top: 15px;"> Lista de Clientes </h1>
    <div style="width: 70%; margin: auto;">
        <div class="content"><a href="cadastrar.php" class="button is-link" role="button" aria-pressed="true"> Cadastrar</a></div>
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
            <?php require_once "php_action/read.php"; ?> <!-- tabela-->
        </table>
    </div>
</body>

<?php require_once "includes/footer.php"; ?>
