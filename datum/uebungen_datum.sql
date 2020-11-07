MySQL - Uebungen				15.11.04, RZI

Bemerkung: Diese �bungen werden direkt auf der Kommandozeile gemacht - es braucht keine DB dazu!



1. Vom heutigen Datum soll die Darstellung Monat Tag, Jahr(4) (z.B. January 15, 2004) erzeugt werden:

+------------+-------------------+
| now()      | Datum             |
+------------+-------------------+
| 2004-12-05 | December 05, 2004 |
+------------+-------------------+

2. Vom jetzigen Augenblick sollen die untenstehenden Ausgabeformate erzeugt werden:

+---------------------+---------------------+---------------------------+
| jetzt               | Format1             | Format2                   |
+---------------------+---------------------+---------------------------+
| 2004-12-05 22:13:25 | 5/12/04 10:13:25 PM | December 5, 2004 22:13:25 |
+---------------------+---------------------+---------------------------+

3. Es soll vom jetzigen Zeitpunkt folgende Ausgabe erzeugt werden:

+-------------------------------------------------------------------------------------+
| Zeitangabe                                                                          |
+-------------------------------------------------------------------------------------+
| Jetzt ist Sunday der 340. Tag des Jahres 2004 im December den 12. 22 Uhr 31 Minuten |
+-------------------------------------------------------------------------------------+

4. Zerlegen Sie die Datums/Zeit Angabe wie folgt:

+---------------------+------+-------+----------------+--------+---------+----------+
| DatumZeit           | Jahr | Monat | Tag des Monats | Stunde | Minuten | Sekunden |
+---------------------+------+-------+----------------+--------+---------+----------+
| 2004-12-05 22:42:20 | 2004 |    12 |              5 |     22 |      42 |       20 |
+---------------------+------+-------+----------------+--------+---------+----------+

5. Zerlegen Sie eine Zeitangabe folgendermassen:

+----------+----------+---------+---------+------+
| Zeit     | Sekunden | Minuten | Stunden | Tage |
+----------+----------+---------+---------+------+
| 23:01:01 |    82861 | 1381.02 |   23.02 | 0.96 |
+----------+----------+---------+---------+------+

6. Berechnen Sie die Differenz zwischen zwei Daten in Tagen:

+------------+------------+--------------------+
| Datum1     | Datum2     | Differenz in Tagen |
+------------+------------+--------------------+
| 2000-06-01 | 2000-12-15 |                197 |
+------------+------------+--------------------+

7. Berechnen Sie das Datum heute vor 627 Tagen

+-------------+---------------------------+
| Datum heute | Datum heute vor 627 Tagen |
+-------------+---------------------------+
| 2004-12-05  | 2003-03-19                |
+-------------+---------------------------+

8. Berechnen Sie das Alter aus dem Geburtsdatum in Jahren

set @bd = '1955-04-07';
set @cd = curdate();

+------------+------------+-------+
| @bd        | @cd        | Alter |
+------------+------------+-------+
| 1955-04-07 | 2004-12-06 |    49 |
+------------+------------+-------+

9. Berechnen Sie das Alter aus Geburtsdatum in Monaten

+------------+------------+------------------+
| @bd        | @cd        | Alter in Monaten |
+------------+------------+------------------+
| 1955-04-07 | 2004-12-06 |              595 |
+------------+------------+------------------+

10. Errechnen Sie jeweils das Datum des ersten Tages im Monat

+------------+-------------------+
| curdate()  | Erster des Monats |
+------------+-------------------+
| 2004-12-06 | 2004-12-01        |
+------------+-------------------+

11. Berechnen Sie das Datum des letzten Tages eines gegebenen Monats

+------------+-----------------------+
| @d         | Letzter des Monats @d |
+------------+-----------------------+
| 2005-02-15 | 2005-02-28            |
+------------+-----------------------+

12. Berechnen Sie die Anzahl Tage eines Monats

+------------+---------------------------+
| @d         | Anzahl Tage des Monats @d |
+------------+---------------------------+
| 2005-02-15 |                        28 |
+------------+---------------------------+

13. Berechnen Sie, ob ein Jahr ein Schaltjahr ist oder nicht

+------------+------------------------+
| @j         | Schaltjahr 0=nein,1=ja |
+------------+------------------------+
| 1500-03-17 |                      0 |
+------------+------------------------+