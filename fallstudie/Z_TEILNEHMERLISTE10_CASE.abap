*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE10_CASE            *
*&                                             *
*&---------------------------------------------*
*&                                             *
*&                                             *
*&---------------------------------------------*

REPORT  z_teilnehmerliste10_case.

* Workarea deklarieren
DATA: wa_zteilnehmer02 TYPE zteilnehmer02.

* Zeichenketten deklarieren
DATA: tz_pc_grundlagen TYPE i,
      tz_netzwerktechnik TYPE i,
      tz_sonst TYPE i.

* Vollst�ndigen Tabelleninhalt ausgeben
SELECT * FROM zteilnehmer02 INTO wa_zteilnehmer02
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

* Alle S�tze der Tabelle lesen, Anzahl der Kursteilnehmer aufteilen mit CASE
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02.
  CASE wa_zteilnehmer02-zzkurstitel.
    WHEN 'Netzwerktechnik'.
      tz_netzwerktechnik = tz_netzwerktechnik + 1.
    WHEN 'PC-Grundlagen'.
      tz_pc_grundlagen = tz_pc_grundlagen + 1.
    WHEN OTHERS.
      tz_sonst = tz_sonst + 1.
  ENDCASE.
ENDSELECT.
SKIP.
WRITE: / 'Verteilung der Personen auf die Kurse:',
       /  tz_netzwerktechnik, 'Netzwerktechnik',
       /  tz_pc_grundlagen,   'PC-Grundlagen',
       /  tz_sonst,           'sonstige Kurse'.

* Wieder ben�tigte Z�hler initialisieren
CLEAR: tz_netzwerktechnik.

* sy-subrc der SELECT-Anweisung mit CASE auswerten
SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
         WHERE zzkurstitel = 'Netzwerktechnik'.
  tz_netzwerktechnik = tz_netzwerktechnik + 1.
ENDSELECT.
SKIP.
CASE sy-subrc.
  WHEN 0.
* Okay-Fall
    WRITE: / tz_netzwerktechnik, 'Teilnehmer f�r den Kurs Netzwerktechnik gefunden'.
  WHEN 4.
* Fehlerfall
    WRITE: / 'Keine Teilnehmer f�r den Kurs Netzwerktechnik gefunden'.
  WHEN OTHERS.
* Kann nicht sein, anderer Wert f�r sy-subrc von der Anweisung nicht geliefert
ENDCASE.