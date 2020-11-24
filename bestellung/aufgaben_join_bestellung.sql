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


# 11. Liste (Artikelkategorie, Summe der jeweiligen bestellten Artikelmengen pro Kategorie)


# 12. Der teuerste Artikel mit dem zugehörigen Preis


# 13. Artikel der mengenmässig am meisten bestellt worden ist


# 14. Liste der Kunden mit der Gesamtanzahl ihrer Bestellpositionen (auf all ihren Bestellungen!)





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