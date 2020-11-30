/*  Erste Uebungen zu JOIN's
Fach: Grundlagen Datenbanken
Basis: DB Bestellungen aus Vorlesung
Autor: R. Zimmermann
Datum: 25.11.2016
-------------------------------------------------------------------------------------------------------------------------*/

# Vorgehen:
# 1. vertehen der Frage
# 2. Welche Tabelle brauche ich, um die Frage zu beantworten?
# 3. Wie sind die Tabellen verbunden?
# 4. Wie verbinde ich die Tabellen?
# 5. Wie filtere ich die Datensätze?

# Befehl ausführen = CMD + Enter


SHOW DATABASES;
USE bestellung;
SHOW TABLES;

# 1. Liste aller Kunden (kid, kname) die eine Bestellung haben mit Datum der Bestellung
SELECT k.kid, k.kname, b.bdate
FROM kunde k
JOIN best b
ON k.kid = b.kid
ORDER BY k.kid;

select kid, kname, bdate from kunde join best using (kid) order by kid;


# 2. Liste aller Kunden die eine Bestellung haben mit Datum der Bestellung geordnet nach Kundenname und Bestelldatum
SELECT k.kname, b.bdate
FROM kunde k
JOIN best b
ON k.kid = b.kid
ORDER BY k.kname, b.bdate;

SELECT k.kname, b.bdate
FROM kunde k
JOIN best b
ON k.kid = b.kid
ORDER BY k.kname, b.bdate;

SELECT kname, bdate
FROM kunde
JOIN best using (kid)
ORDER BY kname, bdate;


# 3. Anzahl der (verschiedenen) Kunden, die eine Bestellung haben
SELECT COUNT(DISTINCT k.kid)
FROM kunde k
JOIN best b
ON k.kid = b.kid;

SELECT COUNT(DISTINCT kid)
FROM kunde
JOIN best b using (kid);

select count(distinct kid) from best;


# 4. Liste der Kunden mit der Anzahl Bestellungen pro Kunde
# sorted by name > vname
SELECT k.kid, k.kname, k.kvname, COUNT(b.bid) AS Bestellmenge
FROM kunde k
LEFT JOIN best b on k.kid = b.kid
GROUP BY k.kid, k.kname, k.kvname
ORDER BY k.kname, k.kvname;

# sorted by Bestellmenge
SELECT k.kid, k.kname, k.kvname, COUNT(b.bid) AS Bestellmenge
FROM kunde k
LEFT JOIN best b on k.kid = b.kid
GROUP BY k.kid, k.kname, k.kvname
ORDER BY Bestellmenge DESC;

select kid, kname, count(*) from kunde join best using (kid) group by kid; # ohne Kunden ohne Bestellung

select kid, kname, count(bid) from kunde left join best using (kid) group by kid; # mit Kunden ohne Bestellung


# 5. Kundenliste von allen Kunden, die nie eine Bestellung abgesetzt haben.
SELECT k.kname, k.kvname, b.bid
FROM kunde k
LEFT JOIN best b ON k.kid = b.kid
WHERE b.bid IS NULL
ORDER BY k.kname, k.kvname;

SELECT k.kname, k.kvname, b.bid
FROM kunde k
LEFT JOIN best b ON k.kid = b.kid
WHERE b.bid IS NULL;

select kid, kname from kunde left join best using (kid) where bid is null;


# 6. Liste (Kundenname, bid) von allen Bestellungen bei denen von der Artikelkategorie 'Home' bestellt wurde.
SELECT k.kname AS Kundenname, b.bid AS Bestell_ID
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON a.aid = bp.aid
WHERE akat = 'Home';

SELECT k.kname, k.kvname, b.bid, a.akat
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON bp.aid = a.aid
WHERE a.akat = 'Home'
ORDER BY k.kname, k.kvname;

select kid, kname, bid from kunde join best using (kid)
                                  join bpos  using (bid)
                                  join artikel using (aid)
where akat = 'home';


# 7. Liste der verkauften Mengen pro Artikel (Artikel-ID, Artikelbezeichnung, Menge)
SELECT DISTINCT(a.aid) AS Artikel_ID, a.abez AS Bezeichnung, SUM(bp.menge) AS Menge
FROM best b
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON bp.aid = a.aid
GROUP BY a.aid
ORDER BY Menge DESC;

SELECT DISTINCT(a.aid) AS Artikel_ID, a.abez AS Bezeichnung, SUM(bp.menge) AS Menge
FROM artikel a
JOIN bpos bp ON a.aid = bp.aid
GROUP BY a.aid
ORDER BY Menge DESC;

select aid,abez, sum(menge) from artikel join bpos using(aid) group by aid;


# 8. Gesamtes Bestellvolumen
SELECT sum(menge) AS gesamtes_bestellvolumen
FROM bpos;

SELECT SUM(menge)
FROM bpos;

SELECT sum(bp.menge * a.apreis) # in Franken und Rappen
FROM bpos bp
JOIN artikel a ON bp.aid = a.aid;

select sum(menge) from bpos;

