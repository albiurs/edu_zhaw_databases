/* Lösungen zu DB-Uebung Winestore
Datum: 4.12.2016
Autor: R. Zimmermann
Die Lösungen sind jeweils kritisch zu hinterfragen
-----------------------------------------------------------------------------------------------------------------*/
# 1. Wie viele Kunden sind in der Datenbank registriert?

SHOW DATABASES;
USE winestore;
SHOW TABLES;

select count(*) from customer;
select count(distinct surname, firstname) from customer; # = 553 => ca 100 Kunden haben den gleichen Vor- und Nachnamen
select count(distinct surname, firstname, birth_date) from customer; # = 650 => 4 Kunden heissen gleich und haben auch noch den gleichen Geburtstag


# 1a. Sind Kunden doppelt eingetragen?
SELECT surname,firstname,birth_date, address,count(*)
FROM customer
group by surname,firstname,birth_date
having count(*) > 1
order by surname,firstname;

SELECT * FROM customer WHERE surname = 'Kinsala' AND firstname = 'Rochelle';


# 1b. Wie viele Kunden haben eine Bestellung ?
SELECT count(distinct cust_id) from orders;


# 1c. Liste der Kunden die keine Bestellung haben
select count(*) from
(SELECT cust_id, surname, firstname from customer
left join orders using (cust_id)
where orders.cust_id is null) dt;

select cust_id, surname, firstname from customer where cust_id not in (select cust_id from orders);


# 1d. Integrität/Konsistenz der Beziehung orders-items prüfen:
select * from orders right join items using(cust_id,order_id)
where orders.date is null;

select * from orders right join items using(cust_id,order_id)
where orders.cust_id is null and order_id is null;

select * from orders right join items using(cust_id, order_id);


# 1e. Integrität/Konsistenz der Tabellen customer-orders prüfen
select * from orders where cust_id in (select cust_id from customer);

select *
from items
left join orders using(cust_id,order_id)
WHERE date IS NULL ;
# => DB ist inkonsistent!!!


# 2. Gibt es überhaupt unvollständige Kundendatensätze?
select * from customer
WHERE surname is null
 OR firstname is null
 OR address is null
 OR city is null
 OR birth_date is null;


# 2a. Kontrollieren Sie die MussFelder (Not NULL) auf der Tabelle customer - Sinnvoll?



# 3. Wie viele (verschiedene ?!) Weine sind eingetragen
SELECT count(*) FROM wine;

select count(distinct wine_id, wine_name, wine_type_id, year, winery_id) from wine;
select count(distinct wine_name, wine_type_id, year, wine_id) from wine;
select count(distinct wine_name, wine_type_id, year) from wine;
select count(distinct wine_name, wine_type_id) from wine;



# 3a. Wie viele verschiedene Weine sind eingetragen, wenn nicht der Jahrgang aber der Weintyp als Unterschied gelten?
select count(distinct wine_name,wine_type_id, year) from wine;


# 3b. Wie viele verschiedene Weinnamen sind überhaupt eingetragen?
select count(distinct wine_name) from wine;


# 3b. Wie viele verschiedene Weine sind eingetragen, wenn Name, Jahrgang und der Weintyp als Unterschied gelten ?
select count(distinct wine_name,wine_type_id,year) from wine;


# 4. Wieviele verschiedene Weinnamen sind erfasst?
select count(distinct wine_name) from wine;


# 4a. Zählen Sie die Anzahl der Weine pro Weinnamen - was fällt auf? - warum ist das so?
SELECT count(wine_name), wine_name FROM wine
GROUP BY wine_name;


# 4b. Doubletten suchen
select *, count(*) bb from wine group by wine_name, wine_type_id, year, winery_id
having bb > 1;

select * from wine where wine_id = 339;
select * from wine where wine_name = 'mockridge' and wine_type_id = 5 and year = 1971 and winery_id = 97;

select * from wine_variety join grape_variety using(variety_id)
where wine_id = 339 or wine_id = 342;


# 5. Wie viele verschiedene Weine gibt es von jedem Weintyp?

# 5a. Erstellen Sie hier eine Auswertung GROUP BY mit ROLLUP
SELECT wine_name, wine_type, count(*)
FROM wine join wine_type using (wine_type_id)
GROUP BY wine_name, wine_type with rollup;

