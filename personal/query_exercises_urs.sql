SHOW DATABASES;

USE personal;

SHOW TABLES;

SELECT * FROM personal;

SELECT pnum, name, vname FROM personal LIMIT 10;

# Addition
SELECT 10 + 2;

# true returns 1
SELECT 10 > 1;

# false returns 0
SELECT 10 < 1;

# Sinus
SELECT sin(3.1415926);

# Konstante PI
SELECT pi();

# Sinus pi() > '1.2246467991473532e-16'
SELECT sin(
	pi()
);

# CONCAT
SELECT CONCAT(name,' - ',vname)
FROM personal;

# LENGTH()
SELECT LENGTH(
	CONCAT(name,' - ',vname)
)
FROM personal;

# CURDATE()
SELECT CURDATE();

# CURTIME()
SELECT CURTIME();




# Aggregate functions
#####################

## min(), max(), count(), sum(), avg()...

# alle datensätze der ganzen Tabelle zählen (zählt auch NULL-Werte):
SELECT count(*)
FROM personal;

# zählt nur die Datensätze, bei denen auch ein Wert in "name" steht (zält NULL-Datensätze nicht mit):
SELECT count(name)
FROM personal;

# avg()
SELECT avg(plz)
FROM personal;

# GROPU BY ...
SELECT name, COUNT(name)
FROM personal
GROUP BY name;

SELECT name, vname, COUNT(name) cc 
FROM personal
GROUP BY name, vname
ORDER BY cc DESC;

# kleinstes Geburtsdatum
SELECT MIN(gdat)
FROM personal;

SELECT name, vname, gdat
FROM personal 
WHERE gdat = (
	SELECT min(gdat)
	FROM personal
);



# DISTINCT
##########
# > keine Klammer > DISTINCT = Erweiterung von SELECT!
SELECT DISTINCT name, COUNT(*)
FROM personal
WHERE name LIKE 'Zi%'
GROUP BY name;

SELECT COUNT(DISTINCT(name AND vname))
FROM personal;

SELECT DISTINCT name, vname
FROM personal;

SELECT COUNT(DISTINCT name)
FROM personal;

SELECT COUNT(DISTINCT name, vname)
FROM personal;



# Unter-Abfragen
################

SELECT name, vname, gdat
FROM personal 
WHERE gdat = (
	SELECT min(gdat)
	FROM personal
);

WITH min_gdat AS (
	SELECT MIN(gdat) AS geb_dat
    FROM personal
)
SELECT p.name, p.vname, mg.geb_dat
FROM min_gdat mg
JOIN personal p
	ON p.gdat = mg.geb_dat;

