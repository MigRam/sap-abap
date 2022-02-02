*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE02                 *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT z_teilnehmerliste02.

* Variablen deklarieren
DATA zahl01                     TYPE p DECIMALS 2 VALUE '4.56'.
DATA zahl02                     LIKE zahl01       VALUE '5.67'.
DATA ergebnis_addition          LIKE zahl01.
DATA ergebnis_subtraktion       LIKE zahl01.
DATA ergebnis_multiplikation    LIKE zahl01.
DATA ergebnis_division_genau    LIKE zahl01.
DATA ergebnis_division_ganzzahl LIKE zahl01.
DATA ergebnis_division_rest     LIKE zahl01.

* Verarbeitungsteil
zahl01 = zahl01 + 1.
zahl02 = zahl01 + 2.
ergebnis_addition          = zahl01 + zahl02.
ergebnis_subtraktion       = zahl01 - zahl02.
ergebnis_multiplikation    = zahl01 * zahl02.
ergebnis_division_genau    = zahl02 / zahl01.
ergebnis_division_ganzzahl = zahl02 DIV zahl01.
ergebnis_division_rest     = zahl02 MOD zahl01.

* Ausgabeteil
WRITE: / 'zahl01',                      zahl01,
       / 'zahl02',                      zahl02,
       / 'ergebnis_addition:',          ergebnis_addition,
       / 'ergebnis_subtraktion:',       ergebnis_subtraktion,
       / 'ergebnis_multiplikation:',    ergebnis_multiplikation,
       / 'ergebnis_division_genau:',    ergebnis_division_genau,
       / 'ergebnis_division_ganzzahl:', ergebnis_division_ganzzahl,
       / 'ergebnis_division_rest:',     ergebnis_division_rest.

DATA(inline_addition)       = 5 + 7.
DATA(inline_multiplikation) = inline_addition * 3.
DATA(inline_division)       = inline_multiplikation / inline_addition.

WRITE:  / 'inline_addition:',       inline_addition,
        / 'inline_multiplikation:', inline_multiplikation,
        / 'inline_division:',       inline_division.