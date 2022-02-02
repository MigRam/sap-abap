*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE12_ITAB_WA         *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste12_itab.

* Workarea deklarieren
DATA wa_zteilnehmer02 TYPE zteilnehmer02.

* Felder deklarieren
DATA: zeilen_itab01 TYPE i.

* Datentypen für Zeilen deklarieren
TYPES: BEGIN OF zeile01_typ,
        zzkurstitel TYPE  zteilnehmer02-zzkurstitel,
        tkurspreis TYPE zteilnehmer02-tkurspreis,
       END OF zeile01_typ.

TYPES BEGIN OF zeile02_typ.
INCLUDE TYPE zeile01_typ.
TYPES minteiln TYPE i.
TYPES END OF zeile02_typ.

TYPES: BEGIN OF zeile03_typ,
         bezeichnung LIKE zteilnehmer02-zzkurstitel,
         preis TYPE zteilnehmer02-tkurspreis,
         maxteil TYPE i,
END OF zeile03_typ.

TYPES zeile04_typ TYPE zteilnehmer02.

* Datentypen für interne Tabellen deklarieren
TYPES itab01_typ TYPE STANDARD TABLE  OF zeile01_typ.
TYPES itab02_typ TYPE STANDARD TABLE OF zeile02_typ.
TYPES itab03_typ TYPE STANDARD TABLE OF zeile03_typ.
TYPES itab04_typ TYPE STANDARD TABLE OF zeile04_typ.

* Interne Tabellen deklarieren ohne Kopfzeile
DATA itab01 TYPE itab01_typ.
DATA itab02 TYPE itab02_typ.
DATA itab03 TYPE itab03_typ.
DATA itab04 TYPE itab04_typ.

* Workareas für interne Tabellen deklarieren
DATA wa_itab01 TYPE zeile01_typ.
DATA wa_itab02 TYPE zeile02_typ.
DATA wa_itab03 TYPE zeile03_typ.
DATA wa_itab04 TYPE zeile04_typ.

* Selektionsbild deklarieren

*----------------------------------------------*
* INITIALIZATION. (entfällt)

*----------------------------------------------*
* AT SELECTION-SCREEN. (entfällt)

*----------------------------------------------*
START-OF-SELECTION.
* Datenbanktabelle zeilenweise lesen und ITAB01
* über Workarea füllen
  SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02.
    MOVE-CORRESPONDING wa_zteilnehmer02 TO wa_itab01.
    APPEND wa_itab01 TO itab01.
  ENDSELECT.

* Datenbanktabelle lesen und ITAB02 auf einmal füllen
  SELECT * FROM zteilnehmer02
    INTO CORRESPONDING FIELDS OF TABLE @itab02.

* Datenbanktabelle lesen und ITAB03 über Workarea und Zuweisung füllen
  wa_itab03-maxteil = 10.
  SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02.
    wa_itab03-bezeichnung =  wa_zteilnehmer02-zzkurstitel.
    wa_itab03-preis = wa_zteilnehmer02-tkurspreis.
    APPEND  wa_itab03 TO itab03.
  ENDSELECT.

* Datenbanktabelle lesen und ITAB04 blockweise füllen
  SELECT * FROM zteilnehmer02
    INTO CORRESPONDING FIELDS OF TABLE @itab04.

*----------------------------------------------*
END-OF-SELECTION.
* Anzahl der Rumpfzeileneinträge für ITAB01
* lesen und ausgeben
  DESCRIBE TABLE itab01 LINES zeilen_itab01.
  SKIP.
  WRITE: / 'Anzahl Zeilen itab01:', zeilen_itab01.

* Workarea initialisieren, füllen und neue Zeile an ITAB01 anhängen
  CLEAR wa_itab01.
  zeilen_itab01 = zeilen_itab01 + 1.
  wa_itab01-zzkurstitel = 'LINUX-GRUNDLAGEN'.
  wa_itab01-tkurspreis  = '456.78'.
  INSERT wa_itab01 INTO itab01 INDEX zeilen_itab01.

* ITAB01 in Liste ausgeben
  SKIP.
  WRITE: / 'sy-tabix, itab01-zzkurstitel, itab01-tkurspreis'. "Überschrift
  LOOP AT itab01 INTO wa_itab01.
    WRITE: / sy-tabix, wa_itab01-zzkurstitel, wa_itab01-tkurspreis.
  ENDLOOP.

* ITAB02 verarbeiten und in Liste ausgeben
  SKIP.
  WRITE: / 'itab02-zzkurstitel, itab02-tkurspreis, itab02-minteiln'.
  LOOP AT itab02 INTO wa_itab02 WHERE  zzkurstitel = 'PC-GRUNDLAGEN'.
    wa_itab02-minteiln = 2.
    WRITE: / wa_itab02-zzkurstitel, wa_itab02-tkurspreis,  wa_itab02-minteiln.
  ENDLOOP.

* ITAB03 verarbeiten, ausgeben und Rumpf bearbeiten
  SKIP.
  WRITE: / 'itab03-bezeichnung, itab03-preis, itab03-maxteil'.
  LOOP AT itab03 INTO wa_itab03.
    IF wa_itab03-bezeichnung = 'PC-GRUNDLAGEN'.
      wa_itab03-preis = 567.
      MODIFY itab03 FROM wa_itab03.
    ENDIF.
    WRITE: / wa_itab03-bezeichnung, wa_itab03-preis, wa_itab03-maxteil.
  ENDLOOP.

* Einen Satz aus ITAB03 mit Index lesen und ausgeben
  READ TABLE itab03 INDEX 3 INTO wa_itab03.
  SKIP.
  WRITE: / 'gelesen von itab03', sy-tabix NO-GAP, '. Zeile:',
            wa_itab03-bezeichnung, wa_itab03-preis, wa_itab03-maxteil.

* Einen Satz aus ITAB04 mit Schlüssel lesen und ausgeben
  READ TABLE itab04 INTO wa_itab04 WITH KEY mandant = sy-mandt tnummer = 5.
  SKIP.
  WRITE: / 'gelesen von itab04',
            wa_itab04-mandant, wa_itab04-tnummer, wa_itab04-tname,   wa_itab04-tgeburtsdatum, wa_itab04-tgeschlecht.

* Einen Satz aus ITAB01 über Index lesen, löschen, protokollieren
  READ TABLE itab01 INTO wa_itab01 INDEX 3.
  DELETE itab01 INDEX 3.
  SKIP.
  WRITE: / 'gelöscht von itab01', sy-tabix NO-GAP, '. Zeile:',
            wa_itab01-zzkurstitel, wa_itab01-tkurspreis.

* Gezielt einzelnen Satz aus ITAB02 über Schlüssel lesen, löschen, protokollieren
  READ TABLE itab02 INTO wa_itab02 WITH KEY zzkurstitel = 'SAP-Grundlagen'.
  DELETE TABLE itab02 FROM wa_itab02.
  SKIP.
  WRITE: / 'gelöscht von itab02', sy-tabix NO-GAP, '. Zeile:', wa_itab02-zzkurstitel.

* Wirkung von CLEAR und FREE bei internen Tabellen ohne Kopfzeile
  BREAK-POINT.
  CLEAR wa_itab01.   "initalisiert Workarea
  CLEAR itab01.      "löscht Rumpfzeilen

  CLEAR wa_itab03.   "initalisiert Workarea
  FREE itab03.       "löscht Rumpfzeilen und gibt Platz frei