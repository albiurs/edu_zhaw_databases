/* Aufgaben zu Winestore DB */
Datum: 4.10.2020
Autor: R. Zimmermann
-----------------------------------------------------------------------------------------------------------------*/
# 1. Wie viele Kunden sind in der Datenbank registriert?



# 1a. Sind Kunden doppelt eingetragen?



# 1b. Wie viele Kunden haben eine Bestellung ?



# 1c. Liste der Kunden die keine Bestellung haben



# 1d. Integrität/Konsistenz der Beziehung orders-items prüfen:


# 1e. Integrität/Konsistenz der Tabellen customer-orders prüfen



# 2. Gibt es überhaupt unvollständige Kundendatensätze?



# 2a. Kontrollieren Sie die MussFelder (Not NULL) auf der Tabelle customer - Sinnvoll?

# 3. Wie viele (verschiedene ?!) Weine sind eingetragen



# 3a. Wie viele verschiedene Weine sind eingetragen, wenn nicht der Jahrgang aber der Weintyp als Unterschied gelten?



# 3b. Wie viele verschiedene Weinnamen sind überhaupt eingetragen?



# 3b. Wie viele verschiedene Weine sind eingetragen, wenn Name, Jahrgang und der Weintyp als Unterschied gelten ?



# 4. Wieviele verschiedene Weinnamen sind erfasst?



# 4a. Zählen Sie die Anzahl der Weine pro Weinnamen - was fällt auf? - warum ist das so?



# 4b. Doubletten suchen



# 5. Wie viele verschiedene Weine gibt es von jedem Weintyp?

# 5a. Erstellen Sie hier eine Auswertung GROUP BY mit ROLLUP



# 6. Von welchem Weintyp gibt es am meisten verschiedene Weine?



# 7. Wie viele Weinflaschen sind total am Lager?



# 7a. Sind alle erfassten Weine am Lager



# 7b. Liste Anzahl Weinflaschen pro Region am Lager?



# 7c. Liste der wineries mit der zugehörigen Region



# 7d. Liste der Regionen mit der Anzahl zugehöriger Wineries



# 7e. In welcher Region liegen die meisten Wineries?



# 8. Wie gross ist der Lagerwert zu Einstandspreisen der Weine?



# Aufgabe: Was kostet der billigste Wein im Einkauf?



# Aufgabe: Was kostet der teuerste Wein im Einkauf?



# Aufgabe: Was ist der durchschnittliche Einkaufspreis pro Flasche?



# 9. In welchem Land wohnen die meisten Kunden?



# 10. Wie viele Bestellungen hat der oder die Kunden mit den meisten Bestellungen ?



# 11. Liste des/der Kunden mit der höchsten Anzahl Bestellungen geordnet nach sur- und firstname !



# 12. Liste der Weine, die in keiner Bestellung vorkommen



# 13. Liste der Marge (Differenz zwischen Einstands- und Verkaufspreis) der bestellten Weine pro Verkaufsposition


# 13a. Wo tauchen hier Fragen auf? Wie kontrollieren wir das ?
# 13b. Sind alle Margen positiv ?
# 13c. Ist dieser Weinhändler ein guter Geschäftsmann ?

# 13d. Wie gross ist die Gesamtmarge overall?



# 14. Liste der Kunden mit dem Totalbetrag aller Bestellungen eines Kunden



# mit Marge pro Kunde:



# Kontrolle eines Kunden:



# 15. Wie hoch ist die Summe der Bestellung des Kunden, der wertmässig am meisten bestellt hat?



# 16. Welcher Kunde hat diese grösste Bestellsumme?



# 17. Aus welcher Region kommen die meisten Weine?



# 18. Aus welchen Trauben sind die jeweiligen Weine zusammengesetzt?



# Liste mit group_concat



# 18a. Welcher Wein ist «verschnitten» und welcher nicht?



# 19. Sind alle varieties "im Einsatz"?



# ja sie sind - und wine_variety ist konsistent zu wine?



# ja die Beziehung ist konsistent

# 20. Aus wie vielen grape_varieties besteht der Wein, der am "meisten" verschnitten ist?



# 20a. Welcher/welche Wein/e ist/sind das ?



# 20b. Wie viele Weine sind in 20a. betroffen?



# 21. Welche grape_ variety ist über alle Weine am meisten beteiligt?



# 22. Welcher Kunde hat den höchsten durchschnittlichen Preis/Flasche in all seinen Bestellpositionen?



# 23.Zeige alle Kunden mit mindestens einer „Nullmargenposition“



# 24. Welche Kunden haben keine “Nullmargenposition”?



# 25. Zeige alle Kunden mit jeweils allen „Nullmargenpositionen“ in allen Bestellungen mit Angabe von order_id und item_id

