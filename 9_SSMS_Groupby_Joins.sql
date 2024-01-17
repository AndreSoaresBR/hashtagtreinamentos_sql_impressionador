/*1.
a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do
canal de vendas (ChannelName). Você deve ordenar a tabela final de acordo com 
SalesQuantity, em ordem decrescente.
b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) 
e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
c) Faça um resumo do valor total vendido (Sales Amount) para cada mês (CalendarMonthLabel)
e ano (CalendarYear).
*/

A)
select
	sum(SalesQuantity) as 'Qtd vendida',
	ChannelName
from
	FactSales
inner join
	DimChannel on
	FactSales.channelKey = DimChannel.ChannelKey
group by
	ChannelName
order by
	sum(SalesQuantity) desc

B)
select
	sum(SalesQuantity) as 'Qtd vendida',
	sum(ReturnQuantity) as 'Qtd devolvida',
	DimStore.Storename
from
	FactSales
inner join
	DimStore on
	FactSales.StoreKey = DimStore.StoreKey
group by
	DimStore.Storename

C)
select
	CalendarYear as 'Ano',
	CalendarMonthLabel as 'Mes',
	sum(SalesAmount) as 'Qtd faturado'
from
	FactSales
inner join
	DimDate on
	FactSales.DateKey = DimDate.Datekey
group by
	CalendarYear,
	CalendarMonthLabel,
	CalendarMonth
order by
	CalendarMonth

/*
2. Você precisa fazer uma análise de vendas por produtos.
O objetivo final é descobrir o valor total vendido (SalesAmount) por produto.
a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
*/

A) B)
select
	Colorname as 'Cor',
	sum(SalesQuantity) as 'Qtd vendido'
from
	FactSales
inner join
	DimProduct on
	FactSales.ProductKey = DimProduct.ProductKey
group by
	Colorname
having
	sum(SalesQuantity) >= 3000000
order by
	sum(SalesQuantity) desc

/*
3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto 
(ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN,
dado que a relação entre FactSales e DimProductCategory não é direta.
*/

select
	ProductCategoryName as 'Categoria do produto',
	sum(SalesQuantity) as 'Qtd vendido'
from
	FactSales
inner join
	DimProduct on
	FactSales.ProductKey = DimProduct.ProductKey
inner join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
inner join
	DimProductCategory on
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
group by
	ProductCategoryName

/*
4.
a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo do cliente
que mais realizou compras online (de acordo com a coluna SalesQuantity).
b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados
pelo cliente da letra a, considerando o nome do produto.
*/

A)
select
	dimcustomer.CustomerKey as 'id',
	firstname as 'nome',
	lastname as 'sobrenome',
	sum(salesquantity) as 'Qtd vendida'
from
	FactOnlineSales
inner join
	DimCustomer on
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
where
	CustomerType = 'person'
group by
	dimcustomer.CustomerKey,
	FirstName,
	LastName
order by
	sum(salesquantity) desc

B)
select top (10)
	FactOnlineSales.CustomerKey as 'id',
	ProductName as 'Produto',
	sum(salesquantity) as 'Qtd vendida'
from
	FactOnlineSales
inner join
	DimProduct on
	FactOnlineSales.ProductKey = DimProduct.ProductKey
where
	CustomerKey = 7665
group by
	FactOnlineSales.CustomerKey,
	ProductName
order by
	sum(salesquantity) desc

/*
5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
*/

select
	Gender as 'Genero',
	sum(salesquantity) as 'Qtd vendida'
from
	FactOnlineSales
inner join
	DimCustomer on
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
where
	Gender is not null
group by
	Gender

/*
6. Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada CurrencyDescription.
A tabela final deve conter apenas taxas entre 10 e 100.
*/

select
	currencydescription,
	avg(AverageRate) as 'Taxa media'
from
	FactExchangeRate
inner join
	DimCurrency on
	FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
group by
	currencydescription
having
	avg(AverageRate) between 10 and 100
order by
	avg(AverageRate)

/*
7. Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos
cenários: Actual e Budget.
*/

select
	ScenarioName,
	sum(amount) as 'Total'
from
	FactStrategyPlan
inner join
	DimScenario on
	FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
where
	ScenarioName in ('Actual', 'Budget')
group by
	ScenarioName

/*
8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.
*/

select
	CalendarYear as 'Ano',
	sum(Amount) as 'Total'
from
	FactStrategyPlan
inner join
	DimDate on
	FactStrategyPlan.Datekey = DimDate.Datekey
group by
	CalendarYear

/*
9. Faça um agrupamento de quantidade de produtos por ProductSubcategoryName.
Leve em consideração em sua análise apenas a marca Contoso e a cor Silver.
*/

select
	ProductSubcategoryName as 'Subcategoria',
	count(*) as 'Qtd produtos'
from
	DimProductSubcategory
inner join
	DimProduct on
	DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
where
	BrandName = 'Contoso' and
	ColorName = 'Silver'	
group by
	ProductSubcategoryName

/*
10. Faça um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName.
A tabela final deverá ser ordenada de acordo com a coluna BrandName.
*/

select
	BrandName as 'Marca',
	ProductSubcategoryName as 'Subcategoria',
	count(*) as 'Qtd produto'
from
	DimProduct
inner join
	DimProductSubcategory on
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
group by
	BrandName,
	ProductSubcategoryName
order by
	BrandName