select sum( apreis * menge) from bpos join artikel using (aid); # in Franken und Rappen


# 9. Liste des Bestellvolumens pro Kunde (Kundenname, Bestellvolumen).
SELECT k.kid, k.kname, k.kvname, sum(bp.menge)
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
GROUP BY k.kid, bp.menge
ORDER BY bp.menge DESC;

select kid, kname, sum(menge) from kunde join best using (kid)
                                         join bpos using (bid)
group by kid;


# 10. Gesamter Bestellwert des Kunden Morger
SELECT k.kid, k.kname, k.kvname, SUM(bp.menge * a.apreis)
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON a.aid = bp.aid
WHERE k.kname = 'morger'
GROUP BY k.kid;

select kid, kname, kvname, sum(menge * apreis) from kunde join best using (kid)
                                                          join bpos using (bid)
                                                          join artikel using (aid)
where kname = 'morger'
group by kid;


# 11. Liste (Artikelkategorie, Summe der jeweiligen bestellten Artikelmengen pro Kategorie)
SELECT a.akat, sum(bp.menge)
FROM artikel a
JOIN bpos bp ON a.aid = bp.aid
GROUP BY a.akat;

select akat, sum(menge) from artikel join bpos using (aid)
group by akat;


# 12. Der teuerste Artikel mit dem zugehörigen Preis
SELECT max(apreis)
FROM artikel;       # nur Preis

SELECT aid, abez, apreis
FROM artikel
where apreis = (
    SELECT max(apreis)
    FROM artikel
);

WITH max_preis_query AS (
    SELECT max(apreis) AS max_preis
    FROM artikel
)
SELECT aid, abez, m.max_preis
FROM max_preis_query m
JOIN artikel a
WHERE a.apreis = m.max_preis;

select aid,abez, max(apreis) from artikel; # !!!!!  # ais und abez haben mit dem max(apreis) NICHTS zu tun !!!!
select apreis from artikel where abez = 'blumenvase';


# 13. Artikel der mengenmässig am meisten bestellt worden ist
SELECT *
FROM artikel a
JOIN bpos b on a.aid = b.aid;

SELECT a.aid, a.abez, SUM(bp.menge)
FROM artikel a
JOIN bpos bp on a.aid = bp.aid
GROUP BY a.aid;

SELECT a.aid, a.abez, SUM(bp.menge) AS sum_menge
FROM artikel a
JOIN bpos bp ON bp.aid = a.aid
GROUP BY a.aid
HAVING sum_menge = (
    SELECT max(sum_menge_sub) AS max_sum_menge
    FROM (
         SELECT SUM(bp.menge) AS sum_menge_sub
         FROM artikel a
         JOIN bpos bp on a.aid = bp.aid
         GROUP BY a.aid
     ) AS sum_sm
);

select aid, abez from artikel join bpos using (aid) group by aid
having sum(menge) =
       (select max(hugo) from
           (select sum(menge) hugo from bpos group by aid) dummytable);


# Lösungsweg
############

# Welche Tabellen werden gebraucht?
# Wo sind Mengen, Artikel, Bestellpos?

SELECT sum(menge) from bpos;

SELECT aid, sum(menge) from bpos group by aid;

SELECT sum(menge) from bpos group by aid;

#(SELECT sum(menge) from bpos group by aid) dummy_table;

select max(hh) from
                    (SELECT sum(menge) hh from bpos group by aid) dummy_table;

select aid, abez from artikel join bpos using (aid) group by aid
having sum(menge) =
(select max(hh) from
                    (SELECT sum(menge) hh from bpos group by aid) dummy_table);


# 14. Liste der Kunden mit der Gesamtanzahl ihrer Bestellpositionen (auf all ihren Bestellungen!)
SELECT *
FROM kunde k
JOIN best b ON k.kid = b.bid
JOIN bpos bp ON b.bid = bp.bid;

SELECT k.kid, k.kname, k.kvname, count(bp.aid) anz_bestellpos
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
GROUP BY k.kid
ORDER BY anz_bestellpos DESC;

select kid, kname, count(*) from kunde join best using (kid)
                                       join bpos using (bid)
group by kid;



# Diverse Übungen während der Lektion:

# LEFT JOIN
SELECT * 
FROM kunde 
LEFT JOIN best 
USING(kid);

# alle Kunden, die nichts bestellt hat
SELECT * 
FROM kunde 
LEFT JOIN best 
USING(kid)
WHERE bid IS NULL;

# Kundenliste  mit der Anz. Bestellungen pro Kunde
select kid, kname, kvname, count(bid) 
from kunde 
left join best 
using(kid) 
group by kid;

# Welche Kunden haben ein Velo bestellt?
SELECT kid, kname, kvname, akat, abez
FROM kunde
JOIN best using(kid)
JOIN bpos USING(bid)
JOIN artikel USING(aid)
WHERE abez = 'velo';

SELECT DISTINCT kid, kname, kvname, akat, abez
FROM kunde
JOIN best using(kid)
JOIN bpos USING(bid)
JOIN artikel USING(aid)
WHERE akat = 'home';