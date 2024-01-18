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
select sql_variant_property(10, 'BaseType')
select sql_variant_property(49.50, 'BaseType')
select sql_variant_property('Marcus', 'BaseType')
select sql_variant_property('20/06/2021', 'BaseType')
-----------------------------------------------
Convertendo o tipo
select cast (21.5 as int)
select cast (21.45 as float)
select cast (18.7 as varchar)
select cast ('15.6' as float)
select cast ('20/06/2021' as datetime)
select sql_variant_property (cast ('20/06/2021' as datetime), 'basetype')
select 'O preço do pastel é R$ ' + cast (30.99 as varchar(50))
select cast ('20/06/2021' as datetime) + 1
-----------------------------------------------

