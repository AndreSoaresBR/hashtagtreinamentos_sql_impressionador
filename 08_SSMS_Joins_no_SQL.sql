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
Cross Join
select
	marca,
	nome_subcategoria
from
	marcas cross join subcategoria
-----------------------------------------------
Multi Join
select
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName,
	ProductCategoryName
from
	DimProduct
inner join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
inner join
	DimProductCategory on
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
-----------------------------------------------
UNION
select * from DimCustomer
where
	Gender = 'F'
union
select * from DimCustomer
where
	Gender = 'M'
-----------------------------------------------
UNION ALL
select
	FirstName,
	BirthDate
from 
	DimCustomer
where
	Gender = 'F'
union all -- soma todas as linhas, se for 'union' ele remove as duplicadas
select
	FirstName,
	BirthDate
from
	DimCustomer
where
	Gender = 'M'
-----------------------------------------------

/*
1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory
para a tabela DimProduct.
*/

select
	ProductKey,
	ProductName,
	ProductSubcategoryName
from 
	DimProduct
 inner join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

/*
2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory.
Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory.
Utilize o LEFT JOIN.
*/

select
	ProductSubcategoryName,
	ProductCategoryName
from
	DimProductSubcategory
left join
	DimProductCategory on
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

/*
3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography).
Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName.
Utilize o LEFT JOIN neste exercício.
*/

select
	StoreKey,
	StoreName,
	EmployeeCount,
	DimGeography.ContinentName,
	DimGeography.RegionCountryName
from
	DimStore
left join
	DimGeography on
	DimStore.GeographyKey = DimGeography.GeographyKey
order by
	StoreKey

/*
4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription.
Utilize o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.
*/

select
	ProductKey as 'Id produto',
	ProductName as 'Nome produto',
	ProductDescription as 'Descrição',
	ProductSubcategoryName as 'Subcategoria',
	ProductCategoryDescription as 'Descrição da categoria'
from
	DimProduct
left join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
left join
	DimProductCategory on
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

/*
5. A tabela FactStrategyPlan resume o planejamento estratégico da empresa.
Cada linha representa um montante destinado a uma determinada AccountKey.
a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.
b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan.
O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• AccountName
• Amount
*/

A)
select top (100) * from FactStrategyPlan

B)
select top (100)
	StrategyPlanKey,
	Datekey,
	DimAccount.AccountName,
	Amount
from
	FactStrategyPlan
inner join
	DimAccount on
	FactStrategyPlan.AccountKey = DimAccount.AccountKey

/*
6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que
identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna
possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão.
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey
da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• ScenarioName
• Amount
*/

select
	StrategyPlanKey,
	Datekey,
	ScenarioName,
	Amount
from
	FactStrategyPlan
inner join
	DimScenario on
	FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

/*
7. Algumas subcategorias não possuem nenhum exemplar de produto.
Identifique que subcategorias são essas.
*/

select
	ProductName,
	ProductSubcategoryName
from
	DimProduct
right join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
where
	ProductName is null

/*
8. A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso,
Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado.
*/

select distinct
	BrandName,
	ChannelName
from
	DimProduct cross join DimChannel
where
	BrandName in ('Contoso', 'Fabrikam', 'Litware')

/*
9. Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion.
Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse
relacionamento.
Retorne uma tabela contendo as seguintes colunas:
• OnlineSalesKey
• DateKey
• PromotionName
• SalesAmount
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com
desconto (PromotionName <> ‘No Discount’). Além disso, você deverá ordenar essa tabela de
acordo com a coluna DateKey, em ordem crescente.
*/

select top (1000)
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
from
	FactOnlineSales
inner join
	DimPromotion on
	FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
where
	PromotionName <> 'No Discount'
order by
	DateKey

/*
10. A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct.
Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.
*/

select top (1000)
	SalesKey,
	ChannelName,
	StoreName,
	ProductName,
	SalesAmount
from
	FactSales
left join
	DimChannel on
	FactSales.channelKey = DimChannel.ChannelKey
left join
	DimStore on
	FactSales.StoreKey = DimStore.StoreKey
left join
	DimProduct on
	FactSales.ProductKey = DimProduct.ProductKey
order by
	SalesAmount desc
