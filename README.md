# SAP Fallstudie Universität

Verwaltung von Prüfungsergebnissen

Prototyp soll im Web Browser (Web Dynpro Anwendung) implementiert werden.

### Anforderungen:
==============
1. Verwaltung von Studenten, Prüfungen und Prüfungsteilnahmen (Ergebnissen).
   1.1. Studenten: Name, Vorname, Matrikelnummer und Studiengang.
   1.2. Prüfungen: ID, Name, Datum der Prüfung, Art (Mündlich, Schriftlich), Prüfer und Kreditpunkte. 
   1.3. Teilnahme: Matrikelnummer, PrüfungsId, TeilnahmeId, Ergebnis (Note).

### Views:
======
1. Alle Prüfungsergebnisse eines Studenten, BUTTONS STUDENT_CREATE, STUDENT_EDIT, STUDENT_DELETE.
2. Alle Prüfungsergebnissen einer bestimmten Prüfung, BUTTONS TEST_CREATE, TEST_EDIT, TEST_DELETE.

VIEW_MAIN
VIEW_STUDENT
 VIEW_CREATE_STUDENT
 VIEW_EDIT_STUDENT
 DELETE_STUDENT (func)

VIEW_TEST
 VIEW_CREATE_TEST
 VIEW_EDIT_TEST
 DELETE_TEST (func)

VIEW_TEILNAHME
 VIEW_CREATE_TEILNAME (?)
 VIEW_EDIT_TEILNAME
 DELETE_TEILNAHME (func)

### Features:
=========
ANLEGEN, ÄNDERN, LÖSCHEN von Studenten, Prüfungen oder Teilnahmen.

ZZ3002_STUDENTEN
ZZ3002_TEILNAHME
ZZ3002_TEST

### Steps
=====
1. Entwicklung der Tabellen Studenten, Prüfungen und Ergebnissen.
2. Definition des Web Dynpro Contexts
3. Erste Feld soll MANDT (Mandant) sein

### Usability
=========
1. Oberfläche soll benutzerfreundlich sein
2. Fehlerhafte Eingaben sollen abgefangen werden
3. Eingabehilfe für ID, Name oder weitere Felder sollen zur Verfügung stehen.
4. Features per Button klar unterscheidbar sein

5. Aktionen müssen entsprechendes Feedback erhalten.
   5.1. Fehlermeldung bei Versuch bei bereits existierenden Datensatz anzulegen.
   5.2. Fehlermeldung bei Versucht NICHT existierenden Datensatz zu öffnen.

6. Kein Pflichtfelder wegen Testen
7. Views mit entsprechenden Namen versehen.
8. Ergebnisliste pro Student oder pro Prüfung muss auf einer view implementiert werden.
9. Es muss ohne Suchhilfen möglich sein, Datensätze zu laden.

10. Datenbankzugriffe kann man über die selbstdefinierten Methoden des Component Controllers kapseln.
Diese Methoden können aus den onaction- bzw wddomodify Methoden des View aufgerufen werden.

11. Wizard benutzen um Eingabemaske und Zugriffe auf dem Context zu generieren.

12. Debugging /nST22
13. Häufiger Fehler sind Kardinalitäten im Context tipp 0..n
