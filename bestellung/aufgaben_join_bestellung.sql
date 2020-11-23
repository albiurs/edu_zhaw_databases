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




# 4. Liste der Kunden mit der Anzahl Bestellungen pro Kunde
SELECT DISTINCT k.kname, COUNT(b.bid)
FROM kunde k
JOIN best b
ON k.kid = b.kid
GROUP BY k.kname;

# 5. Kundenliste von allen Kunden, die nie eine Bestellung abgesetzt haben.
SELECT *
FROM kunde k
JOIN best b
WHERE b.bid IS NULL;
### leerer return!!!

# 6. Liste (Kundenname, bid) von allen Bestellungen bei denen von der Artikelkategorie 'Home' bestellt wurde.
SELECT k.kname AS Kundenname, b.bid AS Bestell_ID
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON a.aid = bp.aid
WHERE akat = 'Home';

# 7. Liste der verkauften Mengen pro Artikel (Artikel-ID, Artikelbezeichnung, Menge)
SELECT DISTINCT(a.aid) AS Artikel_ID, a.abez AS Artikelbezeichnung, SUM(bp.menge) AS Menge
FROM kunde k
JOIN best b ON k.kid = b.kid
JOIN bpos bp ON b.bid = bp.bid
JOIN artikel a ON a.aid = bp.aid
GROUP BY a.aid
ORDER BY Menge DESC;

# 8. Gesamtes Bestellvolumen
SELECT sum(menge) AS gesamtes_bestellvolumen
FROM bpos;

# 9. Liste des Bestellvolumens pro Kunde (Kundenname, Bestellvolumen).
SELECT * 
FROM kunde k
JOIN bpos bp;

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