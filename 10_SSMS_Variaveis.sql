Inteiro = int
Exemplos:
1, 100, 569
-----------------------------------------------
Decimal = float
Exemplos:
10.33, 90.91, 410.787

Decimal = decimal(n,m)
'n' é a quantidade de digitos que o numeto pode ter, incluindo casas decimais.
'm' é o numero maximo de casas decimais.
Exemplos:
10.33 (4,2), 900.91 (5,2), 410.787 (6,3)
-----------------------------------------------
Texto/String = varchar(n)
'n' é o numero de caracteres que o texto pode ter
Exemplos:
'Carla', 'Motorola', 'Pastel', '44'
-----------------------------------------------
Data = date
Data/hora = datetime
Exemplos:
'01/01/2021', '23/03/2021'
-----------------------------------------------
Visualizando operações

select 10 as 'Numero'
select 'André' as 'Nome'
select '21/06/2011' as 'Data'
select 10+20 as 'Soma'
select 20-5 as 'Subtração'
select 31*40 as 'Multiplicação'
select 431/23 as 'Divisão'   -- resultado com numero inteiro
select 431.0/23 as 'Divisão' -- resultado com numero decimal
select 'André ' + 'Soares' as 'Nome'
-----------------------------------------------
Visualizando o tipo

select sql_variant_property (10, 'basetype')
select sql_variant_property (49.50, 'basetype')
select sql_variant_property ('André', 'basetype')
select sql_variant_property ('20/06/2021', 'basetype')
-----------------------------------------------
Convertendo e visualizando o tipo

select cast (21.45 as int)
select sql_variant_property (cast (21.45 as int), 'basetype')
select cast (21 as float)
select sql_variant_property (cast (21 as float), 'basetype')
select cast (18.7 as varchar)
select sql_variant_property (cast (18.7 as varchar), 'basetype')
select cast ('15.6' as float)
select sql_variant_property (cast ('15.6' as float), 'basetype')
select cast ('20/06/2021' as date)
select sql_variant_property (cast ('20/06/2021' as date), 'basetype')
select cast ('20/06/2021' as datetime)
select sql_variant_property (cast ('20/06/2021' as datetime), 'basetype')

select 'O preço do pastel é R$ ' + cast (30.99 as varchar(50))
select cast ('20/06/2021' as datetime) + 1
-----------------------------------------------
Formatação

select format (1000, 'N')
select format (1000, 'G')
select format (123456789, '###-##-####')
select format (cast ('21/03/2021' as datetime), 'dd/MM/yyy')
select format (cast ('21/03/2021' as datetime), 'dd/MMM/yyy')
select format (cast ('21/03/2021' as datetime), 'dd/MMMMM/yyy')
select format (cast ('21/03/2021' as datetime), 'dd')
select format (cast ('21/03/2021' as datetime), 'ddd')
select format (cast ('21/03/2021' as datetime), 'dddd')
select format (cast ('21/03/2021' as datetime), 'MM')
select format (cast ('21/03/2021' as datetime), 'MMM')
select format (cast ('21/03/2021' as datetime), 'MMMM')

select 'A data de validede do produto é: ' + format ( cast ('17/04/2022' as datetime), 'dd/MMM/yyy')
-----------------------------------------------
Funções de Arredondamento

select round (18.739130, 2)    -- seleciona quantas casas decimais e arredonda de acordo com as regras da matematica
select round (18.739130, 2, 1) -- seleciona quantas casas decimais e ignora as regras da matematica
select floor (18.739130)       -- arredonda para baixo sem casas decimais
select ceiling (18.739130)     -- arredonda para cima sem casas decimais
-----------------------------------------------
Declarando uma variavel

declare @variavel tipo
set @variavel = valor

declare @idade int
set @idade = 30
select @idade as Idade

declare @preco float
set @preco = 10.89
select @preco as Preço

