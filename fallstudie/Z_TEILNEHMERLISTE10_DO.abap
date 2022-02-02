*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE10_DO              *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste10_do.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Felder deklarieren
DATA: min TYPE i,
      sek TYPE i,
      std TYPE i.

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

* Schleife über alle Sätze der Tabelle  mit Prüfung im Schleifenkörper
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeburtsdatum LT '19910101'.
    CONTINUE.
  ENDIF.
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

SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  CHECK wa_zteilnehmer02-tgeschlecht = 'W'.
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

* Ablauflogik für Zeitmesser mit Abbruch durch EXIT
WRITE: / std, min, sek. "sy-index.
SKIP.

DO 24 TIMES.
  IF sy-index = 3.
    EXIT.
  ENDIF.
  min = 0.
  DO 60 TIMES.
    IF sy-index = 3.
      EXIT.
    ENDIF.
    sek = 0.
    DO 60 TIMES.
      WRITE: / std, min, sek.
      sek = sek + 1.
      IF sy-index = 3.
        EXIT.
      ENDIF.
    ENDDO.
    min = min + 1.
  ENDDO.
  std = std + 1.
ENDDO.
SKIP.
WRITE: / std, min, sek.

* Programmabbruch
EXIT.

WRITE: / std, min, sek.
SKIP.

* Ablauflogik für Zeitmesser mit 24 Stunden, 60 Minuten und 60 Sekunden
DO 24 TIMES.
  min = 0.
  DO 60 TIMES.
    sek = 0.
    DO 60 TIMES.
      WRITE: / std, min, sek.
      sek = sek + 1.
    ENDDO.
    min = min + 1.
  ENDDO.
  std = std + 1.
ENDDO.
SKIP.

WRITE: / std, min, sek.