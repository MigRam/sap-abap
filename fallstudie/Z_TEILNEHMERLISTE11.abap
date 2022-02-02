*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE11                 *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste11.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Felder deklarieren
DATA: jahr004 TYPE i,
      jahr100 TYPE i,
      jahr400 TYPE i.

* Selektionsbild gestalten
PARAMETERS: sek      TYPE i DEFAULT 10 OBLIGATORY,
            geschlec TYPE
              zteilnehmer02-tgeschlecht
              OBLIGATORY VALUE CHECK,
            kursti   TYPE
              zteilnehmer02-zzkurstitel
              DEFAULT 'SAP-Grundlagen'
              LOWER CASE,
            vollstli AS CHECKBOX,

            initialw RADIOBUTTON GROUP rad1,
            non_sap  RADIOBUTTON GROUP rad1,
            schaltja RADIOBUTTON GROUP rad1.

SELECT-OPTIONS gebdat FOR
  wa_zteilnehmer02-tgeburtsdatum NO-EXTENSION.

* R�ckw�rtslaufender Sekundenz�hler
WHILE sek > 0.
  WRITE: sek.
  sek = sek - 1.
ENDWHILE.
WRITE: / sek.
SKIP.

* Ankreuzfeld pr�fen
IF NOT vollstli IS INITIAL.
* Vollst�ndigen Tabelleninhalt ausgeben
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
ENDIF.

* Radiobutton initialw pr�fen
IF NOT initialw IS INITIAL.
* Schleife �ber alle S�tze der Tabelle,
*    Feld auf Intitialwert hin pr�fen
  SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
    IF wa_zteilnehmer02-tgeburtsdatum IS INITIAL.
      WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
                wa_zteilnehmer02-tname,
               'fehlt Geburtsdatum, bitte nachtragen'.
    ENDIF.
  ENDSELECT.
  SKIP.
ENDIF.

* Schleife �ber alle S�tze der Tabelle,
* Selektionstabelle pr�fen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeburtsdatum IN gebdat.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
              wa_zteilnehmer02-tgeburtsdatum.
  ENDIF.
ENDSELECT.
SKIP.

* Schleife �ber alle S�tze der Tabelle,
* logisches Und pr�fen
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
  ORDER BY PRIMARY KEY.
  IF wa_zteilnehmer02-tgeschlecht = geschlec AND
     wa_zteilnehmer02-zzkurstitel = kursti.
    WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
              wa_zteilnehmer02-tname,
             wa_zteilnehmer02-tgeschlecht,
              wa_zteilnehmer02-zzkurstitel.
  ENDIF.
ENDSELECT.
SKIP.

* Radiobutton non_sap pr�fen
IF NOT non_sap IS INITIAL.
* Schleife �ber alle S�tze der Tabelle,
* logisches NOT pr�fen
  SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
    IF NOT wa_zteilnehmer02-zzkurstitel(3) = 'SAP'.
      WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
                wa_zteilnehmer02-zzkurstitel.
    ENDIF.
  ENDSELECT.
  SKIP.
ENDIF.

* Radiobutton schaltja pr�fen
IF NOT schaltja IS INITIAL.
* Schleife �ber alle S�tze der Tabelle,
* Schaltjahr pr�fen
  SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
    ORDER BY PRIMARY KEY.
    jahr004 = wa_zteilnehmer02-tgeburtsdatum(4) MOD 4.
    jahr100 = wa_zteilnehmer02-tgeburtsdatum(4) MOD 100.
    jahr400 = wa_zteilnehmer02-tgeburtsdatum(4) MOD 400.
    IF NOT wa_zteilnehmer02-tgeburtsdatum IS
      INITIAL.
      IF jahr400 = 0 OR
         jahr004 = 0 AND NOT jahr100 = 0.
        WRITE: / 'TNr.', wa_zteilnehmer02-tnummer,
                 wa_zteilnehmer02-zzkurstitel,
                 wa_zteilnehmer02-tgeburtsdatum(4).
      ENDIF.
    ENDIF.
  ENDSELECT.
  SKIP.
ENDIF.