declare @nome varchar (30)
set @nome = 'André'
select @nome as Nome

declare @date date
set @date = '01/02/2024'
select @date as Data

Outra opção simplificada

declare
	@idade int = 10,
	@preco float = 10.89,
	@nome varchar (30) = 'André',
	@data date = '01/02/2024'
select
	@idade as Idade,
	@preco as Preço,
	@nome as Nome,
	@data as Data

declare
	@quantidade int = 100,
	@preco float = 89.99

select @quantidade * @preco as Faturamento

Exemplos

/*
Aplique um desconto de 10% em todos os preços dos produtos.
Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice 
e Preço com Desconto.
*/

declare @desconto float = 0.10

 select
	ProductKey as 'ID',
	ProductName as 'Produto',
	UnitPrice as 'Preço',
	round (UnitPrice * (1 - @desconto), 2) as 'Preço com Desconto',
	round (UnitPrice * @desconto, 2) as 'Valor do Desconto'
from	
	DimProduct

/*
Crie uma variavel de data para melhorar a consulta abaixo.
*/

declare @varData datetime = '01/01/1980'

select 
	FirstName as 'Nome',
	LastName as 'Sobrenome',
	BirthDate as 'Nascimento',
	'Cliente' as 'Tipo'
from	
	DimCustomer
where 
	BirthDate >= @varData

union

select 
	FirstName as 'Nome',
	LastName as 'Sobrenome',
	BirthDate as 'Nascimento',
	'Funcionario' as 'Tipo'
from	
	DimEmployee
where 
	BirthDate >= @varData
order by 
	Nascimento
-----------------------------------------------
Armazenando o resultado de um select em uma variavel

/*
Crie uma variavel para armazenar a quantidade total de
funcionarios da tabela DimEmployee.
*/

declare @qtdfuncionarios int = (select count (*) from DimEmployee)

select @qtdfuncionarios as 'Qtd funcionarios'

/*
Crie uma variavel para armazenar a quantidade total de lojas com o status Off.
*/

declare @lojasoff int = (select count (*) from DimStore where status = 'Off')

select @lojasoff as 'Lojas Off'
-----------------------------------------------
Printando uma mensagem na tela

/*
Printe na tela a quantidade de lojas On e a quantidade  de lojas Off da tabela DimStore.
Utilize variaveis para isso.
*/

set nocount on

declare
	@lojason int = (select count (*) from DimStore where status = 'on'),
	@lojasoff int = (select count (*) from DimStore where status = 'off')

select
	@lojason as 'Lojas On',
	@lojasoff as 'Lojas Off'

print 'O total de lojas abertas é de ' + cast (@lojason as varchar (30))
print 'O total de lojas fechadas é de ' + cast (@lojasoff as varchar (30))
-----------------------------------------------
Armazenando em uma variavel um registro de uma consulta

/*
Qual é o nome do produto que teve a maior quantidade vendida em uma unica venda da tabela FactSales?
*/

declare
	@idprodutomaisvendido int,
	@nomeprodutomaisvendido varchar (100),
	@totalmaisvendido int

select top (1)
	@idprodutomaisvendido = DimProduct.ProductKey,
	@nomeprodutomaisvendido = dimproduct.ProductName,
	@totalmaisvendido = SalesQuantity
from
	FactSales
inner join
	DimProduct on
	DimProduct.ProductKey = FactSales.ProductKey
order by
	SalesQuantity desc

print 'ID do produto: ' + cast (@idprodutomaisvendido as varchar (30))
print 'Nome do Produto: ' + cast (@nomeprodutomaisvendido as varchar (100))
print 'Quantidade de venda: ' + cast (@totalmaisvendido as varchar (30))

select
	ProductKey as 'ID',
	@totalmaisvendido as 'Total vendido',
	ProductName as 'Nome'
from
	DimProduct
where
	ProductKey = @idprodutomaisvendido
-----------------------------------------------

