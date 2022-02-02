*&---------------------------------------------*
*&  INCLUDE      Z_TEILNEHMER_DEKLARATIONEN    *
*&---------------------------------------------*

* Tabellenarbeitsbereiche deklarieren
 DATA wa_zteilnehmer02 TYPE zteilnehmer02.

* Felder deklarieren
 DATA: glob_tmax       TYPE i VALUE 12,
       lokale_datei    TYPE string,
       progname        TYPE c LENGTH 25,
       repname         LIKE progname,
       zeilen_itab01   TYPE i,
       zzaehler_itab04 TYPE c LENGTH 1.

* Datentypen für Zeilen deklarieren
 TYPES: BEGIN OF zeile01_typ,
          zzkurstitel TYPE zteilnehmer02-zzkurstitel,
          tkurspreis  TYPE zteilnehmer02-tkurspreis,
        END OF zeile01_typ.

 TYPES BEGIN OF zeile02_typ.
 INCLUDE TYPE zeile01_typ.
 TYPES minteiln TYPE i.
 TYPES   END OF zeile02_typ.

 TYPES: BEGIN OF zeile03_typ,
          bezeichnung TYPE zteilnehmer02-zzkurstitel,
          preis       TYPE zteilnehmer02-tkurspreis,
          maxteil     TYPE i,
        END OF zeile03_typ.

 TYPES zeile04_typ TYPE zteilnehmer02.

* Datentypen für interne Tabellen deklarieren
 TYPES itab01_typ TYPE STANDARD TABLE OF zeile01_typ.
 TYPES itab02_typ TYPE STANDARD TABLE OF zeile02_typ.
 TYPES itab03_typ TYPE STANDARD TABLE OF zeile03_typ.
 TYPES itab04_typ TYPE STANDARD TABLE OF zeile04_typ.

* Interne Tabellen deklarieren ohne Kopfzeile
 DATA itab01 TYPE itab01_typ.
 DATA itab02 TYPE itab02_typ.
 DATA itab03 TYPE itab03_typ.
 DATA itab04 TYPE itab04_typ.
 DATA itab05 TYPE itab04_typ.

* Workareas für interne Tabellen deklarieren
 DATA wa_itab01 TYPE zeile01_typ.
 DATA wa_itab02 TYPE zeile02_typ.
 DATA wa_itab03 TYPE zeile03_typ.
 DATA wa_itab04 TYPE zeile04_typ.
 DATA wa_itab05 TYPE zeile04_typ.