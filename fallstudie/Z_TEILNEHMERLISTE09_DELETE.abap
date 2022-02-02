*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE09_DELETE          *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste09_delete.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Zeichenketten deklarieren
DATA: tnr TYPE zteilnehmer02-tnummer.

* Tabellenzeilen vor der Ver�nderung der Tabelle
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer02-tnummer,
           wa_zteilnehmer02-tname,
           wa_zteilnehmer02-tgeburtsdatum,
           wa_zteilnehmer02-tgeschlecht,
           wa_zteilnehmer02-tkurspreis,
           wa_zteilnehmer02-twaehrung,
           wa_zteilnehmer02-zzkfztyp,
           wa_zteilnehmer02-zzkurstitel.
ENDSELECT.
tnr = wa_zteilnehmer02-tnummer.
SKIP.

* Datensatz l�schen aus Workarea
CLEAR: wa_zteilnehmer02.
wa_zteilnehmer02-tnummer = tnr.
DELETE zteilnehmer02 FROM @wa_zteilnehmer02.
WRITE: / 'Delete aus Workarea liefert sy-subrc', sy-subrc.

* Datensatz l�schen mit Bedingung
DELETE FROM zteilnehmer02 WHERE zzkurstitel =
                          'Netzwerktechnik'.
WRITE: / 'Delete mit Bedingung liefert sy-subrc', sy-subrc.

* Tabelleninhalt nach der Ver�nderung
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer02-tnummer,
           wa_zteilnehmer02-tname,
           wa_zteilnehmer02-tgeburtsdatum,
           wa_zteilnehmer02-tgeschlecht,
           wa_zteilnehmer02-tkurspreis,
           wa_zteilnehmer02-twaehrung,
           wa_zteilnehmer02-zzkfztyp,
           wa_zteilnehmer02-zzkurstitel.
ENDSELECT.

* Alle Datens�tze der Tabelle l�schen
DELETE FROM zteilnehmer02.
WRITE: / 'Delete aller Zeilen liefert sy-subrc', sy-subrc.
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer02-tnummer,
           wa_zteilnehmer02-tname,
           wa_zteilnehmer02-tgeburtsdatum,
           wa_zteilnehmer02-tgeschlecht,
           wa_zteilnehmer02-tkurspreis,
           wa_zteilnehmer02-twaehrung,
           wa_zteilnehmer02-zzkfztyp,
           wa_zteilnehmer02-zzkurstitel.
ENDSELECT.
* rollback work.