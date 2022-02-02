*&---------------------------------------------------------------------*
*& Report Z_TEILNEHMERLISTE01
*&
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_teilnehmerliste01.

DATA wa_zteilnehmer TYPE zteilnehmer. " Workarea deklarieren

WRITE 'Dies ist meine erste Liste'.
ULINE.                                " Waagerechter Strich

* Alle Sätze der Tabelle mit allen Feldern
* satzweise in Workarea übertragen,
* Struktur in neuer Zeile ausgeben
SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
  ORDER BY PRIMARY KEY.
  WRITE / wa_zteilnehmer.
ENDSELECT.
SKIP.                             " Eine Leerzeile

* SELECT-Anweisung wie oben,
* einzelne Felder eines Satzes in neuer Zeile ausgeben
SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
  ORDER BY PRIMARY KEY.
  WRITE / wa_zteilnehmer-tgeburtsdatum.
  WRITE   wa_zteilnehmer-tname.
ENDSELECT.
SKIP.                             " Eine Leerzeile

* SELECT-Anweisung wie oben
* Felder ausgeben wie oben, jedoch
* WRITE-Anweisung als Kettensatz
SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
  ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer-tgeburtsdatum,
           wa_zteilnehmer-tname.
ENDSELECT.