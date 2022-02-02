*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE03                 *
*&---------------------------------------------*
*&                                             *
*&---------------------------------------------*

REPORT z_teilnehmerliste03.

* Variablen deklarieren
DATA:
  geschlecht            TYPE c LENGTH  1 VALUE 'W',
  familienname          TYPE zteilnehmer-tname,
  telefon               TYPE n LENGTH  8 VALUE '887766',
  national_vorwahl      TYPE n LENGTH  5 VALUE '09876',
  international_vorwahl TYPE c LENGTH  5 VALUE '+49',
  telefon_international TYPE c LENGTH 25.

* Kontrollausgabe der ursprünglichen Feldinhalte
WRITE / 'Ursprüngliche Feldinhalte'.
WRITE:   30 telefon,
         40 national_vorwahl,
         50 international_vorwahl,
         60 telefon_international.
ULINE.
* SHIFT-Anweisung
WRITE / 'Shift'.
SHIFT telefon LEFT DELETING LEADING '0'.
WRITE 30 telefon.
SHIFT telefon BY 2 PLACES RIGHT.
WRITE /30 telefon.
ULINE.

* REPLACE-Anweisung und -Funktion
WRITE / 'Replace'.
telefon_international = '  887766'.
REPLACE ` ` IN  telefon_international
            WITH national_vorwahl.
WRITE 60 telefon_international.
telefon_international = replace( val = telefon_international
                                 sub = '0'
                                 with = '+49-(0)'
                                 occ  = 1 ).
* Alternativ: REPLACE '0' IN telefon_international WITH '+49-(0)'.
WRITE /60 telefon_international.
REPLACE ` ` IN telefon_international
            WITH `-`.
WRITE /60 telefon_international.
ULINE.

* CONDENSE-Anweisung
WRITE / 'Condense'.
telefon_international = '+49 -(0)9876  887766'.
telefon_international = condense( telefon_international ).
* Alternativ: CONDENSE telefon_international.
WRITE 60 telefon_international.
CONDENSE telefon_international NO-GAPS.
WRITE /60 telefon_international.
ULINE.

* CONCATENATE-Anweisung
WRITE / 'Concatenate'.
telefon = '887766'.
SHIFT telefon LEFT DELETING LEADING '0'.
telefon_international = space.
CONCATENATE international_vorwahl
            national_vorwahl
            telefon
            INTO
            telefon_international
            SEPARATED BY '-'.
* Alternativ:
telefon_international = international_vorwahl
              && `-` && national_vorwahl
              && `-` && telefon.

WRITE 60 telefon_international.
ULINE.

* SPLIT-Anweisung
WRITE / 'Split'.
international_vorwahl = space.
national_vorwahl      = space.
telefon               = space.
SPLIT telefon_international AT '-'
      INTO
        international_vorwahl
        national_vorwahl
        telefon.
WRITE: 30 telefon,
       40 national_vorwahl,
       50 international_vorwahl.
ULINE.

* Direktes Positionieren
WRITE / 'Direktes Positionieren'.
international_vorwahl = space.
international_vorwahl =
              telefon_international(3).
WRITE 50 international_vorwahl.

telefon_international = '+49-(0)9876-887766'.
national_vorwahl      = space.
national_vorwahl      = telefon_international+4(7).
WRITE 40 national_vorwahl.

telefon_international+1(2) = '33'.
WRITE 60 telefon_international.