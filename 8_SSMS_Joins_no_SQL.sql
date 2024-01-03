left outer join  (x(x) )
right outer join ( (x)x)
inner join       ( (x) )
full outer join  (x(x)x)
left anti join   (x( ) )
right anti join  ( ( )x)
full anti join   (x( )x)
-----------------------------------------------
left outer join  (x(x) )
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
left join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
-----------------------------------------------
right outer join ( (x)x)
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
right join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
-----------------------------------------------
inner join       ( (x) )
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
inner join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
-----------------------------------------------
full outer join  (x(x)x)
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
full join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
-----------------------------------------------
left anti join   (x( ) )
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
left join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
where
	nome_subcategoria is null
-----------------------------------------------
right anti join  ( ( )x)
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
right join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
where
	id_produto is null
-----------------------------------------------
full anti join   (x( )x)
select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
full join
	subcategoria on
	produtos.id_subcategoria = subcategoria.id_subcategoria
where
	id_produto is null or
	nome_subcategoria is null
-----------------------------------------------







