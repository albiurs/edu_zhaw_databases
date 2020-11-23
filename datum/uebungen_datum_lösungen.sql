MySQL - Uebungen				15.11.04, RZI


1. Vom heutigen Datum soll die Darstellung Monat Tag, Jahr(4) (z.B. January 15, 2004) erzeugt werden:

+------------+-------------------+
| now()      | Datum             |
+------------+-------------------+
| 2004-12-05 | December 05, 2004 |
+------------+-------------------+

1L. mysql> select curdate(), date_format(now(), '%M %d, %Y') as Datum;

2. Vom jetzigen Augenblick sollen die untenstehenden Ausgabeformate erzeugt werden:

+---------------------+---------------------+---------------------------+
| jetzt               | Format1             | Format2                   |
+---------------------+---------------------+---------------------------+
| 2004-12-05 22:13:25 | 5/12/04 10:13:25 PM | December 5, 2004 22:13:25 |
+---------------------+---------------------+---------------------------+

2L. mysql> select now() as jetzt, date_format(now(), '%e/%c/%y %r') as Format1, date_format(now(), '%M %e, %Y %T') as Format2;

3. Es soll vom jetzigen Zeitpunkt folgende Ausgabe erzeugt werden:

+-------------------------------------------------------------------------------------+
| Zeitangabe                                                                          |
+-------------------------------------------------------------------------------------+
| Jetzt ist Sunday der 340. Tag des Jahres 2004 im December den 12. 22 Uhr 31 Minuten |
+-------------------------------------------------------------------------------------+

3L. mysql> select date_format(now(),'Jetzt ist %W der %j. Tag des Jahres %Y im %M den %c. %k Uhr %i Minuten') as Zeitangabe;

4. Zerlegen Sie die Datums/Zeit Angabe wie folgt:

+---------------------+------+-------+----------------+--------+---------+----------+
| DatumZeit           | Jahr | Monat | Tag des Monats | Stunde | Minuten | Sekunden |
+---------------------+------+-------+----------------+--------+---------+----------+
| 2004-12-05 22:42:20 | 2004 |    12 |              5 |     22 |      42 |       20 |
+---------------------+------+-------+----------------+--------+---------+----------+

4L. mysql> select now() as DatumZeit,year(now())as Jahr,month(now())as Monat,dayofmonth(now())as 'Tag des Monats',hour(now())
                        as Stunde,minute(now())as Minuten,second(now())as Sekunden;

5. Zerlegen Sie eine Zeitangabe folgendermassen:

+----------+----------+---------+---------+------+
| Zeit     | Sekunden | Minuten | Stunden | Tage |
+----------+----------+---------+---------+------+
| 23:01:01 |    82861 | 1381.02 |   23.02 | 0.96 |
+----------+----------+---------+---------+------+

5L. mysql> select curtime()as Zeit,
               ->time_to_sec(curtime())as Sekunden,
               ->time_to_sec(curtime())/60 as Minuten,
               ->time_to_sec(curtime())/(60*60) as Stunden,
               ->time_to_sec(curtime())/(24*60*60) as Tage;

6. Berechnen Sie die Differenz zwischen zwei Daten in Tagen:

+------------+------------+--------------------+
| Datum1     | Datum2     | Differenz in Tagen |
+------------+------------+--------------------+
| 2000-06-01 | 2000-12-15 |                197 |
+------------+------------+--------------------+

6L.
mysql> set @d1 = '2000-06-01';
mysql> set @d2 = '2000-12-15';
mysql> select @d1 as Datum1,@d2 as Datum2, to_days(@d2)-to_days(@d1) as 'Differenz in Tagen';
mysql> select datediff(@d2,@d1) as 'Differenz in Tagen';

7. Berechnen Sie das Datum heute vor 627 Tagen

+-------------+---------------------------+
| Datum heute | Datum heute vor 627 Tagen |
+-------------+---------------------------+
| 2004-12-05  | 2003-03-19                |
+-------------+---------------------------+

7L.
mysql> select curdate() as 'Datum heute', Date_sub(curdate(), interval 627 day) as 'Datum heute vor 627 Tagen';
mysql> select curdate() as 'Datum heute',from_days(to_days(curdate()) - 627) as 'Datum vor 627 Tagen';

8. Berechnen Sie das Alter in Jahren aus ihrem Geburtsdatum

set @bd = '1955-04-07';
set @cd = curdate();

+------------+------------+-------+
| @bd        | @cd        | Alter |
+------------+------------+-------+
| 1955-04-07 | 2004-12-06 |    49 |
+------------+------------+-------+

8L. mysql> select @bd,@cd,(year(@cd)-year(@bd)) - if(right(@cd,5) < right(@bd,5),1,0) as 'Alter';

9. Berechnen Sie das Alter aus Geburtsdatum in Monaten

+------------+------------+------------------+
| @bd        | @cd        | Alter in Monaten |
+------------+------------+------------------+
| 1955-04-07 | 2004-12-06 |              595 |
+------------+------------+------------------+

9L. mysql> select @bd,@cd, (year(@cd)-year(@bd))*12 + month(@cd)-month(@bd) - if(dayofmonth(@cd)<dayofmonth(@bd),1,0)
    as 'Alter in Monaten';

10. Errechnen Sie jeweils das Datum des ersten Tages im Monat

+------------+-------------------+
| curdate()  | Erster des Monats |
+------------+-------------------+
| 2004-12-06 | 2004-12-01        |
+------------+-------------------+

10L.
mysql> select curdate(), date_sub(curdate(),interval dayofmonth(curdate())-1 day) as 'Erster des Monats';
oder mit String-Funktionen
mysql> select curdate(), concat(left(curdate(),7),'-01') as 'Erster des Monats';

11. Berechnen Sie das Datum des letzten Tages eines gegebenen Monats

+------------+-----------------------+
| @d         | Letzter des Monats @d |
+------------+-----------------------+
| 2005-02-15 | 2005-02-28            |
+------------+-----------------------+

11L.
mysql> select @d, date_sub(date_add(date_sub(@d,interval dayofmonth(@d)-1 day), interval 1 month), interval 1 day)
    as 'Letzter des Monats @d';

12. Berechnen Sie die Anzahl Tage eines Monats

+------------+---------------------------+
| @d         | Anzahl Tage des Monats @d |
+------------+---------------------------+
| 2005-02-15 |                        28 |
+------------+---------------------------+

12L.
mysql> select @d, dayofmonth(date_sub(date_add(date_sub(@d,interval dayofmonth(@d)-1 day), interval 1 month), interval 1 day))
    as 'Anzahl Tage des Monats @d';

13. Berechnen Sie, ob ein Jahr ein Schaltjahr ist oder nicht

+------------+------------------------+
| @j         | Schaltjahr 0=nein,1=ja |
+------------+------------------------+
| 1500-03-17 |                      0 |
+------------+------------------------+

13L.
mysql> select @j, (year(@j) % 4 = 0) and ((year(@j) % 100 != 0) or (year(@j) % 400 = 0)) as 'Schaltjahr 0=nein,1=ja';







