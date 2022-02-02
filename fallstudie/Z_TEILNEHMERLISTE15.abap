*&---------------------------------------------------------------------*
*& Report Z_TEILNEHMERLISTE15
*&---------------------------------------------------------------------*
REPORT z_teilnehmerliste15.

START-OF-SELECTION.
  PERFORM main.

* Hauptroutine
FORM main.
* Daten in interne Tabelle lesen
  SELECT
   kurstitel,
   teilnehmername,
   kurspreis,
   waehrung,
   \_currency-decimals           AS decimals,
   \_currency\_text-currencyname AS currencyname
   FROM zteiln_a
   WHERE kurspreis > 100
     AND \_currency\_text-language = @sy-langu
   ORDER BY kurstitel ASCENDING
   INTO TABLE @DATA(lt_data).   " Inline-Deklaration

  DATA:
    ls_data LIKE LINE OF lt_data.
  LOOP AT lt_data INTO ls_data.
    WRITE: / ls_data-kurstitel,
             ls_data-teilnehmername,
             ls_data-kurspreis,
             ls_data-waehrung,
             ls_data-decimals,
             ls_data-currencyname.
  ENDLOOP.
ENDFORM.