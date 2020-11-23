/*  Erste Uebungen zu JOIN's
Fach: Grundlagen Datenbanken
Basis: DB Bestellungen aus Vorlesung
Autor: R. Zimmermann
Datum: 25.11.2016
-------------------------------------------------------------------------------------------------------------------------*/

SHOW DATABASES;
USE bestellung;
SHOW TABLES;


# 1. Liste aller Kunden (kid, kname) die eine Bestellung haben mit Datum der Bestellung

select kid, kname, bdate from kunde join best using (kid) order by kid;

select distinct kid, kname from kunde join best using (kid) order by kid; # ohne bdat sortiert -> distinct


# 2. Liste aller Kunden die eine Bestellung haben mit Datum der Bestellung geordnet nach Kundenname und Bestelldatum

# klar


# 3. Anzahl der (verschiedenen) Kunden, die eine Bestellung haben

select count(distinct kid) from best;


# 4. Liste der Kunden mit der Anzahl Bestellungen pro Kunde

select kid, kname, count(*) from kunde join best using (kid) group by kid; # ohne Kunden ohne Bestellung

select kid, kname, count(bid) from kunde left join best using (kid) group by kid; # mit Kunden ohne Bestellung


# 5. Kundenliste von allen Kunden, die nie eine Bestellung abgesetzt haben.

select kid, kname from kunde left join best using (kid) where bid is null;


# 6. Liste (Kundenname, bid) von allen Bestellungen bei denen von der Artikelkategorie 'Home' bestellt wurde.

select kid, kname, bid from kunde join best using (kid)
                                  join bpos  using (bid)
                                  join artikel using (aid)
where akat = 'home';


# 7. Liste der verkauften Mengen pro Artikel (Artikel-ID, Artikelbezeichnung, Menge)

select aid,abez, sum(menge) from artikel join bpos using(aid) group by aid;


# 8. Gesamtes Bestellvolumen, 2. in Franken und Rappen

select sum(menge) from bpos;

select sum( apreis * menge) from bpos join artikel using (aid);


# 9. Liste des Bestellvolumens pro Kunde (Kundenname, Bestellvolumen).

select kid, kname, sum(menge) from kunde join best using (kid)
                                         join bpos using (bid)
group by kid;

# Bestellvolumen in Franken und Rappen
select kid, kname, sum(menge * apreis) from kunde join best using (kid)
                                                  join bpos using (bid)
                                                  join artikel using (aid)
group by kid;

# 10. Gesamter Bestellwert des Kunden Morger

select kid, kname, kvname, sum(menge * apreis) from kunde join best using (kid)
                                                          join bpos using (bid)
                                                          join artikel using (aid)
where kname = 'morger'
group by kid;


# 11. Liste (Artikelkategorie, Summe der jeweiligen bestellten Artikelmengen pro Kategorie)

select akat, sum(menge) from artikel join bpos using (aid)
group by akat;


# 12. Der teuerste Artikel mit dem zugehörigen Preis

select aid,abez, max(apreis) from artikel; # !!!!!  # ais und abez haben mit dem max(apreis) NICHTS zu tun !!!!
select apreis from artikel where abez = 'blumenvase';

# geht nur mit Unterabfragen:

select aid, abez, apreis from artikel where apreis =
                                            (select max(apreis) from artikel);


# 13. Artikel der[/die] mengenmässig am meisten bestellt worden ist

select aid, abez from artikel join bpos using (aid) group by aid
having sum(menge) =
       (select max(hugo) from
           (select sum(menge) hugo from bpos group by aid) dummytable);

# select was from wo where "hardfacts" group by xxxxx having "softfacts" order by


# 14. Liste der Kunden mit der Gesamtanzahl ihrer Bestellpositionen (auf all ihren Bestellungen!)

select kid, kname, count(*) from kunde join best using (kid)
                                       join bpos using (bid)
group by kid;

# Kunde/n mit den meisten Bestellpositionen

select kid, kname from kunde join best using (kid)
                             join bpos using (bid)
group by kid
having count(*) =
       (select max(ff) from
           (select count(*) ff from best join bpos using (bid)
            group by kid) dt);

#--------------------------------------------------------------------------------------------------------------------------------------
# Diskussion Zusatz

select now();
select curdate();
select curtime();

select date_format(now(),'sajfgsjdfg %Y %y jsdhgfjsag %M aksdfisFH');

select kid, kname, kvname, kgdat from kunde
where (kvname, kgdat) = (select kvname,kgdat from kunde where
        kname = 'gomez');

select kid,kname, bdate from kunde join best using (kid)
where bdate =
      (select max(bdate) from best);

select year('2020-11-21');
