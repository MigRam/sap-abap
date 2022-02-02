*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE10_WHILE           *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste10_while.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Felder deklarieren
DATA: jahr004 TYPE i,
      jahr100 TYPE i,
      jahr400 TYPE i,
      sek     TYPE i.

sek = 10.
* Rückwärtslaufender Sekundenzähler
WHILE sek > 0.
  WRITE: sek.
  sek = sek - 1.
ENDWHILE.
WRITE: / sek.
SKIP.

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

* Schleife über alle Sätze der Tabelle, Feld auf Intitialwert hin prüfen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeburtsdatum IS INITIAL.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
              'fehlt Geburtsdatum, bitte nachtragen'.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife über alle Sätze der Tabelle, Feld auf Intervall hin prüfen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeburtsdatum BETWEEN
                  '19910101' AND '19911231'.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
              wa_zteilnehmer02-tgeburtsdatum.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife über alle Sätze der Tabelle, Prüfung mit logischem Oder
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-zzkurstitel =
    'SAP-Finanzwesen' OR
     wa_zteilnehmer02-zzkurstitel =
    'SAP-Grundlagen'.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
              wa_zteilnehmer02-zzkurstitel.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife über alle Sätze der Tabelle, Prüfung mit logischem Und
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeschlecht = 'M' AND
     wa_zteilnehmer02-zzkurstitel =
                  'PC-GRUNDLAGEN'.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
              wa_zteilnehmer02-tgeschlecht,
              wa_zteilnehmer02-zzkurstitel.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife über alle Sätze der Tabelle, Prüfung mit NOT
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  IF NOT wa_zteilnehmer02-zzkurstitel(3) = 'SAP'.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-zzkurstitel.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife über alle Sätze der Tabelle, Schaltjahr prüfen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  jahr004 =
    wa_zteilnehmer02-tgeburtsdatum(4) MOD 4.
  jahr100 =
    wa_zteilnehmer02-tgeburtsdatum(4) MOD 100.
  jahr400 =
    wa_zteilnehmer02-tgeburtsdatum(4) MOD 400.
  IF NOT wa_zteilnehmer02-tgeburtsdatum IS INITIAL.
    IF jahr400 = 0 OR jahr004 = 0 AND
                   NOT jahr100 = 0.
      WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
                wa_zteilnehmer02-zzkurstitel,
                wa_zteilnehmer02-tgeburtsdatum(4).
    ENDIF.
  ENDIF.
ENDSELECT.
SKIP.