*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE08                 *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT z_teilnehmerliste08.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Zeichenketten deklarieren
DATA : aktuelle_uhrzeit  TYPE syst-uzeit,
       alter_dec4        TYPE p DECIMALS 4,
       alter_integer     TYPE i,
       faelligkeitsdatum TYPE syst-datum,
       geburtsdatum      TYPE syst-datum,
       jahresanfang      TYPE syst-datum,
       jahresende        TYPE syst-datum,
       mitternacht       TYPE syst-uzeit,
       mwst_betrag       TYPE zteilnehmer02-tkurspreis,
       mwst_satz         TYPE p DECIMALS 2,
       monatsanfang      TYPE syst-datum,
       monatsende        TYPE syst-datum,
       pause             TYPE p DECIMALS 2,
       rechnungsbetrag   TYPE zteilnehmer02-tkurspreis,
       rechnungsdatum    TYPE syst-datum,
       restminuten       TYPE i,
       restsekunden      TYPE i,
       reststunden       TYPE i,
       restzeit          TYPE p DECIMALS 4,
       schichtende       TYPE syst-uzeit,
       tage_vergangen    TYPE i,
       tage_verbleibend  TYPE i,
       tagesdatum        TYPE syst-datum,
       unterrichtsbeginn TYPE syst-uzeit,
       unterrichtsende   TYPE syst-uzeit,
       unterrichtszeit   TYPE p DECIMALS 2,
       zahlungsziel      TYPE i.

* Feldwerte zuweisen
rechnungsdatum = sy-datum.
rechnungsdatum = '20190514'.
unterrichtsbeginn = sy-uzeit.
unterrichtsbeginn = '081500'.
SKIP.

* Fälligkeitsdatum einer Rechnung ermitteln
rechnungsdatum = sy-datum.
zahlungsziel = 30.
faelligkeitsdatum = rechnungsdatum + zahlungsziel.
WRITE: / 'Rechnungsdatum', 30 rechnungsdatum,
     / 'Zahlungsziel in Tagen', 30 zahlungsziel,
     / 'Fälligkeitsdatum', 30 faelligkeitsdatum.
SKIP.

* Den ersten Tag des laufenden Monats bestimmen
monatsanfang = sy-datum.
monatsanfang+6(2) = '01'.
WRITE: / 'Monatsanfang des laufenden Monats ist',
          monatsanfang.

* Den ersten Tag des folgenden Monats bestimmen
monatsanfang = sy-datum.
monatsanfang+6(2) = '01'.
monatsanfang = monatsanfang + 35.
monatsanfang+6(2) = '01'.
WRITE: / 'Monatsanfang des folgenden Monats ist',
          monatsanfang.

* Den letzten Tag des Vormonats bestimmen
monatsanfang = sy-datum.
monatsanfang+6(2) = '01'.
monatsende = monatsanfang - 1.
WRITE: / 'Monatsende des Vormonats ist',
          monatsende.

* Den letzten Tag des laufenden Monats bestimmen
monatsanfang = sy-datum.
monatsanfang+6(2) = '01'.
monatsanfang = monatsanfang + 35.
monatsanfang+6(2) = '01'.
monatsende = monatsanfang - 1.
WRITE: / 'Monatsende des laufenden Monats ist',
          monatsende.
SKIP.

* Vergangene und verbleibende Tage des Jahres bestimmen
tagesdatum = sy-datum.
jahresanfang = sy-datum.
jahresende = sy-datum.
jahresanfang+4(4) = '0101'.
jahresende+4(4) = '1231'.
tage_vergangen = tagesdatum - jahresanfang.
tage_verbleibend = jahresende - tagesdatum.
WRITE: / 'Jahresanfang', jahresanfang,
         'Jahresende', jahresende,
         'heutiges Datum', tagesdatum,
       / 'vergangene Tage', tage_vergangen,
         'verbleibende Tage', tage_verbleibend.
SKIP.

* Alter einer Person bestimmen
tagesdatum = sy-datum.
geburtsdatum = '19671223'.
alter_integer = tagesdatum - geburtsdatum.
WRITE: / 'Alter ganzzahlig in Tagen',
       46 alter_integer.
