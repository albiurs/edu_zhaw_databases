/* Aufgaben und Lösungen zur DB Flughafen klein
Fach: Datenbanken Grundlagen
Autor: R. Zimmermann
Datum: 25.11.2016
Lösungen bitte immer kritisch hinterfragen !!
----------------------------------------------------------------------------------------------------------------*/

# Wieviele Boeing 737 sind im Einsatz?

select count(distinct flugzeug_id,typ_id) from flugzeug join flugzeug_typ using (typ_id)
where bezeichnung like '%737%' and bezeichnung like 'boeing%';

# Wieviel Flüge mit einer Boeing 737 sind durchgeführt worden?

select count(*) from flug join flugzeug using(flugzeug_id)
where typ_id =
(select typ_id from flugzeug_typ where bezeichnung like '%737%'and bezeichnung like 'boeing%');

# Wieviele Buchungen/Flugpassagiere sind auf allen Boeing 737 Flügen getätigt worden?

select count(*) from flug join flugzeug using(flugzeug_id)
join buchung using (flug_id)
where typ_id =
(select typ_id from flugzeug_typ where bezeichnung like '%737%'and bezeichnung like 'boeing%');

# Wieviele Flugzeuge hat jede Fluggesellschaft?

select firmenname,iata, count(*) 'Anzahl Flugzeuge' from fluglinie join flugzeug
using (fluglinie_id)
group by fluglinie_id
order by count(*) desc;

# Sind Flüge überbucht worden?

select flug_id, count(*) Buchungen, kapazitaet from flug f1
join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id
having buchungen < kapazitaet;

#Welcher Flug hat die höchste Sitzauslastung?

select flug_id,
count(*) Buchungen, kapazitaet from flug fl1 join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id
having kapazitaet - buchungen =
(select min(ob) from
(select kapazitaet - count(*) ob from flug fl1 join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id) as dummy);

# Wie hoch ist die Sitzauslastung pro Flug?

select flug_id,(100 / kapazitaet * count(*)) ob from flug fl1 join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id
order by ob desc;

# Wie hoch ist die durchschnittliche Sitzauslastung

select avg(ob) from
(select (100 / kapazitaet * count(*)) ob from flug fl1 join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id) dummy;


# Unterscheiden sich die Flugzeugtypen durch eine unterschiedliche (Sitz-)Kapazität ?

select * from flugzeug f1 join flugzeug f2 using (typ_id)
where f1.kapazitaet <> f2.kapazitaet;

# Gibt es Fluglinien, die mehrere Flugzeuge gleichen Typs haben? Liste?

select fluglinie_id, typ_id, count(*) from flugzeug group by fluglinie_id, typ_id;
#oder vollständige Liste
select fluglinie_id, firmenname, typ_id, bezeichnung, count(*) from flugzeug
join flugzeug_typ using (typ_id)
join fluglinie using (fluglinie_id)
group by fluglinie_id, typ_id;

#Werden alle Flugzeuge von Fluglinien eingesetzt?

select * from flugzeug left join fluglinie using(fluglinie_id) where fluglinie.fluglinie_id is null;

# Wie viele Flugzeugtypen gibt es?

select count(*) from flugzeug_typ;

#Sind alle Flugzeugtypen in Gebrauch?

select typ_id from flugzeug_typ where typ_id not in (select typ_id from flugzeug);

#Wie viele Typen sind nicht in Gebrauch?

select count(*) from
(select typ_id from flugzeug_typ where typ_id not in (select typ_id from flugzeug)) dummy;

# Welches ist der meist eingesetzte (gekaufte) Flugzeugtyp

select typ_id, bezeichnung from flugzeug join flugzeug_typ using (typ_id)
group by typ_id
having count(*) =
(select max(cc) from
(select count(*) cc from flugzeug join flugzeug_typ using (typ_id)
group by typ_id) dummy);

# Welcher Passagier hat die meisten Flugstunden?

select passagier_id, nachname from buchung
join passagier using (passagier_id)
join flug using(flug_id)
group by passagier_id
having sum((to_seconds(ankunft) - to_seconds(abflug))/3600) =
(select max(flugzeit) from
(select sum((to_seconds(ankunft) - to_seconds(abflug))/3600) flugzeit from buchung
join flug using(flug_id)
group by passagier_id) dummy);

