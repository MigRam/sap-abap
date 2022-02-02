*&---------------------------------------------*
*& Report  Z_TEILNEHMERLISTE13_A               *
*&---------------------------------------------*

 REPORT  z_teilnehmerliste13_a.

* Deklarationsteil
 INCLUDE z_teilnehmer_deklarationen.

* Selektionsbildschirm deklarieren
 INCLUDE zteilnehmer13_a_selektionsbild.

 START-OF-SELECTION.
* itab01 füllen
   IF par01 IS NOT INITIAL.
     PERFORM itab01_fuellen.
   ENDIF.
* itab02 füllen
   IF par02 IS NOT INITIAL.
     PERFORM itab_fuellen USING itab02.
   ENDIF.
* itab03 füllen
   IF par03 IS NOT INITIAL.
     PERFORM itab03_fuellen.
   ENDIF.
* itab04 füllen
   IF par04 IS NOT INITIAL.
     PERFORM itab04_fuellen USING itab04
       zzaehler_itab04.
   ENDIF.

 END-OF-SELECTION.
* itab01 aufbereiten und in Liste ausgeben
   IF par01 IS NOT INITIAL.
     PERFORM itab01_liste.
   ENDIF.
* itab02 verarbeiten und in Liste ausgeben
   IF par02 IS NOT INITIAL.
     PERFORM itab02_liste.
   ENDIF.
* itab03 verarbeiten und in Liste ausgeben
   IF par03 IS NOT INITIAL.
     PERFORM itab03_liste.
   ENDIF.
* itab04 verarbeiten und in Liste ausgeben
   IF par04 IS NOT INITIAL.
     PERFORM itab04_liste USING zzaehler_itab04.
   ENDIF.
* Aufruf eines Programms auf Präsentationsserver
   IF execlopr IS NOT INITIAL.
     PERFORM execute_loc_prog.
   ENDIF.
* Download itab04 auf Präsentationsserver
   IF it04down IS NOT INITIAL.
     PERFORM itab04_download.
   ENDIF.
* Workareas, Rumpf- und Kopfzeilen initialisieren
* bzw. löschen
   PERFORM aufraeumen.
* Prüfen, ob der Report von einem anderen Report
* aufgerufen wurde
   PERFORM report_ruf_pruefen.
* Ende des Hauptprogramms

*----------------------------------------------*
* Beginn der Unterprogramme
*&---------------------------------------------*
*&      Form  itab01_fuellen
*&---------------------------------------------*
 FORM itab01_fuellen.        " globale Variable
   SELECT * FROM zteilnehmer02 INTO @wa_zteilnehmer02
     ORDER BY PRIMARY KEY.
     MOVE-CORRESPONDING wa_zteilnehmer02 TO wa_itab01.
     APPEND wa_itab01 TO itab01.
   ENDSELECT.
 ENDFORM.                    " itab01_fuellen

*&---------------------------------------------*
*&      Form  itab02_fuellen
*&---------------------------------------------*
 FORM itab_fuellen USING itab_universal TYPE table.
   SELECT * FROM zteilnehmer02
     INTO CORRESPONDING FIELDS
     OF TABLE @itab_universal
     ORDER BY PRIMARY KEY.
 ENDFORM.                    " itab_fuellen

*&---------------------------------------------*
*&      Form  itab03_fuellen
*&---------------------------------------------*
 FORM itab03_fuellen .       " lokale Variable
   DATA lok_tmax TYPE i VALUE 10.
   wa_itab03-maxteil = lok_tmax.
   SELECT * FROM zteilnehmer02
       INTO @wa_zteilnehmer02
       ORDER BY PRIMARY KEY.
     wa_itab03-bezeichnung =
       wa_zteilnehmer02-zzkurstitel.
     wa_itab03-preis =
       wa_zteilnehmer02-tkurspreis.
     APPEND  wa_itab03 TO itab03 .
   ENDSELECT.
   PERFORM test.
 ENDFORM.                    " itab03_fuellen

*&---------------------------------------------*
*&      Form  itab04_fuellen
*&---------------------------------------------*
 FORM itab04_fuellen USING lok_itab TYPE table
                           lok_zzaehler.
   SELECT * FROM zteilnehmer02
     INTO CORRESPONDING FIELDS
     OF TABLE @lok_itab
     ORDER BY PRIMARY KEY.
   DESCRIBE TABLE lok_itab LINES lok_zzaehler.
 ENDFORM.                    " itab04_fuellen

