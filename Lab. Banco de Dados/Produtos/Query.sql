/*
EQUIPE:
GUSTAVO DOS SANTOS(20231SI0006)
SAMUEL CHAVES(20231SI0011)
*/

use jogosdig;

/*1*/
select titulo from Jogo j, Jogo_plataforma jp, plataforma p where
p.nomePlat like '%playstation 4%' and
jp.jogo_idJogo = j.idJogo and
jp.plataforma_idPlat = p.idPlat;

/*2*/
select idPLat,titulo from Jogo j, item_locacao i where
i.idCli = 63503676 and
j.idJogo = i.idJogo;

/*3*/
select sum(qtdDias * precoDiario) from jogo_plataforma j, item_locacao i where
i.idCli = 63503676 and
j.jogo_idJogo = i.idJogo and
j.plataforma_idPlat = i.idPLat;

/*4*/
select nomeCons, precoHora, nomeAcess from acessorios a, console c where
c.idCons = a.console_IdCons;

/*5*/
select cpf,nomeCli from cliente where
cpf not in(select cliente_idCli from locacao);

/*6*/
select jogo.idJogo,idPlat,titulo,count(idLoc) as qtdAlugados from jogo,jogo_plataforma,item_locacao where
jogo.idJogo = jogo_plataforma.jogo_idJogo and
jogo_plataforma.jogo_idJogo = item_locacao.idJogo and
jogo_plataforma.plataforma_idPlat = item_locacao.idPLat
group by idJogo,idPlat order by qtdAlugados desc;

/*7*/
select cpf,nomeCLi, count(idLoc) as qtdJogosAlug from cliente,item_locacao where
cliente.cpf = item_locacao.idCLi
group by cpf order by qtdJogosAlug desc;