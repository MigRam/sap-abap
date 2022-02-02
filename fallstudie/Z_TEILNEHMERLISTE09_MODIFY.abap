*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE09_MODIFY          *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste09_modify.

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

* Neuen Datensatz anlegen aus Workarea
tnr = tnr + 1.
CLEAR wa_zteilnehmer02.
wa_zteilnehmer02-tnummer = tnr.
wa_zteilnehmer02-tname = 'Maier'.
wa_zteilnehmer02-tgeburtsdatum = '19980808'.
wa_zteilnehmer02-tgeschlecht = 'M'.
wa_zteilnehmer02-tkurspreis = '999'.
wa_zteilnehmer02-twaehrung = 'EUR'.
wa_zteilnehmer02-zzkfztyp = 'KOMBI'.
wa_zteilnehmer02-zzkurstitel = 'Netzwerktechnik'.
MODIFY zteilnehmer02 FROM @wa_zteilnehmer02.
WRITE: / 'Modify aus Workarea liefert sy-subrc', sy-subrc.

* Zweiten Datensatz ändern
tnr = tnr - 1.
CLEAR wa_zteilnehmer02.
wa_zteilnehmer02-tnummer = tnr.
wa_zteilnehmer02-tname = 'Schmidt'.
wa_zteilnehmer02-tgeburtsdatum = '20000909'.
wa_zteilnehmer02-tgeschlecht = 'M'.
wa_zteilnehmer02-tkurspreis = '999'.
wa_zteilnehmer02-twaehrung = 'USD'.
wa_zteilnehmer02-zzkfztyp = 'KOMBI'.
wa_zteilnehmer02-zzkurstitel = 'Netzwerktechnik'.
MODIFY zteilnehmer02 FROM @wa_zteilnehmer02.
WRITE: / 'Zweiter Modify liefert sy-subrc', sy-subrc.

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
* rollback work.