*&---------------------------------------------------------------------*
*& Report Z_TEILNEHMERLISTE01_DEBUG
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT Z_TEILNEHMERLISTE01_DEBUG.

* Workarea deklarieren
DATA: wa_zteilnehmer TYPE zteilnehmer.
WRITE 'Dies ist meine erste Liste'.
ULINE.                             " waagerechter Strich

SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
    ORDER BY PRIMARY KEY.
  WRITE / wa_zteilnehmer.
ENDSELECT.
SKIP.                              " 1 Leerzeile

SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
    ORDER BY PRIMARY KEY.
  WRITE / wa_zteilnehmer-tgeburtsdatum.
  WRITE   wa_zteilnehmer-tname.
ENDSELECT.
SKIP.                              " 1 Leerzeile

SELECT * FROM zteilnehmer INTO @wa_zteilnehmer
    ORDER BY PRIMARY KEY.
  WRITE: / wa_zteilnehmer-tgeburtsdatum,
           wa_zteilnehmer-tname.
ENDSELECT.

DATA zteilnehmer_itab TYPE
  TABLE OF zteilnehmer.

SELECT * FROM zteilnehmer
  INTO TABLE @zteilnehmer_itab
    ORDER BY PRIMARY KEY.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program      = 'Z_TEILNEHMERLISTE01_DEBUG'
    i_callback_user_command = 'CALLBACK_USER_COMMAND'
    i_structure_name        = 'ZTEILNEHMER'
  TABLES
    t_outtab                = zteilnehmer_itab.

FORM callback_user_command USING r_ucomm
                            LIKE sy-ucomm
                                 rs_selfield
                            TYPE slis_selfield.
  DATA msgstring TYPE string. " Variable für Nachricht
  CONCATENATE 'User-command' r_ucomm " Nachricht aufbauen
    'wurde ausgelöst' INTO msgstring
    SEPARATED BY space.
  MESSAGE msgstring TYPE 'I'. " Nachricht anzeigen
ENDFORM.                      "user_command