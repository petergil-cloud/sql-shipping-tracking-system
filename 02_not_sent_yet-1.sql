-- Used to inspect orders that haven't been sent yet

with
not_delivered as
	(
	select 
		*
	from zestawienie_wplat zw
	left join przesylki p
	on p.Odbiorca  = zw.`E-mail wpłacającego` 
	order by zw.`Data realizacji`)
select 
	nd.`Imię, nazwisko / nazwa firmy`
	,nd.`E-mail wpłacającego` 
	,case
		when nd.`Oferta/licytacja` like 'Płyta CD z autografami%' 
		then 'Autografy'
		when nd.`Oferta/licytacja` like 'Śpiewnik + wysyłka%' 
		then 'Śpiewnik'
		when nd.`Oferta/licytacja` like 'Płyta CD + wysyłka%' 
		then 'CD'
		when nd.`Oferta/licytacja` like 'Płyta CD + śpiewnik + wysyłka%' 
		then 'Płyta + śpiewnik'
	end as product_name
	,mc.my_comment 
	,nd.`Status przesyłki`
	,nd.`Data realizacji` 
	,nd.`Łączna wpłata` 
	,nd.`Adres wpłacającego`
	,nd.`Dodatkowe informacje`
from not_delivered nd
left join email_tracking et
on et.email_address = nd.`E-mail wpłacającego`
left join my_comments mc
on nd.`E-mail wpłacającego` = mc.email_address
where nd.`Status przesyłki` is null

select
	*
from my_comments mc
right join zestawienie_wplat zw 
on mc.email_address = zw.`E-mail wpłacającego`
left join przesylki p
on zw.`E-mail wpłacającego` = p.Odbiorca
where p.`Status przesyłki` is null
order by `Data realizacji` desc








 




	