SELECT wine_name, wine_type, year, winery_id, count(*)
FROM wine join wine_type using (wine_type_id)
GROUP BY wine_name, wine_type, year, winery_id with rollup;


# 6. Von welchem Weintyp gibt es am meisten verschiedene Weine?
select wine_type, count(wine_type_id) from wine join wine_type using(wine_type_id)
GROUP BY wine_type_id
having count(wine_type_id) =
(select max(maxtyp) from
(select count(wine_id) as maxtyp from wine
GROUP BY wine_type_id) as dummytable);


# 7. Wie viele Weinflaschen sind total am Lager?
select sum(on_hand) from inventory;


# 7a. Sind alle erfassten Weine am Lager
select wine_id, wine_name, year, inventory_id, on_hand from wine left
join inventory using (wine_id)
where inventory.wine_id is null or on_hand <= 0;


# 7b. Liste Anzahl Weinflaschen pro Region am Lager?
select  region_name, sum(on_hand) as soh from wine
join winery using (winery_id)
join region using (region_id)
join inventory using (wine_id)
group by region_id
order by soh desc;


# 7c. Liste der wineries mit der zugehörigen Region
SELECT winery_name, region_name from winery
join region using(region_id);


# 7d. Liste der Regionen mit der Anzahl zugehöriger Wineries
SELECT region_name, count(winery_id) 'Anzahl wineries'  from winery
join region using(region_id)
group by region_id;


# 7e. In welcher Region liegen die meisten Wineries?
SELECT region_name, count(winery_id) cw from winery
join region using(region_id)
group by region_id
having cw =
(select max(cw) from
(select count(winery_id) cw from winery
group by region_id) dt);


# 8. Wie gross ist der Lagerwert zu Einstandspreisen der Weine?
select sum(on_hand * cost) from inventory;

# Aufgabe: Was kostet der billigste Wein im Einkauf?

select min(cost) from inventory;  -- select min(cost/on_hand) from inventory;

# Aufgabe: Was kostet der teuerste Wein im Einkauf?

select max(cost) from inventory;

# Aufgabe: Was ist der durchschnittliche Einkaufspreis pro Flasche?

select avg(cost) from inventory;


# 9. In welchem Land wohnen die meisten Kunden?
select country, count(customer.country_id) from customer
join countries using(country_id)
group by country_id
having count(customer.country_id) =
(select max(maxc) from
(select count(*) as maxc from customer
GROUP BY country_id) as dtable);


# 10. Wie viele Bestellungen hat der oder die Kunden mit den meisten Bestellungen ?
select max(a) from
(SELECT count(cust_id) as a FROM  orders
 GROUP BY cust_id) as dummy;


# 11. Liste des/der Kunden mit der höchsten Anzahl Bestellungen geordnet nach sur- und firstname !
SELECT surname, firstname ,count(*)
FROM customer inner join orders using (cust_id)
GROUP BY cust_id
having count(cust_id) =
(select max(a) from
(SELECT count(cust_id) as a
FROM  orders
GROUP BY cust_id) as dtbl)
order by surname, firstname;


# 12. Liste der Weine, die in keiner Bestellung vorkommen

select * from wine left join items using(wine_id) where items.wine_id is null;

select wine_id, wine_name,year from wine
where wine_id not in
(select wine_id from items);


# 13. Liste der Marge (Differenz zwischen Einstands- und Verkaufspreis) der bestellten Weine pro Verkaufsposition

SELECT wine_id, wine_name,wine_type_id,year,(price-cost) Marge
FROM items i
join inventory using(wine_id)
join wine using (wine_id)
order by Marge desc;


# 13a. Wo tauchen hier Fragen auf? Wie kontrollieren wir das ?
# 13b. Sind alle Margen positiv ?
# 13c. Ist dieser Weinhändler ein guter Geschäftsmann ?

# 13d. Wie gross ist die Gesamtmarge overall?

SELECT sum(qty*(price-cost)) / sum(cost*qty) TotalMarge
FROM items
join inventory using(wine_id);

# 14. Liste der Kunden mit dem Totalbetrag aller Bestellungen eines Kunden

select cust_id,surname,firstname, sum(qty*price) as bw
from customer join items using (cust_id)
group by cust_id
order by bw desc;

# mit Marge pro Kunde:

select cust_id,surname,firstname,
sum(qty*price) as Bestellwert,
sum(qty*(price-cost)) as Marge
from customer join items using (cust_id)
join inventory using (wine_id)
group by cust_id
order by Marge desc;

