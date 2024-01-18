select
	BrandName as 'Nome da marca',
	count(*) as 'Qtd total'
from	
	DimProduct
group by
	BrandName
-----------------------------------------------
select
	storetype,
	sum(EmployeeCount)
from
	DimStore
group by
	StoreType
-----------------------------------------------
select
	BrandName,
	AVG(UnitCost)
from
	DimProduct
group by
	BrandName
-----------------------------------------------
select
	ClassName,
	max(UnitPrice) as 'Preço maximo',
	min(UnitPrice) as 'Preço minimo',
	AVG(UnitPrice) as 'Preço medio'
from
	DimProduct
group by
	ClassName
-----------------------------------------------
select
	StoreType,
	sum(EmployeeCount)
from
	DimStore
group by
	StoreType
order by
	sum(EmployeeCount)
-----------------------------------------------
select
	ColorName as 'Cor do produto',
	count(*) as 'Total de produto'
from
	DimProduct
where
	BrandName = 'Contoso'
group by
	ColorName
order by
	count(*)
-----------------------------------------------
select
	BrandName as 'Marca',
	count(BrandName) as 'Total por marca'
from
	DimProduct
group by
	BrandName
having
	count(BrandName) >= 200
-----------------------------------------------
select
	BrandName as 'Marca',
	count(BrandName) as 'Total por marca'
from
	DimProduct
where
	ClassName = 'Economy'
group by
	BrandName
having
	count(BrandName) >= 200
-----------------------------------------------

/*
1. 
a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey).
b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida
(Return Quantity) de acordo com o ID das lojas (StoreKey).
c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.
*/

A)
select
	channelkey as 'Canal de venda',
	sum(SalesQuantity) as 'Total vendida'
from
	factsales
group by
	channelKey

B)
select
	StoreKey as 'ID da loja',
	sum(SalesQuantity) as 'Total vendida',
	sum(ReturnQuantity) as 'Total devolvida'
from
	factsales
group by
	StoreKey
order by
	StoreKey

C)
select
	channelKey as 'Canal de venda',
	sum(SalesAmount) as 'Faturamento total'
from
	factsales
where
	DateKey between '20070101' and '20071231'
group by
	channelKey

/*
2. Você precisa fazer uma análise de vendas por produtos.
O objetivo final é descobrir o valor total vendido (SalesAmount) por produto (ProductKey).
a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso,
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000.
b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas.
Desconsidere o filtro de $5.000.000 aplicado.
*/

A) B)
select top (10)
	ProductKey as 'Produto',
	sum(SalesAmount) as 'Total vendido'
from
	factsales
group by
	ProductKey
having
	sum(salesamount) >= 5000000
order by
	sum(SalesAmount) desc

/*
3. 
a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente
que mais realizou compras online (de acordo com a coluna SalesQuantity).
b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais
foram os top 3 produtos mais comprados pelo cliente da letra a).
*/

A)
select
	CustomerKey as 'Id cliente',
	sum(SalesQuantity) as 'Qtd de compra'
from
	FactOnlineSales
group by
	CustomerKey
order by
	sum(SalesQuantity) desc

B)
select top (3)
	ProductKey as 'Id produto',
	sum(SalesQuantity) as 'Qtd de compra'
from
	FactOnlineSales
where
	CustomerKey = 19037
group by
	ProductKey
order by
	sum(SalesQuantity) desc

/*
4. 
a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.
*/

A)
select 
	BrandName as 'Marca',
	count(ProductName) as 'Qtd produto'
from 
	DimProduct
group by
	BrandName

B)
select 
	ClassName as 'Classe do produto',
	avg(UnitPrice) as 'Media de preço'
from 
	DimProduct
group by
	ClassName

C)
select
	ColorName as 'Cor',
	sum(weight) as 'Peso'
from 
	DimProduct
group by
	ColorName
order by
	sum(weight)

/*
5. Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em
ordem decrescente.
*/

select
	StockTypeName,
	sum(Weight) as 'Peso total'
from 
	DimProduct
where
	BrandName = 'Contoso'
group by
	StockTypeName
order by
	sum(Weight) desc

/*
6. Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores?
*/

select
	BrandName as 'Marca',
	count(distinct ColorName) as 'Qtd cores'
from
	DimProduct
group by
	BrandName

/*
7. Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média
salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus
conhecimentos em SQL.
*/

select
	Gender as 'Genero',
	count(Gender) as 'Qtd por genero',
	avg(YearlyIncome) as 'Media salarial'
from
	DimCustomer
where
	Gender is not null
group by
	Gender

/*
8. Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de
acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer
esse agrupamento.
*/

select
	Education as 'Nivel escolar',
	count(Education) as 'Qtd total',
	avg(YearlyIncome) as 'Media salarial'
from
	DimCustomer
where
	Education is not null
group by
	Education

/*
9. Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o
Departamento (DepartmentName). Importante: Você deverá considerar apenas os
funcionários ativos.
*/

select
	DepartmentName as 'Departamento',
	count(DepartmentName) as 'Qtd total'
from
	DimEmployee
where
	Status is not null
group by
	DepartmentName
order by
	count(DepartmentName)

/*
10. Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você
deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.
*/

select
	Title as 'Cargo',
	sum(VacationHours) as 'Qtd horas'
from
	DimEmployee
where
	Gender = 'F'and
	DepartmentName in ('Production', 'Marketing', 'Engineering', 'Finance') and
	StartDate between '19990101' and '20001231'
group by
	Title