alter_integer = alter_integer / 365.
WRITE: / 'Alter ganzzahlig in Jahren kfm. gerundet',
       46 alter_integer.
alter_dec4 = ( tagesdatum - geburtsdatum )
             / 365.
WRITE: / 'Alter mit 4 Nachkommastellen in Jahren',
       40 alter_dec4.
alter_dec4 = ( tagesdatum - geburtsdatum )
             DIV 365.
WRITE: / 'Alter ganzzahlige Division',
       40 alter_dec4.
alter_dec4 = ( tagesdatum - geburtsdatum )
              MOD 365.
WRITE: / 'Alter ganzzahlige Division Resttage',
       40 alter_dec4.
SKIP.

* Unterrichtsdauer inkl. Pause bestimmen
unterrichtsbeginn = '081500'.
unterrichtsende = '180000'.
unterrichtszeit =
  unterrichtsende - unterrichtsbeginn.
WRITE: / 'Unterrichtszeit in Sekunden',
       40 unterrichtszeit.
unterrichtszeit =
  ( unterrichtsende - unterrichtsbeginn ) / 60.
WRITE: / 'Unterrichtszeit in Minuten',
       40 unterrichtszeit.
unterrichtszeit =
 ( unterrichtsende - unterrichtsbeginn ) / 3600.
WRITE: / 'Unterrichtszeit in Stunden',
       40 unterrichtszeit.

* Unterrichtsdauer ohne Pause bestimmen
pause = '0.5'.
unterrichtszeit =
 ( unterrichtsende - unterrichtsbeginn ) / 3600.
unterrichtszeit = unterrichtszeit - pause.
WRITE: / 'Pause in Stunden', 40 pause.

WRITE: / 'Unterrichtszeit ohne Pause in Stunden',
       40 unterrichtszeit.
SKIP.

* Zeit von jetzt bis Mitternacht berechnen
aktuelle_uhrzeit = sy-uzeit.
WRITE: / 'Aktuelle Uhrzeit',
       40 aktuelle_uhrzeit.
mitternacht = '240000'.
restzeit = mitternacht - aktuelle_uhrzeit.
WRITE: / 'Restzeit bis Mitternacht in Sekunden',
       40 restzeit.
reststunden = ( mitternacht - aktuelle_uhrzeit )
              DIV 3600.
WRITE: / 'Reststunden bis Mitternacht',
       40 reststunden.
restminuten =
 ( ( mitternacht - aktuelle_uhrzeit ) MOD 3600 )
 DIV 60.
restsekunden = ( mitternacht - aktuelle_uhrzeit )
MOD 60.
WRITE: / 'Restzeit bis Mitternacht:',
          reststunden, 'Stunden',
          restminuten, 'Minuten',
          restsekunden, 'Sekunden'.
SKIP.

* Zeit über Mitternacht berechnen
aktuelle_uhrzeit = sy-uzeit.
schichtende = '052010'.
WRITE: / 'Aktuelle Uhrzeit',
       40 aktuelle_uhrzeit.
WRITE: / 'Schichtende',
       40 schichtende.
restzeit =
  ( schichtende - aktuelle_uhrzeit ) MOD 86400.
WRITE: / 'Restzeit bis Schichtende in Sekunden',
       40 restzeit.
reststunden = restzeit DIV 3600.
WRITE: / 'Reststunden bis Schichtende',
       40 reststunden.
restminuten = ( restzeit MOD 3600 ) DIV 60.
restsekunden = restzeit MOD 60.

WRITE: / 'Restzeit bis Schichtende:',
          reststunden, 'Stunden',
          restminuten, 'Minuten',
          restsekunden, 'Sekunden'.
SKIP.

* Rechnen mit Währungsfeldern
mwst_satz = '0.19'.
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02.
  WRITE: / wa_zteilnehmer02-tname,
           wa_zteilnehmer02-tkurspreis,
           wa_zteilnehmer02-twaehrung.
  mwst_betrag =
    mwst_satz * wa_zteilnehmer02-tkurspreis.
  rechnungsbetrag =
    mwst_betrag + wa_zteilnehmer02-tkurspreis.
  WRITE : mwst_betrag, wa_zteilnehmer02-twaehrung,
          rechnungsbetrag,
          wa_zteilnehmer02-twaehrung.
ENDSELECT.