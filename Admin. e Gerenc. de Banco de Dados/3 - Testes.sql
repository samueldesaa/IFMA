use vendasdb;
set role 'role_gerente';

/*É permitido usar esta projeção*/
select * from vendasdb.supplier;

/*NÃO É permitidpo usar esta projeção*/
select * from vendasdb.orderitem;

set role 'role_gerente';

/*É permitido usar esta projeção*/
select * from vendasdb.supplier;

/*NÃO É permitidpo usar esta projeção*/
select * from vendasdb.orderitem;
