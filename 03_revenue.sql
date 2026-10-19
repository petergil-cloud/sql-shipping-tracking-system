-- Used to count revenue per order category and total revenue

select
	sum(zw.`Łączna wpłata`)		as revenue_per_category
	,case
		when zw.`Oferta/licytacja` like 'Płyta CD z autografami%' 
		then 'Autografy'
		when zw.`Oferta/licytacja` like 'Śpiewnik + wysyłka%' 
		then 'Śpiewnik'
		when zw.`Oferta/licytacja` like 'Płyta CD + wysyłka%' 
		then 'CD'
		when zw.`Oferta/licytacja` like 'Płyta CD + śpiewnik + wysyłka%' 
		then 'Płyta + śpiewnik'
	end as product_name
from zestawienie_wplat zw
group by 2
order by 1 desc

select
	sum(zw.`Łączna wpłata`) 	as total_revenue
from zestawienie_wplat zw








 




	