*&---------------------------------------------*
*&      Form  test
*&---------------------------------------------*
 FORM test .
* BREAK-POINT.
* Globale Variable glob_tmax ist im Unterprogramm
   " bekannt.
* Lokale Variable lok_tmax ist nicht im Unterprogramm
   " bekannt.
 ENDFORM.                    " test

*&---------------------------------------------*
*&      Form  itab01_liste
*&---------------------------------------------*
 FORM itab01_liste .
* Anzahl der Rumpfzeileneinträge für itab01
* lesen und ausgeben
   DESCRIBE TABLE itab01 LINES zeilen_itab01.
   SKIP.
   WRITE: / 'Anzahl Zeilen itab01:', zeilen_itab01.
* Workarea initialisieren, füllen und neue Zeile an
* itab01 anhängen
   CLEAR wa_itab01.
   zeilen_itab01 = zeilen_itab01 + 1.
   wa_itab01-zzkurstitel = 'LINUX-GRUNDLAGEN'.
   wa_itab01-tkurspreis = '456.78'.
   INSERT wa_itab01 INTO itab01 INDEX zeilen_itab01.
* itab01 in Liste ausgeben
   SKIP.
   WRITE: / 'sy-tabix, itab01-zzkurstitel, ',
            'itab01-tkurspreis'.
   LOOP AT itab01 INTO wa_itab01.
     WRITE: / sy-tabix, wa_itab01-zzkurstitel,
              wa_itab01-tkurspreis.
   ENDLOOP.
* Einen Satz aus itab01 über Index lesen, löschen,
   " protokollieren
   READ TABLE itab01 INTO wa_itab01 INDEX 3.
   DELETE itab01 INDEX 3.
   SKIP.
   WRITE: / 'gelöscht von itab01', sy-tabix NO-GAP,
            '.Zeile:',
           wa_itab01-zzkurstitel,
           wa_itab01-tkurspreis.
 ENDFORM.                    " itab01_liste

*&---------------------------------------------*
*&      Form  itab02_liste
*&---------------------------------------------*
 FORM itab02_liste .
* itab02 verarbeiten und in Liste ausgeben
   SKIP.
   WRITE: / 'itab02-zzkurstitel, itab02-tkurspreis,',
            'itab02-minteiln'.
   LOOP AT itab02 INTO wa_itab02 WHERE zzkurstitel =
     'PC-GRUNDLAGEN' .
     wa_itab02-minteiln = 2.
     WRITE: / wa_itab02-zzkurstitel,
              wa_itab02-tkurspreis,
              wa_itab02-minteiln.
   ENDLOOP.
* Gezielt einzelnen Satz aus itab02 über
* Schlüssel lesen, löschen, protokollieren
   READ TABLE itab02 INTO wa_itab02
        WITH KEY zzkurstitel = 'SAP-Grundlagen'.
   DELETE TABLE itab02 FROM wa_itab02.
   SKIP.
   WRITE: / 'gelöscht von itab02',
            sy-tabix NO-GAP,
            '.Zeile:', wa_itab02-zzkurstitel.
 ENDFORM.                    " itab02_liste

*&---------------------------------------------*
*&      Form  itab03_liste
*&---------------------------------------------*
 FORM itab03_liste .
* itab03 verarbeiten, ausgeben und Rumpf modifizieren
   SKIP.
   WRITE: / 'itab03-bezeichnung, itab03-preis, ',
            'itab03-maxteil'.
   LOOP AT itab03 INTO wa_itab03.
     IF wa_itab03-bezeichnung = 'PC-GRUNDLAGEN'.
       wa_itab03-preis = 567.
       MODIFY itab03 FROM wa_itab03.
     ENDIF.
     WRITE: / wa_itab03-bezeichnung,
              wa_itab03-preis,
              wa_itab03-maxteil.
   ENDLOOP.
* Einen Satz aus itab03 mit Index lesen und ausgeben
   READ TABLE itab03 INDEX 3 INTO wa_itab03.
   SKIP.
   WRITE: / 'gelesen von itab03',
             sy-tabix NO-GAP,
            '.Zeile:',
             wa_itab03-bezeichnung,
             wa_itab03-preis,
             wa_itab03-maxteil.
 ENDFORM.                    " itab03_liste

