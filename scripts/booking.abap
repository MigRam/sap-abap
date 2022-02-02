FUNCTION z_1003_f_calc.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IM_OPERAND1) TYPE  I
*"     VALUE(IM_OPERAND2) TYPE  I
*"     VALUE(IM_OPERATOR) TYPE  C
*"  EXPORTING
*"     VALUE(EX_ERGEBNIS) TYPE  I
*"  EXCEPTIONS
*"      ZERO_DIVISION
*"      INVALID_OPERATOR
*"      OTHER_EXCEPTION
*"----------------------------------------------------------------------

  CASE im_operator.
    WHEN '+'.
      ex_ergebnis = im_operand1 + im_operand2.
    WHEN '-'.
      ex_ergebnis = im_operand1 - im_operand2.
    WHEN '*'.
      ex_ergebnis = im_operand1 * im_operand2.
    WHEN '/'.
      IF im_operand2 = 0.
        RAISE zero_division.
      ELSE.
        ex_ergebnis = im_operand1 / im_operand2.
      ENDIF.
    WHEN '%'.
      IF im_operand2 = 0.
        RAISE zero_division.
      ELSE.
        ex_ergebnis = im_operand1 DIV im_operand2.
      ENDIF.
    WHEN OTHERS.
      RAISE invalid_operator.
  ENDCASE.

ENDFUNCTION.

-----------------------------------------------------------------------


FUNCTION z_1003_get_fluege.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IM_CARRID) TYPE  S_CARR_ID
*"  EXPORTING
*"     REFERENCE(EX_LISTE) TYPE  ZZ_1003_FLISTE
*"  EXCEPTIONS
*"      SQL_ERROR
*"      NO_AUTH
*"----------------------------------------------------------------------
  AUTHORITY-CHECK OBJECT 'S_CARRID'
   ID 'CARRID' FIELD im_carrid
   ID 'ACTVT' FIELD '03'.
  IF sy-subrc <> 0.
    RAISE no_auth.
  ENDIF.
  SELECT *
    FROM spfli
    INTO TABLE ex_liste
    WHERE carrid = im_carrid.
  IF sy-subrc <> 0.
    RAISE sql_error.
  ENDIF.
ENDFUNCTION.


#############################

FUNCTION z_1003_sangebot.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(CARRID1) TYPE  SPFLI-CARRID
*"     REFERENCE(CONNID1) TYPE  SPFLI-CONNID
*"     REFERENCE(CARRID2) TYPE  SPFLI-CARRID
*"     REFERENCE(CONNID2) TYPE  SPFLI-CONNID
*"  EXPORTING
*"     REFERENCE(VERFUEGBAR) TYPE  INTEGER4
*"----------------------------------------------------------------------

  CLEAR verfuegbar.

  DATA: hinflug            TYPE TABLE OF sflight,
        rueckflug          TYPE TABLE OF sflight,
        is_hinflug_found   TYPE abap_bool,
        is_rueckflug_found TYPE abap_bool.


  FIELD-SYMBOLS:
    <hinflug>   TYPE sflight,
    <rueckflug> TYPE sflight.

  SELECT * FROM sflight
    INTO TABLE hinflug
    WHERE carrid = carrid1
    AND connid = connid1.

  SELECT * FROM sflight
    INTO TABLE rueckflug
    WHERE connid = connid2
    AND carrid = carrid2.

  is_hinflug_found = abap_false.
  is_rueckflug_found = abap_false.

  LOOP AT hinflug ASSIGNING <hinflug>.
    IF ( ( <hinflug>-seatsmax - <hinflug>-seatsocc ) + ( <hinflug>-seatsmax_B - <hinflug>-seatsocc_B ) + ( <hinflug>-seatsmax_F - <hinflug>-seatsocc_F ) ) > 0.
      is_hinflug_found = abap_true.
      EXIT.
    ENDIF.
  ENDLOOP.

  LOOP AT rueckflug ASSIGNING <rueckflug>.
    IF ( ( <rueckflug>-seatsmax - <rueckflug>-seatsocc ) + ( <rueckflug>-seatsmax_B - <rueckflug>-seatsocc_B ) + ( <rueckflug>-seatsmax_F - <rueckflug>-seatsocc_F ) ) > 0.
      is_rueckflug_found = abap_true.
      EXIT.
    ENDIF.
  ENDLOOP.

  IF is_hinflug_found NE abap_true OR is_rueckflug_found NE abap_true.
    verfuegbar = 0.
  ELSE.
    verfuegbar = 1.
  ENDIF.
ENDFUNCTION.