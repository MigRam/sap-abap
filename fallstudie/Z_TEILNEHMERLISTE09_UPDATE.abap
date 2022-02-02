*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE09_UPDATE          *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste09_update.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Zeichenketten deklarieren
DATA: tnr TYPE zteilnehmer02-tnummer.

* Tabellenzeilen vor der Veränderung der Tabelle
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

* Datensatz ändern aus Workarea
tnr = tnr - 2.
CLEAR wa_zteilnehmer02.
wa_zteilnehmer02-tnummer = tnr.
wa_zteilnehmer02-tname = 'Maier'.
wa_zteilnehmer02-tgeburtsdatum = '19980808'.
wa_zteilnehmer02-tgeschlecht = 'M'.
wa_zteilnehmer02-tkurspreis = '888'.
wa_zteilnehmer02-twaehrung = 'EUR'.
wa_zteilnehmer02-zzkfztyp = 'KOMBI'.
wa_zteilnehmer02-zzkurstitel = 'Netzwerktechnik'.
UPDATE zteilnehmer02 FROM @wa_zteilnehmer02.
WRITE: / 'Update aus Workarea liefert sy-subrc', sy-subrc.

* Zweiten Datensatz ändern aus Workarea
tnr = tnr - 1.
CLEAR wa_zteilnehmer02.
wa_zteilnehmer02-tnummer = tnr.
wa_zteilnehmer02-tname = 'Schmidt'.
wa_zteilnehmer02-tgeburtsdatum = '19990909'.
wa_zteilnehmer02-tgeschlecht = 'M'.
wa_zteilnehmer02-tkurspreis = '999'.
wa_zteilnehmer02-twaehrung = 'EUR'.
wa_zteilnehmer02-zzkfztyp = 'KOMBI'.
wa_zteilnehmer02-zzkurstitel = 'Netzwerktechnik'.
UPDATE zteilnehmer02 FROM @wa_zteilnehmer02.
WRITE: / 'Zweiter Update liefert sy-subrc', sy-subrc.

* Tabelleninhalt nach der Veränderung
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
rollback work.