*&---------------------------------------------*
*&      Form  itab04_liste
*&---------------------------------------------*
 FORM itab04_liste USING lok_zzaehler.
* Satz aus itab04 mit Schlüssel lesen und ausgeben,
   " Tabelleninfo ausgeben
   READ TABLE itab04 INTO wa_itab04
        WITH KEY mandant = sy-mandt tnummer = 5.
   IF sy-subrc = 0.
     SKIP.
     WRITE: / 'gelesen von itab04',
            / 'Zeilenanzahl der Tabelle:',
               lok_zzaehler,
            / 'Mandant', wa_itab04-mandant,
              'Teilnehmer', wa_itab04-tnummer,
            /  wa_itab04-tname,
               wa_itab04-tgeburtsdatum,
               wa_itab04-tgeschlecht.
   ENDIF.
 ENDFORM.                    " itab04_liste

*&---------------------------------------------*
*&      Form  aufraeumen
*&---------------------------------------------*
 FORM aufraeumen .
* Wirkung von CLEAR, REFRESH und FREE bei internen
   " Tabellen ohne Kopfzeile
*  BREAK-POINT.
   CLEAR wa_itab01.   " initalisiert Workarea
   CLEAR itab01.      " löscht Rumpfzeilen

   CLEAR wa_itab02.   " initalisiert Workarea
   REFRESH itab02.    " löscht Rumpfzeilen

   CLEAR wa_itab03.   " initalisiert Workarea
   FREE itab03.       " löscht Rumpfzeilen und gibt
   " Platz frei
 ENDFORM.             " aufräumen

*&---------------------------------------------*
*&      Form  report_ruf_pruefen
*&---------------------------------------------*
 FORM report_ruf_pruefen .
   GET PARAMETER ID 'Z_TEST' FIELD progname.
   IF progname IS NOT INITIAL.
     repname = 'Z_TEILNEHMERLISTE13_A'.
     SKIP.
     WRITE: / 'Report', repname,
              'wurde aufgerufen von:', progname.
     IMPORT itab04 TO itab05 FROM MEMORY ID progname.
     SKIP.
     LOOP AT itab05 INTO wa_itab05.
       WRITE: / 'itab05-tname:', wa_itab05-tname.
     ENDLOOP.
     progname = space.
     SET PARAMETER ID 'Z_TEST' FIELD progname.
   ENDIF.
 ENDFORM.                    " report_ruf_pruefen

*&----------------------------------------------------*
*&      Form  test_execute
*&----------------------------------------------------*
 FORM execute_loc_prog.
   CALL FUNCTION 'WS_EXECUTE'
     EXPORTING
*      DOCUMENT           = ' '
*      CD                 = ' '
       commandline        = 'C:\TEMP\TEST.PDF'
       program            = 'C:\Program Files (x86)\' &&
                            'Adobe\Acrobat Reader DC\Reader\Acrord32.exe'
*      EXEC_RC            = ' '
     EXCEPTIONS
       frontend_error     = 1
       no_batch           = 2
       prog_not_found     = 3
       illegal_option     = 4
       gui_refuse_execute = 5
       OTHERS             = 6.
   IF sy-subrc <> 0.
     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
   ENDIF.
 ENDFORM.                    " execute_loc_prog

*&----------------------------------------------------*
*&      Form  itab04_download
*&----------------------------------------------------*
 FORM itab04_download.
   CALL FUNCTION 'WS_DOWNLOAD'
     EXPORTING
*      BIN_FILESIZE            = ' '
       filename                = locfile
       filetype                = 'DAT'
       mode                    = ' '
*   IMPORTING
*      FILELENGTH              =
     TABLES
       data_tab                = itab04
     EXCEPTIONS
       file_open_error         = 1
       file_write_error        = 2
       invalid_filesize        = 3
       invalid_type            = 4
       no_batch                = 5
       unknown_error           = 6
       invalid_table_width     = 7
       gui_refuse_filetransfer = 8
       customer_error          = 9
       no_authority            = 10
       OTHERS                  = 11.
   IF sy-subrc <> 0.
     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
     WRITE: / 'Download itab04 auf lokale Datei',
              'misslungen, sy-subrc =', sy-subrc.
   ENDIF.
 ENDFORM.                    " itab04_download