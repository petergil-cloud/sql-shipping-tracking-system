-- Used to query whole main datasets, to quick inspect data accuracy

SELECT `Numer przesyłki`, `Numer telefonu`, `Data utworzenia`, Kierunek, `Typ przesyłki`, `Sposób dostawy`, Rozmiar, Odbiorca, `Punkt odbiorczy`, `Imię i nazwisko`, `Nazwa firmy`, `Kod pocztowy`, Miejscowość, Ulica, `Status przesyłki`, `Data ostatniej zmiany statusu`, `Numer referencyjny`, `Wartość pobrania`, `Dodatkowa ochrona`, `Paczka w Weekend`
FROM gaja_sales_2026.przesylki;

SELECT `L.p.`, `Imię, nazwisko / nazwa firmy`, `E-mail wpłacającego`, Kanał, `Dane transakcji`, `Tytuł/komentarz`, `Data realizacji`, Uwagi, `Dane płatności`, Waluta, `Łączna wpłata`, `Kwota za ofertę`, `Ilość opłaconych sztuk oferty`, `Dodatkowa darowizna na Twoją zrzutkę przy wpłacie za ofertę`, `Oferta/licytacja`, `Adres wpłacającego`, `Dodatkowe informacje`, `Telefon wpłacającego`
FROM gaja_sales_2026.zestawienie_wplat;

select 
`Imię i nazwisko`
,`Data utworzenia`
,`Status przesyłki`
from przesylki

SELECT 
`Imię, nazwisko / nazwa firmy`
,`E-mail wpłacającego`
from zestawienie_wplat


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


select
	sum(zw.`Łączna wpłata`)
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








 




	

