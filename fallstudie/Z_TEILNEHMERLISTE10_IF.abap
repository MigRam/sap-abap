*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE10_IF              *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste10_if.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Elementare Variablen deklarieren
DATA: tz_pc_grundlagen   TYPE i,
      tz_netzwerktechnik TYPE i,
      tz_sap_grundlagen  TYPE i,
      tz_sonst           TYPE i,
      tz_total           TYPE i.

* Vollständigen Tabelleninhalt ausgeben
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
SKIP.

* Tabelleninhalt selektieren mit Bedingung
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
         WHERE zzkurstitel = 'Netzwerktechnik'
  ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer02-tnummer,
           wa_zteilnehmer02-tname,
           wa_zteilnehmer02-tgeburtsdatum,
           wa_zteilnehmer02-tgeschlecht,
           wa_zteilnehmer02-zzkurstitel.
ENDSELECT.

* Alle Sätze aus der Tabelle lesen,
* aber nur bestimmte Sätze verarbeiten
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-zzkurstitel =
    'PC-Grundlagen'.
    tz_pc_grundlagen = tz_pc_grundlagen + 1.
  ENDIF.
ENDSELECT.
SKIP.
WRITE: / tz_pc_grundlagen,
         'Personen besuchen den Kurs PC-Grundlagen'.

* Alle Sätze der Tabelle lesen,
* Anzahl der Kursteilnehmer grob aufteilen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-zzkurstitel = 'SAP-Grundlagen'.
    tz_sap_grundlagen = tz_sap_grundlagen + 1.
  ELSE.
    tz_sonst = tz_sonst + 1.
  ENDIF.
ENDSELECT.
tz_total = tz_sap_grundlagen + tz_sonst.
SKIP.
WRITE: / 'von den',
       /  tz_total, 'Teilnehmern besuchten',
       /  tz_sap_grundlagen,
          'den Kurs SAP-Grundlagen und',
       /  tz_sonst, 'sonstige Kurse'.

* Wieder benötigte Zähler initialisieren
CLEAR: tz_netzwerktechnik,
       tz_pc_grundlagen,
       tz_sap_grundlagen,
       tz_sonst.

* Alle Sätze der Tabelle lesen,
* Anzahl der Kursteilnehmer fein aufteilen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-zzkurstitel = 'Netzwerktechnik'.
    tz_netzwerktechnik = tz_netzwerktechnik + 1.
  ELSEIF wa_zteilnehmer02-zzkurstitel = 'PC-Grundlagen'.
    tz_pc_grundlagen = tz_pc_grundlagen + 1.
  ELSEIF wa_zteilnehmer02-zzkurstitel = 'SAP-Grundlagen'.
    tz_sap_grundlagen = tz_sap_grundlagen + 1.
  ELSE.
    tz_sonst =  tz_sonst + 1.
  ENDIF.
ENDSELECT.

SKIP.
WRITE: / 'Verteilung der Personen auf die Kurse:',
       /  tz_netzwerktechnik, 'Netzwerktechnik',
       /  tz_pc_grundlagen,   'PC-Grundlagen',
       /  tz_sap_grundlagen,  'SAP-Grundlagen',
       /  tz_sonst,           'sonstige Kurse'.