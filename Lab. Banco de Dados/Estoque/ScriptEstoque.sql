/* SAMUEL CHAVES E GUSTAVO DOS SANTOS */
use estoque;

/*insert into Produto*/
insert into produtos value
(1,'Vassoura', 100, 10,20,1),
(2,'Luva de pedreiro 2', 50, 25.5, 10,1),
(3,'Pá de Lixo', 100, 10,20,1),
(4,'Luva de Louça', 50, 25.5, 10,1);
insert into orcamentos value
(1,current_date(),1);
insert into orcamento_produtos value
(1,1,15,300);

select * from produtos;
select * from orcamentos;
select * from orcamento_produtos;
select * from produtos_em_falta;
select * from produtos_requisicao;
select * from produtos_atualizados;
select * from Historico_Produtos_Excluidos;
select * from orcamento_produtos_cancelados;

call baixa_estoque(1,100);
call baixa_estoque(4,45);
call compara_estoque_minimo(4);
call reajusta_preco(2,10);
delete from produtos where prd_codigo = 2;
update orcamentos set orc_status = 0 where orc_id = 1;