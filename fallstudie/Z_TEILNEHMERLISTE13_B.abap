*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE13_B               *
*&---------------------------------------------*

REPORT  z_teilnehmerliste13_b.

* Deklarationsteil
INCLUDE z_teilnehmer_deklarationen.
* Selektionsbildschirm deklarieren
INCLUDE zteilnehmer13_b_selektionsbild.

START-OF-SELECTION.
* In anderen Report über Selektionsbildschirm
* verzweigen ohne Rückkehr
  PERFORM absprung_ow.
* Unterprogramm eines anderen Reports aufrufen
* (externes Unterprogramm)
* In anderen Report über Selektionsbildschirm
* verzweigen mit Rückkehr
  IF rsmw IS NOT INITIAL.
    PERFORM absprung_mw.
  ENDIF.

END-OF-SELECTION.
  SKIP.
  WRITE: / 'Hauptprogramm Z_TEILNEHMERLISTE13_B',
           'beendet'.

*&---------------------------------------------*
*&      Form  absprung_ow
*&---------------------------------------------*
FORM absprung_ow.
  IF rsow IS NOT INITIAL.
* Aufruf mit Selektionsbildschirm
* ohne Parameterübergabe
    SUBMIT z_teilnehmerliste13_a
      VIA SELECTION-SCREEN.
  ENDIF.
  IF rsowas IS NOT INITIAL.
* Aufruf mit Selektionsbildschirm mit
* Parameterübergabe
    SUBMIT z_teilnehmerliste13_a
       WITH par02 = 'X'
      WITH par03 = 'X'
      VIA SELECTION-SCREEN.
  ENDIF.
  IF rsowih IS NOT INITIAL.
* Aufruf ohne Selektionsbildschirm mit Parameterübergabe
    SUBMIT z_teilnehmerliste13_a
          WITH par02 = 'X'.
  ENDIF.
ENDFORM.                    " absprung_ow

*&---------------------------------------------*
*&      Form  absprung_mw
*&---------------------------------------------*
FORM absprung_mw .
  GET PARAMETER ID 'RID' FIELD progname.
  SET PARAMETER ID 'Z_TEST' FIELD progname.
  PERFORM itab04_fuellen IN PROGRAM
                            z_teilnehmerliste13_a
            USING itab04
                  zzaehler_itab04.
  READ TABLE itab04 INTO wa_itab04
    WITH KEY mandant = sy-mandt
             tnummer = 3.
  IF sy-subrc = 0.
    WRITE: / 'Ausgabe aus Programm',
             'Z_TEILNEHMERLISTE13_B',
           / 'Teilnehmer Nummer',
             wa_itab04-tnummer,
             '=', wa_itab04-tname .
  ENDIF.
  EXPORT itab04 TO MEMORY ID progname.
  SUBMIT z_teilnehmerliste13_a AND RETURN.
ENDFORM.                    " absprung_mw