# Kontrolle eines Kunden:

select  cust_id,order_id,item_id, qty*(price-cost), sum(qty*(price-cost))
from customer join items using (cust_id)
join inventory using (wine_id)
where cust_id = 200
group by cust_id,order_id,item_id with rollup;

# 15. Wie hoch ist die Summe der Bestellung des Kunden, der wertmässig am meisten bestellt hat?

select max(sumkunde) from
(select  sum(qty*price) as sumkunde
from items
group by cust_id) as dummy;

# 16. Welcher Kunde hat diese grösste Bestellsumme?

select cust_id, firstname, surname, sum(qty*price) as msumme
from customer join items using(cust_id)
group by cust_id
having msumme =
(select max(sumkunde) from
(select  sum(qty*price) as sumkunde
from items
group by cust_id) as dummy);

# 17. Aus welcher Region kommen die meisten Weine?

select region_id, region_name
from wine join winery using (winery_id)
join region using (region_id)
group by region_id having count(region_id) =
(select max(aw) from
(select count(region_id) as aw
from wine join winery using (winery_id)
join region using (region_id)
group by region_id
order by aw desc) as tab);

# 18. Aus welchen Trauben sind die jeweiligen Weine zusammengesetzt?

select wine_id, wine_name, variety from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
order by wine_id;

# Liste mit group_concat

select wine_id, wine_name, group_concat(variety separator ' & ' ) as variety
from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id
order by wine_id;

# 18a. Welcher Wein ist «verschnitten» und welcher nicht?

SELECT wine_id, wine_name, year, winery_id, wine_type from wine
join wine_type using(wine_type_id)
join wine_variety using(wine_id)
group by wine_id
having count(variety_id) = 1;

# 19. Sind alle varieties "im Einsatz"?

select * from grape_variety
where variety_id not in
(select variety_id from wine_variety);

# ja sie sind - und wine_variety ist konsistent zu wine?

select * from wine_variety
where wine_id not in
(select wine_id from wine);

# ja die Beziehung ist konsistent

# 20. Aus wie vielen grape_varieties besteht der Wein, der am "meisten" verschnitten ist?

select max(cv) from
(select wine_id, wine_name, count(variety) as cv from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id
order by cv desc) as tab;

# 20a. Welcher/welche Wein/e ist/sind das ?

select wine_id, wine_name, year, winery_id, count(variety_id) as cv from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id
having count(variety_id) =
(select max(cv) from
(select count(variety) as cv from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id) as tab);


# 20b. Wie viele Weine sind in 20a. betroffen?

select count(*) from
(select wine_id, wine_name, count(variety_id) as cv from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id
having count(variety_id) =
(select max(cv) from
(select wine_id, wine_name, count(variety) as cv from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by wine_id
order by cv desc) as tab)) as tab1;

# 21. Welche grape_ variety ist über alle Weine am meisten beteiligt?

select variety, count(variety_id) as vc from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by variety_id
having count(variety_id) =
(select max(vc) from
(select variety, count(variety_id) as vc from wine
join wine_variety using (wine_id)
join grape_variety using (variety_id)
group by variety_id) as tab);

# 22. Welcher Kunde hat den höchsten durchschnittlichen Preis/Flasche in all seinen Bestellpositionen?

select cust_id, surname, firstname , sum(price)/sum(qty) as mmm
from customer join items using (cust_id)
group by cust_id having mmm =
(select max(mmm) from
(select cust_id, sum(price)/sum(qty) as mmm
from customer join items using (cust_id)
group by cust_id) as dtable);

# 23.Zeige alle Kunden mit mindestens einer „Nullmargenposition“

select distinct cust_id,surname,firstname,(price-cost) as Marge
from customer join items using (cust_id)join inventory using (wine_id)
where price-cost = 0
order by cust_id;

# 24. Welche Kunden haben keine “Nullmargenposition”?

Select * from customer where cust_id not in
(select distinct cust_id
from customer join items using (cust_id)join inventory using (wine_id)
where price-cost = 0);

# 25. Zeige alle Kunden mit jeweils allen „Nullmargenpositionen“ in allen Bestellungen mit Angabe von order_id und item_id

select cust_id, surname, firstname, order_id, item_id, (price-cost) as Marge
from customer join items using (cust_id)
join inventory using (wine_id)
where price-cost = 0
order by cust_id, order_id, item_id;