# Kopie von Welcher Passagier hat die meisten Flugstunden? ist noch zu klären !!

select passagier_id, nachname,
to_seconds((select max(ankunft) from flug join buchung using (flug_id)
join passagier p2 using (passagier_id)
where p1.passagier_id = p2.passagier_id
group by passagier_id)),
to_seconds((select min(abflug) from flug join buchung using (flug_id)
join passagier p2 using (passagier_id)
where p1.passagier_id = p2.passagier_id
group by passagier_id))
from buchung
join passagier p1 using (passagier_id)
join flug using(flug_id)
group by passagier_id
having sum((to_seconds(ankunft) - to_seconds(abflug))/3600) =
(select max(flugzeit) from
(select sum((to_seconds(ankunft) - to_seconds(abflug))/3600) flugzeit from buchung
join flug using(flug_id)
group by passagier_id) dummy);

# Liste der Sitz-Auslastung pro FLuglinie in %

select fluglinie_id,firmenname, (100/kt*bt) al from
(select fluglinie_id, sum(k) kt, sum(c) bt from
(select fl1.fluglinie_id,flug_id, kapazitaet k , count(*) c from flug fl1 join buchung using (flug_id)
join flugzeug using (flugzeug_id)
group by flug_id) dummy
group by fluglinie_id) dd
join fluglinie using (fluglinie_id)
order by al desc;

Resultat absteigend geordnet:

Ethiopia Airlines		3.2957
Reunion Airlines		3.2947
Lebanon Airlines		3.2947
Trinidad Airlines		3.2947
Myanmar Airlines		3.2944
Togo Airlines			3.2942
Australia Airlines		3.2936
Eritrea Airlines		3.2931
Philippines Airlines	3.2920
Slovakia Airlines		3.2919
Haiti Airlines			3.2914
Dominica Airlines		3.2910
Angola Airlines			3.2909
Solomon Is Airlines		3.2906
Kenya Airlines			3.2905
Italy Airlines			3.2901

oder:

select fluglinie_id, firmenname, a from
(select fluglinie_id, (100/k*c) a from
(select fl1.fluglinie_id, sum(kapazitaet) k  from flug fl1
join flugzeug using (flugzeug_id)
group by fl1.fluglinie_id) tb1
join
(select fl2.fluglinie_id, count(*) c  from flug fl2 join buchung using (flug_id)
group by fl2.fluglinie_id) tb2
using (fluglinie_id)) tb5
join fluglinie using (fluglinie_id)
order by a desc;

oder:

select fl.firmenname, fl.fluglinie_id, (SUM(AUSLASTUNG) / COUNT(fl.firmenname))  as AUSLASTUNG
from (
  select f.fluglinie_id, f.flugnr, fz.kapazitaet, b.flug_id, COUNT(b.flug_id), (COUNT(b.flug_id) / fz.kapazitaet * 100) as AUSLASTUNG
  from flug f join flugzeug fz on (fz.flugzeug_id = f.flugzeug_id)
  join buchung b on (b.flug_id = f.flug_id)
  group by f.fluglinie_id, f.flugnr, fz.kapazitaet, b.flug_id
) tx join fluglinie fl on (tx.fluglinie_id = fl.fluglinie_id)
group by fl.firmenname
order by AUSLASTUNG desc;


# Welcher Flughafen ist am meisten belastet?

select flughafen_id, name, count(*) cc from flug join flughafen
on flug.von = flughafen.flughafen_id or flug.nach = flughafen.flughafen_id
group by flughafen_id
having  cc =
(select max(c) from
(select flughafen_id, name, count(*) c from flug join flughafen
on flug.von = flughafen.flughafen_id or flug.nach = flughafen.flughafen_id
group by flughafen_id) dd);

# oder:

select fh.name, st.STARTS, ld.LANDUNGEN, (IFNULL(st.STARTS,0) + IFNULL(ld.LANDUNGEN,0)) as BEWEGUNGEN
from flughafen fh left outer join (select von as flughafen_id, COUNT(von) AS STARTS from flug group by von) st on (fh.flughafen_id = st.flughafen_id)
left outer join (select nach as flughafen_id, COUNT(nach) AS LANDUNGEN from flug group by nach) ld on (fh.flughafen_id = ld.flughafen_id)
order by BEWEGUNGEN desc;
