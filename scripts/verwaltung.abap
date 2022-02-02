*&---------------------------------------------------------------------*
*& Include ZZ_1003_PVERWALTUNG_TOP                  - Modulpool        ZZ_1003_PVERWALTUNG
*&---------------------------------------------------------------------*
PROGRAM zz_1003_pverwaltung MESSAGE-ID zz_1003_messages.


TABLES: zz1003_prosp.

DATA: wa_prosp TYPE zz1003_prosp,
      dynnr    TYPE sy-dynnr,
      ok_code  LIKE sy-ucomm.

FORM db_query.
  SELECT SINGLE *
  FROM zz1003_prosp "Tabla de base de datos.
  INTO CORRESPONDING FIELDS OF wa_prosp
  WHERE prospid = zz1003_prosp-prospid. "pantalla
ENDFORM.

FORM update_db.
  zz1003_prosp = wa_prosp.
  PERFORM db_query.
  UPDATE zz1003_prosp FROM wa_prosp.
ENDFORM.

FORM check_entry.
  IF sy-subrc = 0 AND zz1003_prosp-prospid = wa_prosp-prospid.
    MESSAGE s020 WITH sy-subrc.
    PERFORM db_query.
  ELSE.
    MESSAGE e021 WITH sy-subrc.
  ENDIF.
ENDFORM.

FORM user_query.
  PERFORM db_query.
  IF zz1003_prosp-prospid IS NOT INITIAL.
    IF sy-dbcnt <> 1.
      MESSAGE e009.
    ELSE.
      MESSAGE s007 WITH wa_prosp-title wa_prosp-prospid.
      CALL SCREEN 101.
      MESSAGE e022.
    ENDIF.
  ELSE.
    MESSAGE e013.
  ENDIF.
ENDFORM.

FORM create_entry.
  PERFORM db_query.
  IF zz1003_prosp-prospid IS NOT INITIAL.
    IF sy-subrc <> 0.
      IF sy-dbcnt <> 1.
        CLEAR wa_prosp.
        CLEAR: zz1003_prosp-title,
         zz1003_prosp-von,
         zz1003_prosp-bis.
        LEAVE TO SCREEN 103.
      ELSE.
        MESSAGE 'Prospekt eingeben' TYPE 'I'.
      ENDIF.
    ELSE.
      MESSAGE 'Prospekt bereits vorhanden' TYPE 'E'.
    ENDIF.
  ELSE.
    CLEAR: wa_prosp,
       zz1003_prosp-title,
       zz1003_prosp-von,
       zz1003_prosp-bis.
    LEAVE TO SCREEN 103.
  ENDIF.
ENDFORM.

FORM edit_entry.
  IF sy-subrc = 0.
    CALL SCREEN 102.
  ENDIF.
ENDFORM.

FORM delete_entry.
  DATA ld_answer.
  PERFORM db_query.
  IF zz1003_prosp-prospid IS NOT INITIAL.
    IF sy-subrc = 0.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question = 'Wollen Sie den Prospekt wirklich loeschen?'(p01)
        IMPORTING
          answer        = ld_answer.
      IF ld_answer = '1'.
        IF sy-subrc = 0.
          DELETE zz1003_prosp FROM zz1003_prosp.
          CLEAR: wa_prosp.
          CLEAR: zz1003_prosp.
          MESSAGE 'Prospekt wurde geloescht' TYPE 'S'.
          LEAVE TO SCREEN 100.
        ELSE.
          MESSAGE 'Loeschen fehlgeschlagen.' TYPE 'E'.
          LEAVE TO SCREEN 100.
        ENDIF.
      ELSEIF ld_answer = '2'.
        MESSAGE 'Daten ungeaendert.' TYPE 'S'.
        LEAVE TO SCREEN 100.
      ELSE.
        MESSAGE 'Aktion abgebrochen.' TYPE 'S'.
        LEAVE TO SCREEN 100.
      ENDIF.
    ELSE.
      MESSAGE e009.
    ENDIF.
  ELSE.
    MESSAGE e013.
  ENDIF.
ENDFORM.

FORM save_entry.
  PERFORM db_query.
  "IF sy-subrc = 0.
  IF sy-dbcnt <> 1.
    MODIFY zz1003_prosp FROM zz1003_prosp.
    MESSAGE s012 WITH zz1003_prosp-title.
  ELSE.
    MESSAGE e015.
  ENDIF.
  "ELSE.
  "MESSAGE e015.
  "MESSAGE 'Fehler bei sy-subrc' TYPE 'E'.
  "ENDIF.
ENDFORM.

FORM update_entry.
  PERFORM db_query.
  IF sy-subrc = 0.
    "IF sy-dbcnt <> 1.
    "MESSAGE e019.
    "ELSE.
    UPDATE zz1003_prosp FROM zz1003_prosp.
    MESSAGE s012 WITH zz1003_prosp-title.
    LEAVE TO SCREEN 100.
    "ENDIF.
  ELSE.
    MESSAGE e015.
  ENDIF.
ENDFORM.


FORM delete.
  DELETE zz1003_prosp FROM zz1003_prosp.
ENDFORM.