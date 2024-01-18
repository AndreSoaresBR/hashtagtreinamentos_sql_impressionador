select
	sum(SalesQuantity) as 'Total vendido',
	sum(ReturnQuantity) as 'Total devolvido'
from 
	factsales
-----------------------------------------------
select
	count(*) as 'Qtd de linhas',
	count(Weight) as 'Qtd de produtos com peso', -- não soma os null
	count(distinct ColorName) as 'Qtd de cores distintas',
	count(distinct BrandName) as 'Qtd de fornecedores distintos'
from 
	DimProduct
-----------------------------------------------
select
	max(UnitPrice) as 'Preço maximo',
	min(unitprice) as 'Preço minimo',
	avg(unitprice) as 'Preço medio'
from 
	DimProduct
-----------------------------------------------

/*
1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais
importante da empresa: Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. 
Obs: Faça essa análise considerando a tabela FactSales.
*/

select
	sum(SalesQuantity) as 'Qtd vendida',
	sum(ReturnQuantity) as 'Qtd devolvida'
from 
	FactSales
where
	channelKey = 1

/*
2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa,
mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse resultado.
*/

select
	AVG(YearlyIncome) as 'Media salarial'
from 
	DimCustomer
where
	Occupation = 'Professional'

/*
3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa.
O seu gerente te pediu os seguintes números e informações:
a) Quantos funcionários tem a loja com mais funcionários?
b) Qual é o nome dessa loja?
c) Quantos funcionários tem a loja com menos funcionários?
d) Qual é o nome dessa loja?
*/

A) B)
select * from DimStore
order by EmployeeCount desc

C) D)
select * from DimStore
order by EmployeeCount

/*
4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários
do sexo Masculino e do sexo Feminino.
a) Descubra essas duas informações utilizando o SQL.
b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.
*/

A)
select
	count (FirstName)
from 
	DimEmployee
where 
	Gender = 'M' -- ou 'F' para feminino

B)
select top (1)
	FirstName as 'Nome',
	EmailAddress as 'Email',
	StartDate as 'Data de contratação',
	Gender as 'Genero'
from
	DimEmployee
where 
	Gender = 'M' -- ou 'F' para feminino
order by
	StartDate

/*
5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações:
a) Quantidade distinta de cores de produtos.
b) Quantidade distinta de marcas
c) Quantidade distinta de classes de produto
Para simplificar, você pode fazer isso em uma mesma consulta.
*/

A) B) C)
select
	count(distinct ColorName) as 'Cores',
	count(distinct BrandName) as 'Marcas',
	count(distinct ClassName) as 'Classe de produtos'
from
	DimProduct
