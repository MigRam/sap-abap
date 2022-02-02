*&---------------------------------------------------------------------*
*& Report ZZ_1003_SUCHE
*&---------------------------------------------------------------------*
*& Feature: Suchfunktion
*&---------------------------------------------------------------------*
REPORT zz_1003_suche MESSAGE-ID zz_1003_messages.

TABLES sscrfields.

DATA: wa                    TYPE zz_1003_sview,
      free_seats            TYPE i,
      max_seats             TYPE i,
      flight_class(15)      TYPE c,
      disposability_msg(70) TYPE c,
      hits                  TYPE i,
      itab                  TYPE STANDARD TABLE OF zz_1003_sview.

SELECTION-SCREEN BEGIN OF SCREEN 500 AS WINDOW.

SELECTION-SCREEN COMMENT 35(20) TEXT-001.
SELECTION-SCREEN ULINE.
SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN COMMENT 1(60) TEXT-002.
SELECTION-SCREEN ULINE /1(83).
SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK bl1.
SELECT-OPTIONS pa_fdate FOR wa-fldate.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN BEGIN OF BLOCK bl2.
SELECTION-SCREEN COMMENT 1(60) TEXT-003.
SELECT-OPTIONS: pa_cf  FOR wa-countryfr NO INTERVALS,
                pa_cityf FOR wa-cityfrom NO INTERVALS.
SELECTION-SCREEN END OF BLOCK bl2.

SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN BEGIN OF BLOCK bl3.
SELECTION-SCREEN COMMENT 1(60) TEXT-004.
SELECT-OPTIONS: pa_ct   FOR wa-countryto NO INTERVALS,
                pa_cityt FOR wa-cityto NO INTERVALS.
SELECTION-SCREEN END OF BLOCK bl3.

SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN BEGIN OF BLOCK bl4.
PARAMETERS pa_class TYPE sbook-class.
SELECT-OPTIONS: pa_price FOR wa-price.
SELECTION-SCREEN END OF BLOCK bl4.

SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN PUSHBUTTON /02(17) TEXT-005 USER-COMMAND btn.

SELECTION-SCREEN END OF SCREEN 500.

AT SELECTION-SCREEN.

  IF sscrfields-ucomm = 'BTN'.
    CLEAR sscrfields-ucomm.
    REFRESH pa_fdate.
    REFRESH pa_cf.
    REFRESH pa_ct.
    REFRESH pa_cityf.
    REFRESH pa_cityt.
    REFRESH pa_price.
    pa_class = ''.
  ENDIF.

START-OF-SELECTION.

  CALL SELECTION-SCREEN 500 STARTING AT 6 1.

  SELECT COUNT( * )
    FROM zz_1003_sview
    INTO hits
    WHERE fldate IN pa_fdate
    AND price IN pa_price
    AND countryfr IN  pa_cf
    AND cityfrom IN pa_cityf
    AND countryto IN pa_ct
    AND cityto IN pa_cityt.

  CASE flight_class.
    WHEN 'Y'.
      disposability_msg = '(Freie Plätze in der Economy Class)'.
    WHEN 'C'.
      disposability_msg = '(Freie Plätze in der Business Class)'.
    WHEN 'F'.
      disposability_msg = '(Freie Plätze in der First Class)'.
    WHEN OTHERS.
      disposability_msg = '(Freie Plätze in allen Klassen)'.
  ENDCASE.

  CASE hits.
    WHEN 0.
      MESSAGE e006.
    WHEN OTHERS.
      WRITE:/ 'Es gab', hits, 'Suchtreffer. Diese Flüge wurden gefunden:', disposability_msg.
  ENDCASE.

  SKIP.

  FORMAT COLOR 2.
  ULINE (115).
  WRITE:/ '|', 'Von', 17'|',
  18'Nach', 31'|',
  32'Datum', 45'|',
  46'Freie Pl.', 60'|',
  61'Klasse', 82'|',
  83'Gesamtpl.', 93'|',
  94'Gesellschaft', 115'|'.
  WRITE:/ sy-uline(115).
  FORMAT RESET.

  SELECT * FROM zz_1003_sview
   INTO wa
   WHERE fldate IN pa_fdate
    AND price IN pa_price
    AND countryfr IN pa_cf
    AND cityfrom IN pa_cityf
    AND countryto IN pa_ct
    AND cityto IN pa_cityt
   ORDER BY cityfrom ASCENDING.

    CASE pa_class.
      WHEN 'Y'.
        flight_class = 'Economy Class'.
        max_seats = wa-seatsmax.
        free_seats = wa-seatsmax - wa-seatsocc.
      WHEN 'C'.
        flight_class = 'Business Class'.
        max_seats = wa-seatsmax_B.
        free_seats = wa-seatsmax_B - wa-seatsocc_B.
      WHEN 'F'.
        flight_class = 'First Class'.
        max_seats = wa-seatsmax_F.
        free_seats = wa-seatsmax_F - wa-seatsocc_F.
      WHEN OTHERS.
        flight_class = 'not available'.
        free_seats = ( wa-seatsmax - wa-seatsocc ) + ( wa-seatsmax_B - wa-seatsocc_B ) + ( wa-seatsmax_F - wa-seatsocc_F ).
        max_seats = wa-seatsmax + wa-seatsmax_B + wa-seatsmax_F.
    ENDCASE.

    CASE free_seats.
      WHEN 0.
        FORMAT COLOR 6.
        WRITE:/ '|', wa-cityfrom UNDER 'Von', 20'|',
        wa-cityto UNDER 'Nach', 31'|',
        wa-fldate UNDER 'Datum', 45'|',
        free_seats UNDER 'Freie Pl.', 60'|',
        flight_class UNDER 'Klasse', 82'|',
        max_seats UNDER 'Gesamtpl.', 93'|',
        wa-carrname UNDER 'Gesellschaft', 115'|'.
        ULINE /(115).
        FORMAT COLOR 6 RESET.
      WHEN OTHERS.
        FORMAT COLOR 2.
        WRITE:/ '|', wa-cityfrom UNDER 'Von', 17'|',
        wa-cityto UNDER 'Nach', 31'|',
        wa-fldate UNDER 'Datum', 45'|',
        free_seats UNDER 'Freie Pl.', 60'|',
        flight_class UNDER 'Klasse', 82'|',
        max_seats UNDER 'Gesamtpl.', 93'|',
        wa-carrname UNDER 'Gesellschaft', 115'|'.
        ULINE /(115).
        FORMAT COLOR 2 RESET.
    ENDCASE.

  ENDSELECT.