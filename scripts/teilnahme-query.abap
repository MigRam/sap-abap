FUNCTION-POOL /1BCDWB/DBZZ3002_TEILNAHME LINE-SIZE 110.

* Generierter Report zum Anzeigen von Tabelleninhalten
TABLES: X030L, RSEUMOD, SSCRFIELDS, DD08L.
TYPE-POOLS: CXTAB, SLIST, slis.
DATA: CONTROL_COLS TYPE CXTAB_COLUMN.
INCLUDE <SYMBOL>.
tables: dbdata.
data: begin of g_dbdatakey,
        eu_name type DBDATA-EU_NAME,
        username type dbdata-username,
      end of g_dbdatakey.
data: l_dfies type dfies occurs 0 with header line.
constants: c_all type uname value '%_ALL'.
data: ZZ3002_TEILNAHME type ZZ3002_TEILNAHME.
data: begin of %_alv_ZZ3002_TEILNAHME occurs 100.
data:   %_box type c.
        include structure ZZ3002_TEILNAHME.
data:   %_index type i.
data: end of %_alv_ZZ3002_TEILNAHME.
DATA: IZZ3002_TEILNAHME LIKE ZZ3002_TEILNAHME OCCURS 0 WITH HEADER LINE.
DATA: BEGIN OF PZZ3002_TEILNAHME OCCURS 100.
  INCLUDE STRUCTURE ZZ3002_TEILNAHME.
DATA:  %_INDEX TYPE I,
       END OF PZZ3002_TEILNAHME.
DATA: BEGIN OF %_TAB2 OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF %_TAB2.
DATA: BEGIN OF %_TAB2_FIELD OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF %_TAB2_FIELD.
DATA: BEGIN OF %_TAB2_SORT OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF %_TAB2_SORT.
DATA: BEGIN OF %_TAB2_RETT OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF %_TAB2_RETT.
DATA: BEGIN OF DBA_SELLIST OCCURS 1.
        INCLUDE STRUCTURE TBSELLIST.
DATA: END OF DBA_SELLIST.
DATA: BEGIN OF RETT_%_TAB2 OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF RETT_%_TAB2.
DATA: BEGIN OF %_TAB3 OCCURS 10.
        INCLUDE STRUCTURE X031L.
DATA: END OF %_TAB3.
DATA: BEGIN OF FOR_TAB OCCURS 10.
        INCLUDE STRUCTURE DD05Q.
DATA: END OF FOR_TAB.
DATA: BEGIN OF I_DD05Q OCCURS 10.
        INCLUDE STRUCTURE DD05Q.
DATA: END OF I_DD05Q.
DATA: BEGIN OF SORT_TAB OCCURS 10,
        NAME(22),
        NUMBER LIKE SY-TABIX,
      END OF SORT_TAB.
DATA: BEGIN OF I_CODE OCCURS 10,
        LINE(255),
      END OF I_CODE.
DATA: BEGIN OF I_CODE2 OCCURS 10,
        LINE(72),
      END OF I_CODE2.
DATA: BEGIN OF FIELD_NAMES OCCURS 10,
        FIELDNAME LIKE DD03L-FIELDNAME,
        SCRTEXT_S LIKE DD04T-SCRTEXT_S,
        SCRTEXT_M LIKE DD04T-SCRTEXT_M,
        SCRTEXT_L LIKE DD04T-SCRTEXT_L,
        FIELDTEXT LIKE DD04T-DDTEXT,
      END OF FIELD_NAMES.
DATA: BEGIN OF TEXTS OCCURS 10.
        INCLUDE STRUCTURE RSSELTEXTS.
DATA: END OF TEXTS.
DATA: BEGIN OF OLD_TEXT OCCURS 50.
        INCLUDE STRUCTURE TEXTPOOL.
DATA: END OF OLD_TEXT.
data: begin of %_curstab occurs 5,
        dynnr type sy-dynnr,
        fieldname(132) type c,
      end of %_curstab.

data: %_l_tab like ZZ3002_TEILNAHME.
DATA: PROGNAME LIKE SY-REPID, DYNNR1 LIKE SY-DYNNR, DYNNR2 LIKE
      SY-DYNNR.
DATA: DBCOUNT TYPE P LENGTH 16, SORT_LINES LIKE SY-TABIX.
DATA: FIELD_LINES LIKE SY-TABIX, FIRST_TIME, POS LIKE SY-TABIX.
DATA: POS2 LIKE SY-TABIX, SPRACH_FIRST, SPRACH, NO_TEXT.
DATA: PROG LIKE SY-REPID, DO_SORT(1), CODE(4),
      XCODE like sy-ucomm.
DATA: OK_CODE like sy-ucomm,
      NEXT(1), EXIT_FLAG, HFIELD(255), FIELD(40),
      PAGE_FLAG(1), OKCODE(4), %MARK, EX_MODE,
      LINES_DELETED LIKE SY-TABIX, LINES_INSERTED LIKE SY-TABIX.
DATA: GLOBAL_AUTH(4), G_DATA_EXIT LIKE RS38L-NAME.
DATA: MEM_ID(32) VALUE 'TABELLENANZEIGER'.
DATA: FIRST_SSO, OLD_TBCOUNT LIKE RSEUMOD-TBCOUNT.
DATA: CHECKTABLE(30), LEN LIKE SY-TABIX, MAXLEN LIKE SY-TABIX.
DATA: COUNT LIKE SY-TABIX, INPUT_ENTRY, SUBRC LIKE SY-SUBRC.
DATA: ULINE_LENGTH LIKE SY-FDPOS, ENTRIES LIKE SY-TABIX.
DATA: STARO LIKE SY-STARO, LILLI LIKE SY-LILLI.
DATA: PAGNO LIKE SY-PAGNO, LSIND LIKE SY-LSIND.
data: %_cucol like sy-cucol.
DATA: TABIX LIKE SY-TABIX, KEY_LENGTH LIKE SY-TABIX.
DATA: ACTION(4), RETT_ACTION(4).
DATA: FORTABLE LIKE DD05Q-FORTABLE, FORKEY LIKE DD05Q-FORKEY.
DATA: CHECKFIELD LIKE DD05Q-CHECKFIELD.
DATA: POOLNAME LIKE TRDIR-NAME, HELPFIELD(52),
      TKEY_LEN LIKE SY-FDPOS, KEY_LEN LIKE SY-FDPOS,
      POOLNAME2 LIKE TRDIR-NAME, F1(100).
DATA: FOR_TABLE_LINES LIKE SY-TABIX, CHECK_LINES LIKE SY-TABIX.
DATA: FKEY(1) TYPE X VALUE '01'.       " Maskenzeichen Schlüsself
DATA: CTRL_OFFSET TYPE I, CTRL_LEN TYPE I.
DATA: SAVE_NECCESSARY, ANSWER.
DATA: MY_LISEL TYPE SLIST_MAX_LISTLINE.
DATA: EXTERN_CALL LIKE GLOBAL_AUTH VALUE 'EXT'.
data: %_l_lines type i.
FIELD-SYMBOLS: <F>, <G>, <DIR>, <uccf> type x, <ucct> type x.
DATA: xref  TYPE REF TO CX_SY_DYNAMIC_OSQL_SEMANTICS.
DATA: xroot TYPE REF TO CX_ROOT.
DATA: g_c_max_binpt_alv_lines type i value 2000.
DATA: avail type c.
DATA: BEGIN OF INDEX_TAB OCCURS 100,
        INDEX TYPE I,
        FLAG TYPE C,
      END OF INDEX_TAB.
DATA: begin of %_kZZ3002_TEILNAHME.
data:   MANDT like ZZ3002_TEILNAHME-MANDT.
data:   ID like ZZ3002_TEILNAHME-ID.
data: end of %_kZZ3002_TEILNAHME.
data: begin of %_enqu_ZZ3002_TEILNAHME.
data:   MANDT like ZZ3002_TEILNAHME-MANDT.
data:   ID like ZZ3002_TEILNAHME-ID.
data: end of %_enqu_ZZ3002_TEILNAHME.
types: begin of range_tab_t.
types:   I1 like range of ZZ3002_TEILNAHME-ID.
types:   I2 like range of ZZ3002_TEILNAHME-PRUF_DATUM.
types:   I3 like range of ZZ3002_TEILNAHME-PRUF_ID.
types:   I4 like range of ZZ3002_TEILNAHME-PRUF_NAME.
types:   I5 like range of ZZ3002_TEILNAHME-PRUF_PRUEFER.
types:   I6 like range of ZZ3002_TEILNAHME-PRUF_ART.
types:   I7 like range of ZZ3002_TEILNAHME-MATRIKELNUMMER.
types:   I8 like range of ZZ3002_TEILNAHME-TEILNEHMER.
types:   I9 like range of ZZ3002_TEILNAHME-KREDITPUNKTE.
types:   I10 like range of ZZ3002_TEILNAHME-NOTE.
types:   maxsel like rseumod-tbmaxsel.
types: end of range_tab_t.
types: begin of multi_selection_type,
         current type n length 2,
         max_no type n length 2,
      end of multi_selection_type.
types: select_options_names_line type c length 30.
field-symbols: <select_options> type standard table,
               <workarea> type standard table.
data: l_initial type c length 1,
      range_tab type standard table of range_tab_t with header line,
      wa_range_tab like line of range_tab,
      multi_sel type multi_selection_type,
      select_options_names type table of select_options_names_line,
      ls_select_options type c length 20,
      ls_component type c length 255.
data: mem_id_mc(32) value 'TABELLENANZEIGER_MC'.
data: g_string_inc value ' '.
data: g_string_key_inc value ' '.
SELECTION-SCREEN BEGIN OF BLOCK block with frame title scr_titl.
SELECT-OPTIONS I1 FOR ZZ3002_TEILNAHME-ID.
SELECTION-SCREEN SKIP 1.
SELECT-OPTIONS I2 FOR ZZ3002_TEILNAHME-PRUF_DATUM.
SELECT-OPTIONS I3 FOR ZZ3002_TEILNAHME-PRUF_ID.
SELECT-OPTIONS I4 FOR ZZ3002_TEILNAHME-PRUF_NAME.
SELECT-OPTIONS I5 FOR ZZ3002_TEILNAHME-PRUF_PRUEFER.
SELECT-OPTIONS I6 FOR ZZ3002_TEILNAHME-PRUF_ART.
SELECT-OPTIONS I7 FOR ZZ3002_TEILNAHME-MATRIKELNUMMER.
SELECT-OPTIONS I8 FOR ZZ3002_TEILNAHME-TEILNEHMER.
SELECT-OPTIONS I9 FOR ZZ3002_TEILNAHME-KREDITPUNKTE.
SELECT-OPTIONS I10 FOR ZZ3002_TEILNAHME-NOTE.
SELECTION-SCREEN SKIP 1.
PARAMETERS LIST_BRE LIKE RSEUMOD-TBLISTBR DEFAULT '250'.
PARAMETERS MAX_SEL LIKE RSEUMOD-TBMAXSEL DEFAULT '500'.
SELECTION-SCREEN END OF BLOCK block.
INITIALIZATION.
data: %_helpfield type string,
      %_helpfield2 type ref to data.
data: lx_root type ref to cx_root.
field-symbols <%_fdata>.

try.
  CL_ABAP_SESSION_TEMPERATURE=>GET_SESSION_CONTROL( )->SET_COLD( ).
    catch CX_ABAP_SESSION_TEMPERATURE into lx_root.
      message lx_root type 'I'.
 endtry.

  PERFORM SET_TITLE_SELECTION(SAPLSETB) USING 'ZZ3002_TEILNAHME'.
  CALL FUNCTION 'RS_EXTERNAL_SELSCREEN_STATUS'
       EXPORTING P_FB = 'RS_DATABROWSE_STATUS_SET'.

  append 'I1' to select_options_names.
  append 'I2' to select_options_names.
  append 'I3' to select_options_names.
  append 'I4' to select_options_names.
  append 'I5' to select_options_names.
  append 'I6' to select_options_names.
  append 'I7' to select_options_names.
  append 'I8' to select_options_names.
  append 'I9' to select_options_names.
  append 'I10' to select_options_names.
*  IMPORT NAMETAB X030L %_TAB2 ID 'ZZ3002_TEILNAHME'.
    call function 'DDIF_FIELDINFO_GET'
         exporting
              tabname        = 'ZZ3002_TEILNAHME'
        importing
             x030l_wa       = x030l
        tables
             dfies_tab      = l_dfies.
    refresh %_tab2.
    loop at l_dfies.
      clear %_tab2.
      move-corresponding l_dfies to %_tab2.
      %_tab2-dtyp = l_dfies-datatype.
      if not l_dfies-keyflag is initial.
        %_tab2-flag1 = fkey.
      endif.
      %_tab2-exid = l_dfies-inttype.
      %_tab2-exlength = l_dfies-outputlen.
      %_tab2-dblength = l_dfies-leng.
      if %_tab2-exlength is initial.
        if l_dfies-datatype = 'SSTR' or
           l_dfies-datatype = 'RSTR' or
           l_dfies-datatype = 'SRST' or
           l_dfies-datatype = 'STRG'.
*     Bei Strings ausgabe auf 255 festlegen
          if %_tab2-exlength = 0 or
             %_tab2-exlength > 255.
            %_tab2-exlength = 255.
          endif.
        endif.
      endif.
      if %_tab2-dblength is initial.
        if l_dfies-datatype = 'SSTR' or
           l_dfies-datatype = 'RSTR' or
           l_dfies-datatype = 'SRST' or
           l_dfies-datatype = 'STRG'.
*     Bei Strings ausgabe auf 255 festlegen
          if %_tab2-dblength = 0 or
             %_tab2-dblength > 255.
            %_tab2-dblength = 255.
          if l_dfies-datatype = 'SSTR'.
concatenate 'ZZ3002_TEILNAHME' '-' %_tab2-fieldname into %_helpfield.
            create data %_helpfield2 type (%_helpfield).
            assign %_helpfield2->* to <%_fdata>.
            %_tab2-dblength = DBMAXLEN( <%_fdata> ).
          endif.
          endif.
        endif.
      endif.
      append %_tab2.
    endloop.
  LOOP AT %_TAB2.
    MOVE %_TAB2 TO RETT_%_TAB2.
    APPEND RETT_%_TAB2.
  ENDLOOP.
    CLEAR %_TAB2.
    %_TAB2-TABNAME = '*'.
    APPEND %_TAB2.

    REFRESH FIELD_NAMES.
    PERFORM FIELD_NAMES_FILL(SAPLSETB) TABLES %_TAB2
                                              FIELD_NAMES.
* INITIALISIERUNG DER KEYLAENGE.
  PERFORM KEY_INIT_FOR_TABLE(SAPLSETB)
                                   USING 'ZZ3002_TEILNAHME'
                                         KEY_LEN.
  PERFORM FORTABLES_GET(SAPLSETB) TABLES FOR_TAB
                                         I_DD05Q
                                  USING  'ZZ3002_TEILNAHME'.
    DESCRIBE TABLE FOR_TAB LINES FOR_TABLE_LINES.
  IF NOT FOR_TABLE_LINES IS INITIAL.
    LOOP AT FOR_TAB.
      IF FOR_TAB-FORTABLE NE FOR_TAB-TABNAME.
* PRUEFUNG UEBER TABELLE AUF EINE ANDERE
        DELETE FOR_TAB.
        FOR_TABLE_LINES = FOR_TABLE_LINES - 1.
      ENDIF.
    ENDLOOP.
    IF FOR_TABLE_LINES LT 0.
      FOR_TABLE_LINES = 0.
    ENDIF.
   ENDIF.
* WELCHE PRUEFTABELLEN EXISTIEREN
    DESCRIBE TABLE I_DD05Q LINES CHECK_LINES.
  IF NOT CHECK_LINES IS INITIAL.
    LOOP AT I_DD05Q.
      IF I_DD05Q-FORTABLE NE I_DD05Q-TABNAME.
* PRUEFUNG UEBER TABELLE AUF EINE ANDERE
        DELETE I_DD05Q.
        CHECK_LINES = CHECK_LINES - 1.
      ENDIF.
    ENDLOOP.
    IF CHECK_LINES LT 0.
      CHECK_LINES = 0.
    ENDIF.
   ENDIF.
   LOOP AT %_TAB2.
     READ TABLE I_DD05Q WITH KEY  FORTABLE = %_TAB2-TABNAME
                                 FORKEY   = %_TAB2-FIELDNAME.
     IF SY-SUBRC = 0.
* AUSGEHENDE BEZIEHUNG
       %_TAB2-EXID = 2.
       %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 2.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       RETT_%_TAB2-EXID = 2.
       RETT_%_TAB2-EXLENGTH = %_TAB2-EXLENGTH.
       MODIFY RETT_%_TAB2 INDEX SY-TABIX.
     ELSE.
       %_TAB2-EXID = 0.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       IF SY-SUBRC = 0.
         RETT_%_TAB2-EXID = 0.
         MODIFY RETT_%_TAB2 INDEX SY-TABIX.
       ENDIF.
     ENDIF.
     READ TABLE FOR_TAB WITH KEY CHECKTABLE = %_TAB2-TABNAME
                                 CHECKFIELD = %_TAB2-FIELDNAME.
     IF SY-SUBRC = 0.
* EINGEHENDE BEZIEHUNG
       IF %_TAB2-EXID = 2.
* EINGEHENDE UND AUSGEHENDE BEZIEHUNG
         %_TAB2-EXID = 3.
         %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 4.
       ELSE.
         %_TAB2-EXID = 1.
         %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 2.
       ENDIF.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       RETT_%_TAB2-EXID = %_TAB2-EXID.
       RETT_%_TAB2-EXLENGTH = %_TAB2-EXLENGTH.
       MODIFY RETT_%_TAB2 INDEX SY-TABIX.
     ENDIF.
   ENDLOOP.
  IF FIRST_SSO IS INITIAL.
    FIRST_SSO = 'X'.
  PERFORM RSEUMOD_SELECT(SAPLSETB) CHANGING RSEUMOD.
    IF NOT RSEUMOD-TBMAXSEL IS INITIAL.
      MAX_SEL = RSEUMOD-TBMAXSEL.
    ENDIF.
   IF NOT RSEUMOD-TBLISTBR IS INITIAL.
     LIST_BRE = RSEUMOD-TBLISTBR.
   ENDIF.
  PROG = SY-REPID.
  REFRESH TEXTS.
  IF NOT RSEUMOD-TBMODE IS INITIAL.
* ES SOLLEN FELDBEZEICHNER ANGEZEIGT WERDEN
    READ TEXTPOOL PROG INTO OLD_TEXT LANGUAGE SY-LANGU.
    LOOP AT OLD_TEXT WHERE ID = 'S'.
      IF OLD_TEXT-KEY(1) = 'I'.
        TEXTS-NAME = OLD_TEXT-KEY.
        TEXTS-KIND = 'S'.
        READ TABLE FIELD_NAMES WITH KEY FIELDNAME =
          OLD_TEXT-ENTRY+8(30).
          IF NOT FIELD_NAMES-SCRTEXT_M IS INITIAL.
            TEXTS-TEXT = FIELD_NAMES-SCRTEXT_M.
          ELSEIF NOT FIELD_NAMES-SCRTEXT_L IS INITIAL.
            TEXTS-TEXT = FIELD_NAMES-SCRTEXT_L.
          ELSEIF NOT FIELD_NAMES-SCRTEXT_S IS INITIAL.
            TEXTS-TEXT = FIELD_NAMES-SCRTEXT_S.
          ELSEIF NOT FIELD_NAMES-FIELDTEXT IS INITIAL.
            TEXTS-TEXT = FIELD_NAMES-FIELDTEXT.
          ELSE.
            TEXTS-TEXT = OLD_TEXT-ENTRY+8.
          ENDIF.
        APPEND TEXTS.
       ENDIF.
    ENDLOOP.
    ELSE.
* DIE FELDNAMEN AUSGEBEN FÜR DIE EV. FREMDSPRACHE
    READ TEXTPOOL PROG INTO OLD_TEXT LANGUAGE SY-LANGU.
    LOOP AT OLD_TEXT WHERE ID = 'S'.
      IF OLD_TEXT-KEY(1) = 'I'.
        TEXTS-NAME = OLD_TEXT-KEY.
        TEXTS-KIND = 'S'.
        TEXTS-TEXT = OLD_TEXT-ENTRY+8(30).
        APPEND TEXTS.
       ENDIF.
    ENDLOOP.
  ENDIF.
  TEXTS-NAME = 'LIST_BRE'.
  TEXTS-KIND = 'P'.
  READ TABLE FIELD_NAMES WITH KEY '%_LIST_BRE'.
  TEXTS-TEXT = FIELD_NAMES-SCRTEXT_L.
  APPEND TEXTS.
  TEXTS-NAME = 'MAX_SEL'.
  TEXTS-KIND = 'P'.
  READ TABLE FIELD_NAMES WITH KEY '%_MAX_SEL'.
  TEXTS-TEXT = FIELD_NAMES-SCRTEXT_L.
  APPEND TEXTS.
  CALL FUNCTION 'SELECTION_TEXTS_MODIFY'
       EXPORTING PROGRAM = PROG
       TABLES SELTEXTS   = TEXTS.
  IMPORT %_TAB2_FIELD %_TAB2_SORT FROM MEMORY ID SY-REPID.
  DESCRIBE TABLE %_TAB2_FIELD LINES COUNT.
  IF NOT COUNT IS INITIAL.
* ES WURDE BEREITS SELEKTIERT, DIESE SELEKTION SOLL BEIBEHALTEN
* WERDEN
    REFRESH %_TAB2.
    LOOP AT %_TAB2_FIELD.
      %_TAB2 = %_TAB2_FIELD.
      APPEND %_TAB2.
    ENDLOOP.
  ENDIF.
 ENDIF.
AT SELECTION-SCREEN.
   CASE SSCRFIELDS-UCOMM.
     WHEN 'FNAM'.
       PERFORM OPTIONS_CHANGE(SAPLSETB) CHANGING RSEUMOD.
       MAX_SEL = RSEUMOD-TBMAXSEL.
       LIST_BRE = RSEUMOD-TBLISTBR.
       PROG = SY-REPID.
       REFRESH TEXTS.
       IF NOT RSEUMOD-TBMODE IS INITIAL.
* ES SOLLEN FELDBEZEICHNER ANGEZEIGT WERDEN
         READ TEXTPOOL PROG INTO OLD_TEXT LANGUAGE SY-LANGU.
         LOOP AT OLD_TEXT WHERE ID = 'S'.
    IF OLD_TEXT-KEY(1) = 'I'.
      TEXTS-NAME = OLD_TEXT-KEY.
      TEXTS-KIND = 'S'.
      READ TABLE FIELD_NAMES WITH KEY FIELDNAME =
        OLD_TEXT-ENTRY+8(30).
        IF NOT FIELD_NAMES-SCRTEXT_M IS INITIAL.
          TEXTS-TEXT = FIELD_NAMES-SCRTEXT_M.
        ELSEIF NOT FIELD_NAMES-SCRTEXT_L IS INITIAL.
          TEXTS-TEXT = FIELD_NAMES-SCRTEXT_L.
        ELSEIF NOT FIELD_NAMES-SCRTEXT_S IS INITIAL.
          TEXTS-TEXT = FIELD_NAMES-SCRTEXT_S.
        ELSEIF NOT FIELD_NAMES-FIELDTEXT IS INITIAL.
          TEXTS-TEXT = FIELD_NAMES-FIELDTEXT.
        ELSE.
          TEXTS-TEXT = OLD_TEXT-ENTRY+8.
        ENDIF.
      APPEND TEXTS.
     ENDIF.
    ENDLOOP.
  ELSE.
* ES SOLLEN FELDNAMEN ANGEZEIGT WERDEN
  READ TEXTPOOL PROG INTO OLD_TEXT LANGUAGE SY-LANGU.
  LOOP AT OLD_TEXT WHERE ID = 'S'.
    IF OLD_TEXT-KEY(1) = 'I'.
      TEXTS-NAME = OLD_TEXT-KEY.
      TEXTS-KIND = 'S'.
          TEXTS-TEXT = OLD_TEXT-ENTRY+8.
      APPEND TEXTS.
     ENDIF.
    ENDLOOP.
  ENDIF.
  CALL FUNCTION 'SELECTION_TEXTS_MODIFY'
       EXPORTING PROGRAM = PROG
       TABLES SELTEXTS   = TEXTS.
     WHEN 'SEOP'.
     CALL FUNCTION 'RS_TABLE_LIST_CREATE'
          EXPORTING
               TABLE_NAME         = 'ZZ3002_TEILNAHME'
               ACTION             = 'ANZE'
               WITHOUT_SUBMIT     = ' '
               GENERATION_FORCED  = 'X'
               NEW_SEL            = 'X'
               DATA_EXIT          = G_DATA_EXIT
*         IMPORTING
*              PROGNAME           =
          EXCEPTIONS
               TABLE_IS_STRUCTURE = 01
               TABLE_NOT_EXISTS   = 02
               DB_NOT_EXISTS      = 03.
     WHEN 'SORT'.
     IMPORT %_TAB2_SORT FROM MEMORY ID SY-REPID.
     CALL FUNCTION 'RS_DATABROWSE_FIELDSELECT'
          EXPORTING
               TABNAME       = 'ZZ3002_TEILNAHME'
               ACTION_2      = ' '
          TABLES
               NAME_TAB      = %_TAB2
               TAB2_FIELD    = %_TAB2_SORT
               RETT_NAME_TAB = RETT_%_TAB2.
        IF SY-UCOMM NE 'RETS'.
        XCODE = SY-UCOMM.
        PERFORM RETURN_FROM_SORT(SAPLSETB)
                                     TABLES %_TAB2
                                     USING RSEUMOD-TBLISTBR
                                     CHANGING MAXLEN
                                              KEY_LENGTH
                                              ULINE_LENGTH.
        REFRESH %_TAB2_SORT.
        LOOP AT %_TAB2.
          %_TAB2_SORT = %_TAB2.
          APPEND %_TAB2_SORT.
        ENDLOOP.
        IMPORT %_TAB2_FIELD FROM MEMORY ID SY-REPID.
        EXPORT %_TAB2_FIELD %_TAB2_SORT TO MEMORY ID SY-REPID.
     CASE XCODE.
       WHEN 'RFSO'.
         %_TAB2_SORT = '**UP'.
       WHEN 'RFSD'.
         %_TAB2_SORT = '**DO'.
       ENDCASE.
     APPEND %_TAB2_SORT.
     DO_SORT = 'X'.
     ENDIF.
     WHEN 'FELD'.
       IMPORT %_TAB2_FIELD FROM MEMORY ID SY-REPID.
       CALL FUNCTION 'RS_DATABROWSE_FIELDSELECT'
            EXPORTING
                 TABNAME       = 'ZZ3002_TEILNAHME'
                 ACTION_2      = 'X'
            TABLES
                 NAME_TAB      = %_TAB2
                 TAB2_FIELD    = %_TAB2_FIELD
                 RETT_NAME_TAB = RETT_%_TAB2.
        REFRESH %_TAB2_field.
        LOOP AT %_TAB2.
          %_TAB2_field = %_TAB2.
          APPEND %_TAB2_field.
        ENDLOOP.
        IMPORT %_TAB2_sort FROM MEMORY ID SY-REPID.
        EXPORT %_TAB2_FIELD %_TAB2_SORT TO MEMORY ID SY-REPID.
    WHEN 'AEIN'.
      clear: xref, xroot.
      PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT.
      if xref is initial and xroot is initial.
        PERFORM SHOW_COUNT_STAR(SAPLSETB) USING DBCOUNT.
      endif.
   ENDCASE.

START-OF-SELECTION.
IF MAX_SEL > 0.
  RSEUMOD-TBMAXSEL = MAX_SEL.
ELSEIF MAX_SEL = 0.
  CLEAR RSEUMOD-TBMAXSEL.
ENDIF.
 IMPORT G_DATA_EXIT FROM MEMORY ID MEM_ID.
IF SY-BATCH IS INITIAL AND G_DATA_EXIT IS INITIAL.
  IMPORT ACTION FROM MEMORY ID MEM_ID.
ELSE.
  ACTION = 'ANZE'.
  concatenate '/1BCDWB/DB' 'ZZ3002_TEILNAHME' into g_dbdatakey-eu_name.
  g_dbdatakey-username = c_all.
  import sort_NAME_TAB to %_TAB2_sort
         field_name_tab to %_TAB2_field
         from database dbdata(DB) id g_dbdatakey.
  if sy-subrc = 0.
    delete from dbdata
          where relid    = 'DB' and
                eu_name  = g_dbdatakey-eu_name and
                username = c_all.
    describe table %_tab2_field lines %_l_lines.
    if not %_l_lines is initial.
      %_TAB2[] = %_tab2_field[].
    endif.
  endif.
ENDIF.
CASE ACTION.
  WHEN 'ANZE'.
try.
SELECT * FROM ZZ3002_TEILNAHME                     "client specified
                 into TABLE IZZ3002_TEILNAHME
                 UP TO RSEUMOD-TBMAXSEL ROWS BYPASSING BUFFER
   WHERE ID IN I1
   AND   PRUF_DATUM IN I2
   AND   PRUF_ID IN I3
   AND   PRUF_NAME IN I4
   AND   PRUF_PRUEFER IN I5
   AND   PRUF_ART IN I6
   AND   MATRIKELNUMMER IN I7
   AND   TEILNEHMER IN I8
   AND   KREDITPUNKTE IN I9
   AND   NOTE IN I10.

  CATCH CX_SY_DYNAMIC_OSQL_SEMANTICS INTO xref.
    IF xref->kernel_errid = 'SAPSQL_ESCAPE_WITH_POOLTABLE'.
      message i412(mo).
      exit.
    ELSE.
      RAISE EXCEPTION xref.
    ENDif.
ENDTRY.
  IF NOT G_DATA_EXIT IS INITIAL.
*   DATEN NICHT ANZEIGEN, SONDERN NACH AUßEN GEBEN
    CALL FUNCTION G_DATA_EXIT
      EXPORTING
        TABNAME = ZZ3002_TEILNAHME
      TABLES
        DATA    = IZZ3002_TEILNAHME.
    LEAVE.
  ENDIF.
  IF SY-DBCNT = RSEUMOD-TBMAXSEL.
    MESSAGE S016(ES) WITH RSEUMOD-TBMAXSEL.
  ENDIF.
  IF NOT RSEUMOD-TBCOUNT IS INITIAL.
    PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT .
  ENDIF.
IF SY-SUBRC = 0.
  perform sort_main_tab. "SORT IZZ3002_TEILNAHME.
  DESCRIBE TABLE IZZ3002_TEILNAHME LINES ENTRIES.

    IF LIST_BRE CN '1234567890 '.
      RSEUMOD-TBLISTBR = SLIST_MAX_LINESIZE.
    ELSEIF LIST_BRE GT SLIST_MAX_LINESIZE.
      RSEUMOD-TBLISTBR = SLIST_MAX_LINESIZE.
    ELSEIF LIST_BRE LT 50.
      RSEUMOD-TBLISTBR = 50.
    ELSE.
      RSEUMOD-TBLISTBR = LIST_BRE.
    ENDIF.
    PROGNAME = SY-REPID.
    PERFORM GLOBAL_VARIABLES_INIT(SAPLSETB) TABLES %_TAB2
                                             USING PROGNAME.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.

    PERFORM GET_KEY_LENGTH(SAPLSETB) TABLES %_TAB2
                           CHANGING KEY_LENGTH.

    perform authority_check_s_tabu_lin(saplsetb)
              tables iZZ3002_TEILNAHME
              using  'ZZ3002_TEILNAHME'.

    IF NOT DO_SORT IS INITIAL.
      FIRST_TIME = 'X'.
      CLEAR DO_SORT.
      READ TABLE %_TAB2_SORT WITH KEY '**'.
      ASSIGN %_TAB2_SORT+2(2) TO <DIR>.
      PERFORM SORT_TABLE USING <DIR>.
    ENDIF.
    if rseumod-tbalv_grid is initial and
       rseumod-tbalv_stan is initial.
      peRFORM LIST_OUTPUT.
    elseif ENTRIES > g_c_max_binpt_alv_lines and
       ( not sy-binpt is initial or
         not sy-batch is initial ).
       peRFORM LIST_OUTPUT.
    else.
      perform alv_layout_get(saplsetb)
                         tables %_tab2
                          using 'ZZ3002_TEILNAHME'
                       changing avail.
      describe table %_tab2 lines %_l_lines.
      if %_l_lines > 99 and
         avail is initial and
        ( not rseumod-tbalv_stan is initial or
          not rseumod-tbalv_grid is initial and
            ( not sy-binpt is initial or
              not sy-batch is initial ) ).
        message s437(mo).
        peRFORM LIST_OUTPUT.
      else.
      perform alv_globals_init(saplsetb)
             tables field_names
             using 'ZZ3002_TEILNAHME' ENTRIES DBCOUNT
             FOR_TABLE_LINES CHECK_LINES.
      perform alv_table_fill.
      perform alv_call(saplsetb)
              tables %_tab2
                     iZZ3002_TEILNAHME
                     %_alv_ZZ3002_TEILNAHME
              using 'ZZ3002_TEILNAHME'.
      if rseumod-tbalv_grid is initial and
        rseumod-tbalv_stan is initial.
*       Per Einstellungen auf Standard-Liste
        peRFORM LIST_OUTPUT.
      endif.
      endif.
    endif.
  ELSE.
    MESSAGE S429(MO).
  ENDIF.
  WHEN 'ANLE'.
* DIREKTES ANLEGEN VON EINTRÄGEN
    CODE = 'INSR'.
     DYNNR1 = '0111'.
     DYNNR2 = '0101'.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      CALL SCREEN 0111.
    ELSE.
      CALL SCREEN 0101.
    ENDIF.
    LEAVE.
  WHEN 'EANZ'.
* ANZEIGEN EINES EINZELNEN EINTRAGS
* INITIALISIERUNG DER KEYLAENGE.
    PERFORM KEY_INIT_FOR_TABLE(SAPLSETB)
                                   USING 'ZZ3002_TEILNAHME'
                                         KEY_LEN.
    CODE = 'SHOW'.
    DYNNR1 = '111'.
    DYNNR2 = '101'.
    PERFORM REPORTTABLE_FILL(SAPLSETB) TABLES I_CODE
                                       USING  'ZZ3002_TEILNAHME'       .
SELECT * FROM ZZ3002_TEILNAHME INTO TABLE IZZ3002_TEILNAHME WHERE
(I_CODE).
    DESCRIBE TABLE IZZ3002_TEILNAHME LINES ENTRIES.
    IF ENTRIES = 1.
    LOOP AT IZZ3002_TEILNAHME.
      ZZ3002_TEILNAHME = IZZ3002_TEILNAHME.
      move-corresponding ZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
      append PZZ3002_TEILNAHME.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      CALL SCREEN 0111.
    ELSE.
      CALL SCREEN 0101.
    ENDIF.
    IF XCODE = 'ENDE'. EXIT. ENDIF.
    ENDLOOP.
    LEAVE.
    ELSE.
    DBCOUNT = ENTRIES.
    PROGNAME = SY-REPID.
    PERFORM GLOBAL_VARIABLES_INIT(SAPLSETB) TABLES %_TAB2
                                             USING PROGNAME.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.

    PERFORM GET_KEY_LENGTH(SAPLSETB) TABLES %_TAB2
                           CHANGING KEY_LENGTH.

    perform authority_check_s_tabu_lin(saplsetb)
              tables iZZ3002_TEILNAHME
              using  'ZZ3002_TEILNAHME'.

    IF NOT DO_SORT IS INITIAL.
      FIRST_TIME = 'X'.
      CLEAR DO_SORT.
      READ TABLE %_TAB2_SORT WITH KEY '**'.
      ASSIGN %_TAB2_SORT+2(2) TO <DIR>.
      PERFORM SORT_TABLE USING <DIR>.
    ENDIF.
    PERFORM LIST_OUTPUT.
    ENDIF.
  ENDCASE.
FORM sort_main_tab.
  SORT IZZ3002_TEILNAHME by
  MANDT
  ID.
ENDFORM.
FORM SELECT_COUNT_STAR CHANGING P_COUNT.
data: l_counter type p length 16.
try.
SELECT COUNT(*) FROM ZZ3002_TEILNAHME
"client specified
                BYPASSING BUFFER
   INTO l_counter
   WHERE ID IN I1
   AND   PRUF_DATUM IN I2
   AND   PRUF_ID IN I3
   AND   PRUF_NAME IN I4
   AND   PRUF_PRUEFER IN I5
   AND   PRUF_ART IN I6
   AND   MATRIKELNUMMER IN I7
   AND   TEILNEHMER IN I8
   AND   KREDITPUNKTE IN I9
   AND   NOTE IN I10
 . P_COUNT = l_counter.
  CATCH CX_SY_OPEN_SQL_DB INTO xroot.
    message xroot type 'I'.
    exit.
  CATCH CX_SY_DYNAMIC_OSQL_SEMANTICS INTO xref.
    IF xref->kernel_errid = 'SAPSQL_ESCAPE_WITH_POOLTABLE'.
      message i412(mo).
      exit.
    ELSE.
      RAISE EXCEPTION xref.
    ENDif.
ENDTRY.
ENDFORM.
FORM SELECT_TABLE.
  REFRESH IZZ3002_TEILNAHME.
try.
  SELECT * FROM ZZ3002_TEILNAHME                     "client specified
                   into TABLE IZZ3002_TEILNAHME
                   UP TO RSEUMOD-TBMAXSEL ROWS BYPASSING BUFFER
     WHERE ID IN I1
     AND   PRUF_DATUM IN I2
     AND   PRUF_ID IN I3
     AND   PRUF_NAME IN I4
     AND   PRUF_PRUEFER IN I5
     AND   PRUF_ART IN I6
     AND   MATRIKELNUMMER IN I7
     AND   TEILNEHMER IN I8
     AND   KREDITPUNKTE IN I9
     AND   NOTE IN I10.

  CATCH CX_SY_DYNAMIC_OSQL_SEMANTICS INTO xref.
    IF xref->kernel_errid = 'SAPSQL_ESCAPE_WITH_POOLTABLE'.
      message i412(mo).
      exit.
    ELSE.
      RAISE EXCEPTION xref.
    ENDif.
ENDTRY.
  IF NOT G_DATA_EXIT IS INITIAL.
*   DATEN NICHT ANZEIGEN, SONDERN NACH AUßEN GEBEN
    CALL FUNCTION G_DATA_EXIT
      EXPORTING
        TABNAME = ZZ3002_TEILNAHME
      TABLES
        DATA    = IZZ3002_TEILNAHME.
    LEAVE.
  ENDIF.
    IF SY-DBCNT = RSEUMOD-TBMAXSEL.
      MESSAGE S016(ES) WITH RSEUMOD-TBMAXSEL.
    ENDIF.
  IF NOT RSEUMOD-TBCOUNT IS INITIAL.
    PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT.
  ENDIF.
  DESCRIBE TABLE IZZ3002_TEILNAHME LINES ENTRIES.

    perform authority_check_s_tabu_lin(saplsetb)
              tables iZZ3002_TEILNAHME
              using  'ZZ3002_TEILNAHME'.

  perform sort_main_tab. "SORT IZZ3002_TEILNAHME.
ENDFORM.
TOP-OF-PAGE.
  PERFORM TOP_OF_PAGE(SAPLSETB) TABLES %_TAB2
                                USING KEY_LENGTH
                                      RSEUMOD-TBLISTBR
                                      ULINE_LENGTH
                                      ENTRIES
                                      MAXLEN
                                      'ZZ3002_TEILNAHME'.

TOP-OF-PAGE DURING LINE-SELECTION.
  PERFORM TOP_OF_PAGE(SAPLSETB) TABLES %_TAB2
                                USING KEY_LENGTH
                                      RSEUMOD-TBLISTBR
                                      ULINE_LENGTH
                                      ENTRIES
                                      MAXLEN
                                      'ZZ3002_TEILNAHME'.

AT USER-COMMAND.
  perform at_user_command using sy-ucomm.
form AT_USER_COMMAND using ucomm.
  STARO = SY-STARO.
  PAGNO = SY-PAGNO.
  LILLI = SY-LILLI.
  LSIND = SY-LSIND.
  %_cucol = sy-staco.
  IF SY-UCOMM NE 'FELD' AND SY-UCOMM NE 'FARB'
     AND SY-UCOMM NE 'DMAR' AND SY-UCOMM NE 'MARK'
     AND SY-UCOMM NE 'FNAM' AND SY-UCOMM NE 'FBEZ'
     AND SY-UCOMM NE 'ANAE' AND SY-UCOMM NE 'MAR2'.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
    LIST_BRE = RSEUMOD-TBLISTBR.
  ENDIF.
  CASE UCOMM.
    WHEN 'ENTR'.
* DUMMY FUER ENTER
      PERFORM LIST_OUTPUT.
    WHEN 'ANAE'.
      PERFORM MODE_CHANGE(SAPLSETB).
    WHEN 'FNAM'.
      OLD_TBCOUNT = RSEUMOD-TBCOUNT.
      PERFORM OPTIONS_CHANGE(SAPLSETB) CHANGING
                                       RSEUMOD.
    IF NOT RSEUMOD-TBCOUNT IS INITIAL AND OLD_TBCOUNT IS INITIAL.
      PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT.
    ENDIF.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
    if rseumod-tbalv_grid is initial and
       rseumod-tbalv_stan is initial.
      peRFORM LIST_OUTPUT.
    elseif ENTRIES > g_c_max_binpt_alv_lines and
       ( not sy-binpt is initial or
         not sy-batch is initial ).
       peRFORM LIST_OUTPUT.
    else.
      perform alv_layout_get(saplsetb)
                         tables %_tab2
                          using 'ZZ3002_TEILNAHME'
                       changing avail.
      describe table %_tab2 lines %_l_lines.
      if %_l_lines > 99 and
         avail is initial and
        ( not rseumod-tbalv_stan is initial or
          not rseumod-tbalv_grid is initial and
            ( not sy-binpt is initial or
              not sy-batch is initial ) ).
        message s437(mo).
        peRFORM LIST_OUTPUT.
      else.
      perform alv_globals_init(saplsetb)
             tables field_names
             using 'ZZ3002_TEILNAHME' ENTRIES DBCOUNT
             FOR_TABLE_LINES CHECK_LINES.
      perform alv_table_fill.
      perform alv_call(saplsetb)
              tables %_tab2
                     iZZ3002_TEILNAHME
                     %_alv_ZZ3002_TEILNAHME
              using 'ZZ3002_TEILNAHME'.
      endif.
    endif.
    WHEN 'PRUE'.
      PERFORM PICKED_FIELD_GET.
      PERFORM SINGLE_VALUETABLE_FILL.
      IF FIELD IS INITIAL.
        FIELD = '*'.
      ENDIF.
      PERFORM CALL_CHECKTABLE.
   WHEN 'UMFE'.
     PERFORM PICKED_FIELD_GET.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF FIELD IS INITIAL.
       FIELD = '*'.
     ENDIF.
     PERFORM NAVIGATE_FORTABLE.
WHEN 'PC+'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PC+'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'PC-'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PC-'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'PPU'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PPU'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'PPD'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PPD'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'PE'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PE'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'PB'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'PB'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  IF SUBRC = 0.
    PERFORM LIST_OUTPUT.
  ENDIF.
WHEN 'MARK'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'MARK'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  SY-LINSZ = RSEUMOD-TBLISTBR.
WHEN 'DMAR'.
  PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                       USING KEY_LENGTH
                                             RSEUMOD-TBLISTBR
                                             'DMAR'
                                       CHANGING MAXLEN
                                                ULINE_LENGTH
                                                SUBRC .
  SY-LINSZ = RSEUMOD-TBLISTBR.
 WHEN 'MAR2'.
   PERFORM LIST_SHIFT_HANDLER(SAPLSETB) TABLES %_TAB2
                                        USING KEY_LENGTH
                                              RSEUMOD-TBLISTBR
                                              'MAR2'
                                        CHANGING MAXLEN
                                                 ULINE_LENGTH
                                                 SUBRC .

   WHEN 'FELD'.
     CALL FUNCTION 'RS_DATABROWSE_FIELDSELECT'
          EXPORTING
               TABNAME       = 'ZZ3002_TEILNAHME'
               ACTION_2      = 'X'
          IMPORTING
               OKCODE         = OK_CODE
          TABLES
               NAME_TAB      = %_TAB2
               TAB2_FIELD    = %_TAB2_SORT
               RETT_NAME_TAB = RETT_%_TAB2.
     IF OK_CODE NE 'RETS'.
     PERFORM RETURN_FROM_FIELDSELECT(SAPLSETB)
                                     TABLES RETT_%_TAB2
                                            %_TAB2
                                     USING RSEUMOD-TBLISTBR
                                     CHANGING MAXLEN
                                              KEY_LENGTH
                                              ULINE_LENGTH.
     REFRESH %_TAB2_FIELD.
     LOOP AT %_TAB2.
       %_TAB2_FIELD = %_TAB2.
       APPEND %_TAB2_FIELD.
     ENDLOOP.
     IMPORT %_TAB2_SORT FROM MEMORY ID SY-REPID.
     EXPORT %_TAB2_FIELD %_TAB2_SORT TO MEMORY ID SY-REPID.
     PERFORM LIST_OUTPUT.
     ENDIF.
   WHEN 'SORT'.
     CALL FUNCTION 'RS_DATABROWSE_FIELDSELECT'
          EXPORTING
               TABNAME       = 'ZZ3002_TEILNAHME'
               ACTION_2      = ' '
          IMPORTING
               OKCODE         = OK_CODE
          TABLES
               NAME_TAB      = %_TAB2
               TAB2_FIELD    = %_TAB2_SORT
               RETT_NAME_TAB = RETT_%_TAB2.
     IF OK_CODE NE 'RETS'.
        PERFORM RETURN_FROM_SORT(SAPLSETB)
                                     TABLES %_TAB2
                                     USING RSEUMOD-TBLISTBR
                                     CHANGING MAXLEN
                                              KEY_LENGTH
                                              ULINE_LENGTH.
        REFRESH %_TAB2_SORT.
        LOOP AT %_TAB2.
          %_TAB2_SORT = %_TAB2.
          APPEND %_TAB2_SORT.
        ENDLOOP.
        IMPORT %_TAB2_FIELD FROM MEMORY ID SY-REPID.
        EXPORT %_TAB2_FIELD %_TAB2_SORT TO MEMORY ID SY-REPID.
       IF OK_CODE = 'RFSO'.
        %_TAB2_SORT = '**UP'.
        APPEND %_TAB2_SORT.
        PERFORM SORT_TABLE USING 'UP'.
       ELSE.
        %_TAB2_SORT = '**DO'.
        APPEND %_TAB2_SORT.
        PERFORM SORT_TABLE USING 'DO'.
       ENDIF.
       PERFORM LIST_OUTPUT.
     ENDIF.
   WHEN 'SOUP'.
      IF SY-STACO = 1 AND SY-CUCOL LT 4.
        MESSAGE E480(MO).
      ENDIF.
     CLEAR SUBRC.
      PERFORM PICKED_FIELD_GET.
      IF SUBRC = 0.
        READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD.
        IF %_TAB2-TABNAME = 'ZZ3002_TEILNAHME'.
          SORT IZZ3002_TEILNAHME BY (FIELD).
        ELSE.
          MESSAGE E465(MO).
        ENDIF.
       PERFORM LIST_OUTPUT.
      ENDIF.
   WHEN 'SODO'.
      IF SY-STACO = 0 AND SY-CUCOL LT 4.
        MESSAGE E480(MO).
      ENDIF.
     CLEAR SUBRC.
      PERFORM PICKED_FIELD_GET.
      IF SUBRC = 0.
        READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD.
        IF %_TAB2-TABNAME = 'ZZ3002_TEILNAHME'.
          SORT IZZ3002_TEILNAHME DESCENDING BY (FIELD).
        ELSE.
          MESSAGE E465(MO).
        ENDIF.
       PERFORM LIST_OUTPUT.
      ENDIF.
   WHEN 'FARB'.
     PERFORM COLOR_LIST(SAPLSETB).
   WHEN 'HILF'.
     PERFORM ONLINE_HANDBOOK(SAPLSETB).
   WHEN 'TBDO'.
     PERFORM TABLE_DOCUMENTATION(SAPLSETB) USING 'ZZ3002_TEILNAHME'.
   WHEN 'TBCR'.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0 AND GLOBAL_AUTH NE EXTERN_CALL.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'SHOW'.
       READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
       move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
       LOOP AT PZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC NE 0.
           MESSAGE E436(MO).
         ELSE.
           move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           move-corresponding ZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
           MODIFY PZZ3002_TEILNAHME.
         ENDIF.
       ENDLOOP.
       CALL SCREEN 2001.
       PERFORM LIST_OUTPUT.
     ENDIF.
     WHEN 'PIC3'.
       IF SY-CUROW = 4.
         PERFORM PICKED_FIELD_GET.
PERFORM SHOW_FIELDNAME(SAPLSETB) USING 'ZZ3002_TEILNAHME' FIELD.
       ELSEIF SY-CUROW GT 5.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'SHOW'.
       TABIX = 1.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       DO.
         READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
         IF NOT RSEUMOD-TBMODE IS INITIAL.
           CALL SCREEN DYNNR1.
         ELSE.
           CALL SCREEN DYNNR2.
          ENDIF.
        IF XCODE = 'ENDE'. EXIT. ENDIF.
       ENDDO.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
***JR       PERFORM LIST_OUTPUT.
     ENDIF.
   ENDIF.
   WHEN 'AEN2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'UPDA'.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'EDIT'.
       TABIX = 1.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       DO.
         READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
             EXIT.
           ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
       PERFORM LIST_OUTPUT.
     ENDIF.
   WHEN 'ANVO'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'ANVO'.
       TABIX = 1.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       DO.
         READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
             EXIT.
           ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
       PERFORM LIST_OUTPUT.
     ENDIF.
   WHEN 'ANZ2'.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'SHOW'.
     TABIX = 1.
     DYNNR1 = '0111'.
     DYNNR2 = '0101'.
     DO.
       READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
       move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
       IF NOT RSEUMOD-TBMODE IS INITIAL.
         CALL SCREEN DYNNR1.
       ELSE.
         CALL SCREEN DYNNR2.
       ENDIF.
       IF XCODE = 'ENDE'. EXIT. ENDIF.
      ENDDO.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
***JR       PERFORM LIST_OUTPUT.
     ENDIF.
   WHEN 'ANL2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     CLEAR ZZ3002_TEILNAHME.
     CODE = 'INSR'.
     DYNNR1 = '0111'.
     DYNNR2 = '0101'.
     DO.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      CALL SCREEN DYNNR1.
    ELSE.
      CALL SCREEN DYNNR2.
    ENDIF.
       IF XCODE = 'ENDE'. EXIT. ENDIF.
      ENDDO.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
     PERFORM LIST_OUTPUT.
   WHEN 'DEL2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     PERFORM SINGLE_VALUETABLE_FILL.
     IF POS = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'DELE'.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       TABIX = 1.
       DO.
         READ TABLE PZZ3002_TEILNAHME INDEX TABIX.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                  'ZZ3002_TEILNAHME'.
           EXIT.
         ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
       PERFORM LIST_OUTPUT.
     ENDIF.
 WHEN 'DEL5'.
     PERFORM SINGLE_VALUETABLE_FILL.
   PERFORM DELETE_MARKED_LINES.

 WHEN 'TRAN'.
     PERFORM SINGLE_VALUETABLE_FILL.
   PERFORM TRANSPORT_MARKED_LINES.

 WHEN 'REFR'.
   PERFORM SELECT_TABLE.
   CLEAR FIRST_TIME.
   PERFORM LIST_OUTPUT.
 when 'ALV'.
   perform alv_globals_init(saplsetb)
          tables field_names
          using 'ZZ3002_TEILNAHME' ENTRIES DBCOUNT
          FOR_TABLE_LINES CHECK_LINES.
   perform alv_table_fill.
   perform alv_call(saplsetb)
           tables %_tab2
                  iZZ3002_TEILNAHME
                  %_alv_ZZ3002_TEILNAHME
           using 'ZZ3002_TEILNAHME'.
 ENDCASE.
endform.
   form at_user_command_alv changing ucomm
                    selfield type slis_selfield.
  perform fill_table_from_alv_select using selfield-tabindex.
  case ucomm.
   WHEN 'AEN2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'UPDA'.
     IF pos = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'EDIT'.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       TABIX = 1.
       DO.
         READ TABLE pZZ3002_TEILNAHME INDEX tabix.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
             EXIT.
           ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
   perform alv_table_fill.
   selfield-refresh = 'X'.
     ENDIF.
   WHEN 'ANVO'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     IF pos = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'ANVO'.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       TABIX = 1.
       DO.
         READ TABLE pZZ3002_TEILNAHME INDEX tabix.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
             EXIT.
           ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
   perform alv_table_fill.
   selfield-refresh = 'X'.
     ENDIF.
   WHEN 'ANZ2'.
     IF pos = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'SHOW'.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       TABIX = 1.
       DO.
         READ TABLE pZZ3002_TEILNAHME INDEX tabix.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
         IF XCODE = 'ENDE'. EXIT. ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
     ENDIF.
   WHEN 'ANL2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     CLEAR ZZ3002_TEILNAHME.
     CODE = 'INSR'.
     DYNNR1 = '0111'.
     DYNNR2 = '0101'.
     IF NOT RSEUMOD-TBMODE IS INITIAL.
       CALL SCREEN DYNNR1.
     ELSE.
       CALL SCREEN DYNNR2.
     ENDIF.
     PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
   perform alv_table_fill.
   selfield-refresh = 'X'.
   WHEN 'DEL2'.
     PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
     IF pos = 0.
       MESSAGE S435(MO).
     ELSE.
       CODE = 'DELE'.
       DYNNR1 = '0111'.
       DYNNR2 = '0101'.
       TABIX = 1.
       DO.
         READ TABLE pZZ3002_TEILNAHME INDEX tabix.
         IF SY-SUBRC <> 0.
           EXIT.
         ENDIF.
         move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
move-corresponding PZZ3002_TEILNAHME to %_enqu_ZZ3002_TEILNAHME.
         perform table_entry_enqueue_new(saplsetb)
                 using %_enqu_ZZ3002_TEILNAHME
                       'ZZ3002_TEILNAHME'
                       key_len
                  changing subrc.
         IF SUBRC = 0.
           PERFORM SELECTKEYTABLE_FILL
                   TABLES I_CODE
                          RETT_%_TAB2.
SELECT SINGLE * FROM ZZ3002_TEILNAHME INTO ZZ3002_TEILNAHME WHERE
(I_CODE).
           IF NOT RSEUMOD-TBMODE IS INITIAL.
             CALL SCREEN DYNNR1.
           ELSE.
             CALL SCREEN DYNNR2.
           ENDIF.
           IF XCODE = 'ENDE'.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                  'ZZ3002_TEILNAHME'.
           EXIT.
         ENDIF.
PERFORM TABLE_ENTRY_DEQUEUE(SAPLSETB) USING %_enqu_ZZ3002_TEILNAHME
                                                     'ZZ3002_TEILNAHME'.
         ELSE.
           MESSAGE I436(MO).
           ADD 1 TO TABIX.
         ENDIF.
       ENDDO.
       PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
   perform alv_table_fill.
   selfield-refresh = 'X'.
     ENDIF.
 WHEN 'REFR'.
   PERFORM SELECT_TABLE.
   CLEAR FIRST_TIME.
   perform alv_table_fill.
   selfield-refresh = 'X'.
    WHEN 'PRUE'.
      field = selfield-fieldname.
      read table i_dd05q with key fieldname = field.
      if sy-subrc = 0.
        checktable = i_dd05q-checktable.
*        read table IZZ3002_TEILNAHME index selfield-tabindex.
*        move-corresponding IZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
*        PZZ3002_TEILNAHME-%_index = selfield-tabindex.
*        append PZZ3002_TEILNAHME.
      endif.
      IF FIELD IS INITIAL.
        FIELD = '*'.
      ENDIF.
      PERFORM CALL_CHECKTABLE.
   WHEN 'UMFE'.
      field = selfield-fieldname.
      read table i_dd05q with key fieldname = field.
      if sy-subrc = 0.
        checktable = i_dd05q-checktable.
        read table IZZ3002_TEILNAHME index selfield-tabindex.
        move-corresponding IZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
        PZZ3002_TEILNAHME-%_index = selfield-tabindex.
        append PZZ3002_TEILNAHME.
      endif.
     IF FIELD IS INITIAL.
       FIELD = '*'.
     ENDIF.
     PERFORM NAVIGATE_FORTABLE.
 WHEN 'TRAN'.
   PERFORM TRANSPORT_MARKED_LINES.
 WHEN 'DEL5'.
   PERFORM DELETE_MARKED_LINES.
   perform alv_table_fill.
   selfield-refresh = 'X'.
  WHEN 'FNAM'.
      OLD_TBCOUNT = RSEUMOD-TBCOUNT.
      PERFORM OPTIONS_CHANGE(SAPLSETB) CHANGING
                                       RSEUMOD.
    IF NOT RSEUMOD-TBCOUNT IS INITIAL AND OLD_TBCOUNT IS INITIAL.
      PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT.
    ENDIF.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
   if rseumod-tbalv_grid is initial
      and rseumod-tbalv_stan is initial.
     SELFIELD-EXIT = 'X'.
   else.
      perform alv_layout_get(saplsetb)
                         tables %_tab2
                          using 'ZZ3002_TEILNAHME'
                       changing avail.
    describe table %_tab2 lines %_l_lines.
    if %_l_lines > 99 and
       avail is initial and
      ( not rseumod-tbalv_stan is initial or
        not rseumod-tbalv_grid is initial and
          not sy-binpt is initial ).
      message s437(mo).
      SELFIELD-EXIT = 'X'.
    else.
     SELFIELD-EXIT = 'X'.
   perform alv_call(saplsetb)
           tables %_tab2
                  iZZ3002_TEILNAHME
                  %_alv_ZZ3002_TEILNAHME
           using 'ZZ3002_TEILNAHME'.
     endif.
   endif.
 endcase.
   perform alv_set_title(saplsetb)
           using ENTRIES DBCOUNT.
 endform.
FORM LIST_OUTPUT.
  DATA: ILINES LIKE SY-TABIX,
        l_act_write_lines type i,
        l_max_write_lines type i value 1000,
        big_uline(1024) type c.
  field-symbols: <eh>, <cu>.
  concatenate sy-uline sy-uline sy-uline sy-uline into
              big_uline.
  DESCRIBE TABLE IZZ3002_TEILNAHME LINES ILINES.
  IF FIRST_TIME IS INITIAL.
      READ TABLE %_TAB2_SORT WITH KEY '**'.
      if sy-subrc = 0.
        FIRST_TIME = 'X'.
        ASSIGN %_TAB2_SORT+2(2) TO <DIR>.
        PERFORM SORT_TABLE USING <DIR>.
     else.
       PERFORM FIRST_TIME_SORT.
    endif.
  ENDIF.
  WRITE SPACE.
PERFORM PF_STATUS_LISTE(SAPLSETB) USING 'ZZ3002_TEILNAHME' ENTRIES
DBCOUNT
          FOR_TABLE_LINES CHECK_LINES.
* FORMAT COLOR COL_NORMAL INTENSIFIED OFF.
  FORMAT INTENSIFIED OFF.
  CLEAR INPUT_ENTRY.
  LOOP AT IZZ3002_TEILNAHME.
    COUNT = SY-TABIX.
    if not sy-binpt is initial or not sy-batch is initial.
      l_act_write_lines = l_act_write_lines + 1.
      if l_act_write_lines = l_max_write_lines.
        l_act_write_lines = 0.
        call function 'DB_COMMIT'.
      endif.
    endif.
    POS = 1.
    LOOP AT %_TAB2.
      IF %_TAB2-TABNAME = '*'.
        EXIT.
      ENDIF.
      ASSIGN COMPONENT %_TAB2-POSITION
        OF STRUCTURE IZZ3002_TEILNAHME TO <F>.
      IF SY-TABIX = 1.
        NEW-LINE.
        POSITION POS.
       WRITE: SY-VLINE NO-GAP, INPUT_ENTRY AS CHECKBOX INPUT ON.
        POS = POS + 2.
      ELSE.
        POSITION POS.
      ENDIF.
      IF RSEUMOD-TBCONVERT IS INITIAL.
* KONVERTIERUNGSEXIT NICHT BERÜCKSICHTIGEN
      IF NOT ( %_TAB2-FLAG1 O FKEY ) .
        POSITION POS.
        IF %_TAB2-CHECKTABLE IS INITIAL.
         IF %_TAB2-DBLENGTH GT 255.
           WRITE: SY-VLINE NO-GAP,(255) <F> frames off COLOR COL_NORMAL
                                   USING NO EDIT MASK        .
         ELSE.
          WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                  USING NO EDIT MASK        .
          ENDIF.
        ELSE.
         IF %_TAB2-DBLENGTH GT 255.
          WRITE: SY-VLINE NO-GAP, (255) <F> frames off COLOR COL_TOTAL
                                  USING NO EDIT MASK        .
         ELSE.
          WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_TOTAL
                                  USING NO EDIT MASK        .
        ENDIF.
        ENDIF.
      ELSE.
        POSITION POS.
        IF %_TAB2-CHECKTABLE IS INITIAL.
         IF %_TAB2-DBLENGTH GT 255.
          WRITE: SY-VLINE NO-GAP, (255) <F> frames off COLOR COL_KEY
                                   USING NO EDIT MASK        .
         ELSE.
          WRITE: SY-VLINE NO-GAP,  <F> frames off COLOR COL_KEY
                                   USING NO EDIT MASK        .
        ENDIF.
        ELSE.
         IF %_TAB2-DBLENGTH GT 255.
WRITE: SY-VLINE NO-GAP,(255) <F> frames off COLOR COL_KEY INTENSIFIED
                               USING NO EDIT MASK        .
        ELSE.
       WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_KEY INTENSIFIED
                               USING NO EDIT MASK        .
        ENDIF.
        ENDIF.
      ENDIF.
      ELSE.
      IF %_TAB2-FLAG1 IS INITIAL.
        POSITION POS.
        IF %_TAB2-CHECKTABLE IS INITIAL.
         IF %_TAB2-DBLENGTH GT 255.
          WRITE: SY-VLINE NO-GAP,(255) <F> frames off COLOR COL_NORMAL.
         ELSEIF %_tab2-dtyp = 'QUAN'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <eh>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   UNIT <eh>.
         ELSEIF %_tab2-dtyp = 'CURR'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <cu>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   CURRENCY <cu>.
        ELSE.
          WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL.
        ENDIF.
        ELSE.
         IF %_TAB2-DBLENGTH GT 255.
          WRITE: SY-VLINE NO-GAP,(255) <F> frames off COLOR COL_TOTAL.
         ELSEIF %_tab2-dtyp = 'QUAN'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <eh>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   UNIT <eh>.
         ELSEIF %_tab2-dtyp = 'CURR'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <cu>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   CURRENCY <cu>.
        ELSE.
          WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_TOTAL.
        ENDIF.
        ENDIF.
      ELSE.
        POSITION POS.
        IF %_TAB2-CHECKTABLE IS INITIAL.
         IF %_TAB2-DBLENGTH GT 255.
          WRITE: SY-VLINE NO-GAP,(255) <F> frames off COLOR COL_KEY.
         ELSEIF %_tab2-dtyp = 'QUAN'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <eh>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   UNIT <eh>.
         ELSEIF %_tab2-dtyp = 'CURR'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <cu>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   CURRENCY <cu>.
        ELSE.
          WRITE: SY-VLINE NO-GAP,  <F> frames off COLOR COL_KEY.
        ENDIF.
        ELSE.
         IF %_TAB2-DBLENGTH GT 255.
       WRITE: SY-VLINE NO-GAP,(255)
                 <F> COLOR COL_KEY INTENSIFIED.
         ELSEIF %_tab2-dtyp = 'QUAN'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <eh>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   UNIT <eh>.
         ELSEIF %_tab2-dtyp = 'CURR'.
           ASSIGN COMPONENT %_TAB2-reffield
            OF STRUCTURE IZZ3002_TEILNAHME TO <cu>.
            WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_NORMAL
                                   CURRENCY <cu>.
        ELSE.
       WRITE: SY-VLINE NO-GAP, <F> frames off COLOR COL_KEY INTENSIFIED.
        ENDIF.
        ENDIF.
      ENDIF.
      ENDIF.
      IF RSEUMOD-TBMODE IS INITIAL.
        LEN = STRLEN( %_TAB2-FIELDNAME ).
      ELSE.
       READ TABLE FIELD_NAMES WITH KEY %_TAB2-FIELDNAME.
       IF NOT FIELD_NAMES-SCRTEXT_M IS INITIAL.
*         LEN = STRLEN( FIELD_NAMES-SCRTEXT_M ).
 call method CL_SCP_LINEBREAK_UTIL=>GET_VISUAL_STRINGLENGTH
      exporting im_string = FIELD_NAMES-SCRTEXT_M
*                im_langu  = sy-langu
      importing ex_pos_vis = len.
       ELSEIF NOT FIELD_NAMES-SCRTEXT_L IS INITIAL.
*         LEN = STRLEN( FIELD_NAMES-SCRTEXT_L ).
 call method CL_SCP_LINEBREAK_UTIL=>GET_VISUAL_STRINGLENGTH
      exporting im_string = FIELD_NAMES-SCRTEXT_L
*                im_langu  = sy-langu
      importing ex_pos_vis = len.
       ELSEIF NOT FIELD_NAMES-SCRTEXT_S IS INITIAL.
*         LEN = STRLEN( FIELD_NAMES-SCRTEXT_S ).
 call method CL_SCP_LINEBREAK_UTIL=>GET_VISUAL_STRINGLENGTH
      exporting im_string = FIELD_NAMES-SCRTEXT_s
*                im_langu  = sy-langu
      importing ex_pos_vis = len.
       ELSEIF NOT FIELD_NAMES-FIELDTEXT IS INITIAL.
*         LEN = STRLEN( FIELD_NAMES-FIELDTEXT ).
 call method CL_SCP_LINEBREAK_UTIL=>GET_VISUAL_STRINGLENGTH
      exporting im_string = FIELD_NAMES-fieldtext
*                im_langu  = sy-langu
      importing ex_pos_vis = len.
       ELSE.
        LEN = STRLEN( %_TAB2-FIELDNAME ).
       ENDIF.
      ENDIF.
        IF LEN GE %_TAB2-EXLENGTH.
          POS = POS + LEN + 1.
*          IF %_TAB2-EXID = 1 OR %_TAB2-EXID = 2.
*            POS = POS + 2.
*          ELSEIF %_TAB2-EXID = 3.
*            POS = POS + 4.
*          ENDIF.
        ELSE.
          POS = POS + %_TAB2-EXLENGTH + 1.
        ENDIF.
      IF POS GE MAXLEN.
        POSITION POS.
        WRITE SY-VLINE.
        EXIT.
      ENDIF.
    ENDLOOP.
    HIDE COUNT.
  ENDLOOP.
  IF NOT ILINES IS INITIAL.
    WRITE AT /(ULINE_LENGTH) big_uline.
  ENDIF.
  if not sy-binpt is initial or not sy-batch is initial.
    if l_act_write_lines > 0.
      call function 'DB_COMMIT'.
    endif.
  endif.
  SCROLL LIST INDEX LSIND TO PAGE PAGNO LINE STARO.
  scroll list index lsind to column %_cucol.
* SET CURSOR FIELD 'INPUT_ENTRY' LINE LILLI.
ENDFORM.                               " LIST_OUTPUT
FORM FIRST_TIME_SORT.
  FIRST_TIME = 'X'.
  DESCRIBE TABLE %_TAB2_SORT LINES SORT_LINES.
  IF NOT SORT_LINES IS INITIAL.
    DESCRIBE TABLE %_TAB2_FIELD LINES FIELD_LINES.
    IF NOT FIELD_LINES IS INITIAL.
* RETTUNG NICHT NÖTIG.
      REFRESH %_TAB2.
      LOOP AT %_TAB2_SORT.
        IF %_TAB2_SORT(1) = '*'. EXIT. ENDIF.
        %_TAB2 = %_TAB2_SORT.
        APPEND %_TAB2.
      ENDLOOP.
      READ TABLE %_TAB2_SORT WITH KEY '*'.
      ASSIGN %_TAB2_SORT+1(2) TO <DIR>.
      PERFORM SORT_TABLE USING <DIR>.
      REFRESH %_TAB2.
      LOOP AT %_TAB2_FIELD.
        %_TAB2 = %_TAB2_FIELD.
        APPEND %_TAB2.
      ENDLOOP.
    ELSE.
      REFRESH %_TAB2_RETT.
      LOOP AT %_TAB2.
        %_TAB2_RETT = %_TAB2.
        APPEND %_TAB2_RETT.
      ENDLOOP.
      LOOP AT %_TAB2_SORT.
        IF %_TAB2_SORT(1) = '*'. EXIT. ENDIF.
        %_TAB2 = %_TAB2_SORT.
        APPEND %_TAB2.
      ENDLOOP.
      READ TABLE %_TAB2_SORT WITH KEY '*'.
      ASSIGN %_TAB2_SORT+1(2) TO <DIR>.
      PERFORM SORT_TABLE USING <DIR>.
      REFRESH %_TAB2.
      LOOP AT %_TAB2_RETT.
        %_TAB2 = %_TAB2_RETT.
        APPEND %_TAB2.
      ENDLOOP.
    ENDIF.
  ENDIF.
ENDFORM.
form alv_table_fill.
  refresh %_alv_ZZ3002_TEILNAHME.
  clear %_alv_ZZ3002_TEILNAHME.
  LOOP AT IZZ3002_TEILNAHME.
    move-corresponding iZZ3002_TEILNAHME
       to %_alv_ZZ3002_TEILNAHME.
    append %_alv_ZZ3002_TEILNAHME.
  endloop.
endform.
form fill_table_from_alv_select using p_index type i.
  data: count type i.
  refresh PZZ3002_TEILNAHME.
  clear pos.
  loop at %_alv_ZZ3002_TEILNAHME where not %_box is initial.
    move-corresponding %_alv_ZZ3002_TEILNAHME
         to PZZ3002_TEILNAHME.
    PZZ3002_TEILNAHME-%_index = sy-tabix.
    append PZZ3002_TEILNAHME.
  endloop.
  describe table PZZ3002_TEILNAHME lines pos.
  if pos is initial.
    if not p_index is initial.
      read table %_alv_ZZ3002_TEILNAHME index p_index.
      if sy-subrc = 0.
        move-corresponding %_alv_ZZ3002_TEILNAHME
             to PZZ3002_TEILNAHME.
        PZZ3002_TEILNAHME-%_index = p_index.
        append PZZ3002_TEILNAHME.
        pos = 1.
      endif.
    endif.
  endif.
  IF POS GT 1.
    NEXT = 'X'.
  ELSE.
    CLEAR NEXT.
  ENDIF.
endform.
FORM DELETE_MARKED_LINES.
  DATA: RCODE(1) TYPE C,
        ACTION VALUE 'D'.
  PERFORM AUTHO_CHECK(SAPLSETB) USING 'ZZ3002_TEILNAHME' 'INSR'.
* ROUTINE ZUM ANZEIGEN AUS DEM RAHMENPROGRAM RUFEN
  PERFORM MARKED_LINES_SHOW(SAPLSETB) USING    ACTION
                                      CHANGING RCODE.

  IF NOT RCODE IS INITIAL.
*   LÖSCHEN WURDE BESTÄTIGT.
    sort PZZ3002_TEILNAHME by %_index descending.
    LOOP AT PZZ3002_TEILNAHME.
***JR SPERREN???
      move-corresponding PZZ3002_TEILNAHME to ZZ3002_TEILNAHME.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
        DELETE ZZ3002_TEILNAHME from ZZ3002_TEILNAHME.
      ENDIF.
      READ TABLE IZZ3002_TEILNAHME index PZZ3002_TEILNAHME-%_index.
      IF SY-SUBRC = 0.
        DELETE IZZ3002_TEILNAHME INDEX SY-TABIX.
      ENDIF.
    ENDLOOP.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
    PERFORM LIST_OUTPUT.
  ENDIF.
ENDFORM.
FORM TRANSPORT_MARKED_LINES.
  DATA: RCODE(1) TYPE C,
        ACTION VALUE 'T',
        IKO200 LIKE KO200,
        contflag,
        category(4),
        l_dd02l type dd02l,
        L_LENGTH TYPE I,
        L_LENGTH2 TYPE I,
        ITASK  LIKE E070-TRKORR,
        IORDER LIKE E070-TRKORR,
        IE071  LIKE E071  OCCURS 0 WITH HEADER LINE,
        IE071K LIKE E071K OCCURS 0 WITH HEADER LINE.
  field-symbols: <fs1>, <fs2>.
* ROUTINE ZUM ANZEIGEN AUS DEM RAHMENPROGRAM RUFEN
  PERFORM MARKED_LINES_SHOW(SAPLSETB) USING    ACTION
                                      CHANGING RCODE.

  IF NOT RCODE IS INITIAL.
*   TRANSPORT WURDE BESTÄTIGT.
      IKO200-PGMID = 'R3TR'.
      IKO200-OBJECT = 'TABU'.
      IKO200-OBJFUNC = 'K'.
      IKO200-OBJ_NAME = 'ZZ3002_TEILNAHME'.
      L_LENGTH = KEY_LEN.
      if l_length > 120. l_length = 120. endif.
      IE071-PGMID = 'R3TR'.
      IE071-OBJECT = 'TABU'.
      IE071-OBJ_NAME = 'ZZ3002_TEILNAHME'.
      IE071-OBJFUNC = 'K'.
      APPEND IE071.
    LOOP AT PZZ3002_TEILNAHME.
      IE071K-PGMID = 'R3TR'.
      IE071K-MASTERTYPE = 'TABU'.
      IE071K-OBJECT = 'TABU'.
      IE071K-MASTERNAME = 'ZZ3002_TEILNAHME'.
      IE071K-OBJNAME = 'ZZ3002_TEILNAHME'.
      move-corresponding PZZ3002_TEILNAHME to %_KZZ3002_TEILNAHME.
      assign ie071k-tabkey(l_length) to <fs1> casting type x.
      assign %_KZZ3002_TEILNAHME to <fs2> casting type x.
      <fs1> = <fs2>.
      APPEND IE071K.
    ENDLOOP.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
      CALL FUNCTION 'TR_TABLE_CATEGORY'
           EXPORTING
                WI_TABNAME             = 'ZZ3002_TEILNAHME'
                WI_DD02L               = l_dd02l
           IMPORTING
                WE_CATEGORY            = category
           EXCEPTIONS
                OTHERS                 = 3.
      IF SY-SUBRC <> 0.
        EXIT.
      endif.
      IF category = 'APPL' OR category = 'CUSY'.
        category = 'SYST'.         "vjb note 1357707
      ENDIF.
      CALL FUNCTION 'TR_ORDER_CHOICE_CORRECTION'
           EXPORTING
                IV_CATEGORY            = category
*               IV_CLI_DEP             = 'X'
           IMPORTING
                EV_ORDER               = IORDER
                EV_TASK                = ITASK
           EXCEPTIONS
                OTHERS                 = 3.
      IF SY-SUBRC <> 0.
        EXIT.
      ENDIF.
      CALL FUNCTION 'TR_APPEND_TO_COMM_OBJS_KEYS'
           EXPORTING
                WI_SIMULATION                  = ' '
                WI_SUPPRESS_KEY_CHECK          = ' '
                WI_TRKORR                      = ITASK
           TABLES
                WT_E071                        = IE071
                WT_E071K                       = IE071K
           EXCEPTIONS
                OTHERS                         = 68.
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
    ENDIF.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.
    PERFORM LIST_OUTPUT.
  ENDIF.
ENDFORM.
FORM CALL_CHECKTABLE.
  DATA: KEY(60), EMPTY_FLAG(1) VALUE 'X',
        CHECKPROG LIKE RSNEWLENG-PROGRAMM.
  DATA: JUST_SEND.
  SORT I_DD05Q BY CHECKTABLE.
  IF FIELD = '*'.
    PERFORM LIST_OF_CHECKTABLES(SAPLSETB)
                                          USING    '1'
                                                   SUBRC
                                          CHANGING CHECKTABLE
                                                   FORKEY
                                                   FIELD.
    JUST_SEND = 'X'.
  ENDIF.
   REFRESH DBA_SELLIST.
   KEY(30) = 'ZZ3002_TEILNAHME'.
   IF CHECKTABLE IS INITIAL AND JUST_SEND IS INITIAL.
* CURSOR IN GÜLTIGER ZEILE ABER UNGÜLTIGER SPALTE.
     PERFORM LIST_OF_CHECKTABLES(SAPLSETB)
                                           USING    '1'
                                                    SUBRC
                                           CHANGING CHECKTABLE
                                                    FORKEY
                                                    FIELD.
    ENDIF.
    IF NOT CHECKTABLE IS INITIAL.
     LOOP AT PZZ3002_TEILNAHME.
     LOOP AT %_TAB2 WHERE CHECKTABLE = CHECKTABLE
       AND FIELDNAME = FIELD.
       KEY+30(30) = %_TAB2-FIELDNAME.
       READ TABLE I_DD05Q WITH KEY KEY.
       TABIX = SY-TABIX.
       IF I_DD05Q-FORKEY NE I_DD05Q-FIELDNAME.
         TABIX = TABIX + 1.
         DO.
           READ TABLE I_DD05Q INDEX TABIX.
           IF I_DD05Q-FORKEY = I_DD05Q-FIELDNAME.
             EXIT.
           ENDIF.
           TABIX = TABIX + 1.
         ENDDO.
       ENDIF.
       DBA_SELLIST-TABLEFIELD = I_DD05Q-CHECKFIELD.
       DBA_SELLIST-OPERATOR  = 'EQ'.
ASSIGN COMPONENT %_TAB2-POSITION OF STRUCTURE PZZ3002_TEILNAHME TO <F>.
       case %_TAB2-DTYP.
         when 'INT1' or 'INT2' or 'INT4'.
          dba_sellist-value(10) = <f>.
         when others.
           DBA_SELLIST-VALUE     = <F>.
         endcase.
       IF NOT <F> IS INITIAL.
         CLEAR EMPTY_FLAG.
       ENDIF.
       APPEND DBA_SELLIST.
     ENDLOOP.
     ENDLOOP.
     CALL FUNCTION 'RS_TABLE_LIST_CREATE'
         EXPORTING
              TABLE_NAME         = CHECKTABLE
              ACTION             = 'EANZ'
              WITHOUT_SUBMIT     = 'X'
         IMPORTING
              PROGNAME           = CHECKPROG
         EXCEPTIONS
              OTHERS             = 01.
     IF SY-SUBRC NE 0.
       MESSAGE ID SY-MSGID TYPE 'S' NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
     ELSE.
       RETT_ACTION = ACTION.
       IF EMPTY_FLAG IS INITIAL.
         ACTION = 'EANZ'.
       ELSE.
         ACTION = 'ANZE'.
       ENDIF.
       IMPORT GLOBAL_AUTH FROM MEMORY ID MEM_ID.
       EXPORT ACTION DBA_SELLIST TO MEMORY ID MEM_ID.
       IF EMPTY_FLAG IS INITIAL.
         SUBMIT (CHECKPROG) AND RETURN.
       ELSE.
         SUBMIT (CHECKPROG) VIA SELECTION-SCREEN AND RETURN.
       ENDIF.
       ACTION = RETT_ACTION.
       EXPORT ACTION GLOBAL_AUTH TO MEMORY ID MEM_ID.
     ENDIF.
   ENDIF.
ENDFORM.
FORM NAVIGATE_FORTABLE.
  DATA: LINES LIKE SY-TABIX.
  CLEAR LINES.
  LOOP AT FOR_TAB WHERE CHECKTABLE = 'ZZ3002_TEILNAHME'
                  AND   CHECKFIELD = FIELD.
    LINES = LINES + 1.
  ENDLOOP.
  IF LINES = 0 OR LINES GT 1.
    PERFORM LIST_OF_FORTABLES(SAPLSETB)
                                        USING    'X'
                                                 SUBRC
                                        CHANGING FORTABLE
                                                 FORKEY
                                                 CHECKFIELD.
  ELSE.
    FORTABLE = FOR_TAB-FORTABLE.
    FORKEY   = FOR_TAB-FORKEY.
    CHECKFIELD = FIELD.
  ENDIF.
  IF NOT FORTABLE IS INITIAL.
* GEPICKTE ZEILE BESTIMMEN
* TABELLE ÜBER LISTE AUSGEWÄHLT.
   REFRESH DBA_SELLIST.
   READ TABLE FOR_TAB WITH KEY FORTABLE   = FORTABLE
                               FORKEY     = FORKEY.
   READ TABLE %_TAB2 WITH KEY TABNAME = 'ZZ3002_TEILNAHME'
                            FIELDNAME = CHECKFIELD.
     DBA_SELLIST-TABLEFIELD = FORKEY.
     DBA_SELLIST-OPERATOR  = 'EQ'.
     LOOP AT PZZ3002_TEILNAHME.
ASSIGN COMPONENT %_TAB2-POSITION OF STRUCTURE PZZ3002_TEILNAHME TO <F>.
       case %_TAB2-DTYP.
         when 'INT1' or 'INT2' or 'INT4'.
          dba_sellist-value(10) = <f>.
         when others.
           DBA_SELLIST-VALUE     = <F>.
         endcase.
       APPEND DBA_SELLIST.
     ENDLOOP.
     DESCRIBE TABLE DBA_SELLIST LINES LINES.
  CALL FUNCTION 'RS_TABLE_LIST_CREATE'
       EXPORTING
            TABLE_NAME         = FORTABLE
            ACTION             = 'EANZ'
            WITHOUT_SUBMIT     = 'X'
       IMPORTING
            PROGNAME           = FORTABLE
       EXCEPTIONS
            OTHERS             = 01.
   IF SY-SUBRC NE 0.
     MESSAGE ID SY-MSGID TYPE 'S' NUMBER SY-MSGNO
             WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
   ELSE.
   RETT_ACTION = ACTION.
   IF LINES NE 0.
     ACTION = 'EANZ'.
     IMPORT GLOBAL_AUTH FROM MEMORY ID MEM_ID.
     EXPORT ACTION DBA_SELLIST TO MEMORY ID MEM_ID.
     SUBMIT (FORTABLE) AND RETURN.
   ELSE.
     ACTION = 'ANZE'.
     IMPORT GLOBAL_AUTH FROM MEMORY ID MEM_ID.
     EXPORT ACTION TO MEMORY ID MEM_ID.
     SUBMIT (FORTABLE) VIA SELECTION-SCREEN AND RETURN.
   ENDIF.
   ACTION = RETT_ACTION.
   EXPORT ACTION GLOBAL_AUTH TO MEMORY ID MEM_ID.
   ENDIF.
   ENDIF.
ENDFORM.
FORM SORT_TABLE USING MODE.
  DATA: NAME0(30), NAME1(30), NAME2(30), NAME3(30), NAME4(30),
        NAME5(30), NAME6(30), NAME7(30), NAME8(30), NAME9(30).
  REFRESH SORT_TAB.
  LOOP AT %_TAB2 WHERE CONVEXIT CA '0123456789'.
    IF %_TAB2-CONVEXIT CO '1234567890 '.
    SORT_TAB-NAME = %_TAB2-FIELDNAME.
    SORT_TAB-NUMBER = %_TAB2-CONVEXIT.
    APPEND SORT_TAB.
    ENDIF.
  ENDLOOP.
  SORT SORT_TAB BY NUMBER.
  READ TABLE SORT_TAB INDEX 1.
  IF SY-SUBRC = 0.
    NAME0 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 2.
  IF SY-SUBRC = 0.
    NAME1 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 3.
  IF SY-SUBRC = 0.
    NAME2 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 4.
  IF SY-SUBRC = 0.
    NAME3 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 5.
  IF SY-SUBRC = 0.
    NAME4 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 6.
  IF SY-SUBRC = 0.
    NAME5 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 7.
  IF SY-SUBRC = 0.
    NAME6 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 8.
  IF SY-SUBRC = 0.
    NAME7 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 9.
  IF SY-SUBRC = 0.
    NAME8 = SORT_TAB-NAME.
  READ TABLE SORT_TAB INDEX 10.
  IF SY-SUBRC = 0.
    NAME9 = SORT_TAB-NAME.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  ENDIF.
  IF MODE = 'UP'.
  SORT IZZ3002_TEILNAHME BY (NAME0)
              (NAME1)
              (NAME2)
              (NAME3)
              (NAME4)
              (NAME5)
              (NAME6)
              (NAME7)
              (NAME8)
              (NAME9).
  ELSE.
  SORT IZZ3002_TEILNAHME DESCENDING BY (NAME0)
              (NAME1)
              (NAME2)
              (NAME3)
              (NAME4)
              (NAME5)
              (NAME6)
              (NAME7)
              (NAME8)
              (NAME9).
  ENDIF.
ENDFORM.
MODULE SET_STATUS_VAL OUTPUT.
  read table %_curstab with key dynnr = sy-dynnr.
  if sy-subrc = 0.
    sET CURSOR FIELD %_curstab-fieldname.
  endif.
  IF NOT NEXT IS INITIAL.
    IF TABIX = 1.
      NEXT = 1.
    ELSEIF TABIX = POS.
      NEXT = 2.
    ELSE.
      NEXT = 3.
    ENDIF.
  ENDIF.
  PERFORM SET_STATUS_VAL(SAPLSETB) TABLES RETT_%_TAB2
                                   USING CODE 'ZZ3002_TEILNAHME' NEXT
                                         FOR_TABLE_LINES .
  if code = 'INSR'.
    if ZZ3002_TEILNAHME-MANDT is initial.
      ZZ3002_TEILNAHME-MANDT = sy-mandt.
    endif.
  endif.

ENDMODULE.
MODULE EXIT_MODULE INPUT.
  IF SAVE_NECCESSARY = 'X' OR SY-DATAR <> SPACE.
    CLEAR SAVE_NECCESSARY.
    PERFORM POPUP_TO_CONFIRM(SAPLSETB) CHANGING ANSWER.
    IF ANSWER = 'J'. XCODE = 'ENDE'. SET SCREEN 0. LEAVE SCREEN.
    ENDIF.
  ELSE.
    XCODE = 'ENDE'.
    SET SCREEN 0. LEAVE SCREEN.
  ENDIF.
ENDMODULE.
MODULE PIN_VAL_ZZ3002_TEILNAHME INPUT.
ENDMODULE.
MODULE OK_CODE INPUT.
  IF SY-DATAR NE SPACE. SAVE_NECCESSARY = 'X'. ENDIF.
  XCODE = OK_CODE.
  CLEAR OK_CODE.
  CASE XCODE.
  WHEN 'SAVE'.
  CLEAR SAVE_NECCESSARY.
  CASE CODE.
    WHEN 'EDIT'.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
        UPDATE ZZ3002_TEILNAHME from ZZ3002_TEILNAHME.
      ENDIF.
        IF SY-SUBRC = 0.
          MESSAGE S428(MO).
*         ASSIGN PZZ3002_TEILNAHME(KEY_LEN) TO <F>.
*         READ TABLE IZZ3002_TEILNAHME WITH KEY <F>.
          READ TABLE IZZ3002_TEILNAHME INDEX PZZ3002_TEILNAHME-%_INDEX.
          IZZ3002_TEILNAHME = ZZ3002_TEILNAHME.
          MODIFY IZZ3002_TEILNAHME INDEX SY-TABIX.
        ELSE.
          MESSAGE S427(MO).
        ENDIF.
    WHEN 'INSR'.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
        INSERT ZZ3002_TEILNAHME from ZZ3002_TEILNAHME.
      ENDIF.
        IF SY-SUBRC = 0.
          MESSAGE S428(MO).
          IZZ3002_TEILNAHME = ZZ3002_TEILNAHME.
          APPEND IZZ3002_TEILNAHME.
        ELSE.
          MESSAGE S430(MO).
        ENDIF.
    WHEN 'ANVO'.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
        INSERT ZZ3002_TEILNAHME from ZZ3002_TEILNAHME.
      ENDIF.
        IF SY-SUBRC = 0.
          MESSAGE S428(MO).
          IZZ3002_TEILNAHME = ZZ3002_TEILNAHME.
          APPEND IZZ3002_TEILNAHME.
        ELSE.
          MESSAGE S430(MO).
        ENDIF.
  ENDCASE.
    WHEN 'DELE'.
      IF NOT GLOBAL_AUTH = EXTERN_CALL.
      DELETE ZZ3002_TEILNAHME from ZZ3002_TEILNAHME.
      ENDIF.
      IF SY-SUBRC = 0.
        MESSAGE S425(MO).
        READ TABLE IZZ3002_TEILNAHME index PZZ3002_TEILNAHME-%_index.
        IF SY-SUBRC = 0.
          DELETE IZZ3002_TEILNAHME INDEX SY-TABIX.
        ENDIF.
      ELSE.
        MESSAGE S426(MO).
      ENDIF.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'P-  '.
      PERFORM GENERAL_OK_CODE(SAPLSETB) USING XCODE.
    WHEN 'P+  '.
      PERFORM GENERAL_OK_CODE(SAPLSETB) USING XCODE.
    WHEN 'CLEA'.
* ZURUECKSETZEN BEIM INSERT
        CLEAR ZZ3002_TEILNAHME.
    WHEN 'NEXT'.
      IF SAVE_NECCESSARY = 'X' OR SY-DATAR <> SPACE.
        CLEAR SAVE_NECCESSARY.
        PERFORM POPUP_TO_CONFIRM(SAPLSETB) CHANGING ANSWER.
        IF ANSWER <> 'J'. EXIT. ENDIF.
      ENDIF.
      IF CODE = 'INSR'.
        CLEAR ZZ3002_TEILNAHME.
      ELSE.
        TABIX = TABIX + 1.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.
    WHEN 'PREV'.
      IF SAVE_NECCESSARY = 'X' OR SY-DATAR <> SPACE.
        CLEAR SAVE_NECCESSARY.
        PERFORM POPUP_TO_CONFIRM(SAPLSETB) CHANGING ANSWER.
        IF ANSWER <> 'J'. EXIT. ENDIF.
      ENDIF.
      TABIX = TABIX - 1.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'NEXP'.
      read table %_curstab with key dynnr = sy-dynnr.
      if sy-subrc = 0.
        GET CURSOR FIELD %_curstab-fieldname.
        modify %_curstab index sy-tabix.
      else.
        %_curstab-dynnr = sy-dynnr.
        GET CURSOR FIELD %_curstab-fieldname.
        append %_curstab.
      endif.
      DYNNR1 = DYNNR1 + 1.
      DYNNR2 = DYNNR2 + 1.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      SET SCREEN DYNNR1. LEAVE SCREEN.
    ELSE.
      SET SCREEN DYNNR2. LEAVE SCREEN.
    ENDIF.
    WHEN 'PREP'.
      read table %_curstab with key dynnr = sy-dynnr.
      if sy-subrc = 0.
        GET CURSOR FIELD %_curstab-fieldname.
        modify %_curstab index sy-tabix.
      else.
        %_curstab-dynnr = sy-dynnr.
        GET CURSOR FIELD %_curstab-fieldname.
        append %_curstab.
      endif.
      DYNNR1 = DYNNR1 - 1.
      DYNNR2 = DYNNR2 - 1.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      SET SCREEN DYNNR1. LEAVE SCREEN.
    ELSE.
      SET SCREEN DYNNR2. LEAVE SCREEN.
    ENDIF.
    WHEN 'FNAM'.
      OLD_TBCOUNT = RSEUMOD-TBCOUNT.
      PERFORM OPTIONS_CHANGE(SAPLSETB) CHANGING
                                       RSEUMOD.
    IF NOT RSEUMOD-TBCOUNT IS INITIAL AND OLD_TBCOUNT IS INITIAL.
      PERFORM SELECT_COUNT_STAR CHANGING DBCOUNT.
    ENDIF.
    IF NOT RSEUMOD-TBMODE IS INITIAL.
      SET SCREEN DYNNR1.
      LEAVE SCREEN.
    ELSE.
      SET SCREEN DYNNR2.
      LEAVE SCREEN.
    ENDIF.
    WHEN 'PRUE'.
      GET CURSOR FIELD HFIELD.
      IF HFIELD CS '-'. SY-FDPOS = SY-FDPOS + 1. ENDIF.
      ASSIGN HFIELD+SY-FDPOS(30) TO <F>.
      if <f> is not assigned.
        FIELD = '*'.
      else.
      READ TABLE %_TAB2 WITH KEY FIELDNAME = <F>.
      CHECKTABLE = %_TAB2-CHECKTABLE.
      FIELD = <F>.
      endif.
      PERFORM CALL_CHECKTABLE.
    WHEN 'UMFE'.
      SUBRC = 0.
      PERFORM NAVIGATE_FORTABLE.
  ENDCASE.
ENDMODULE.
FORM PICKED_FIELD_GET.
  data: l_maxlen type i.
  data: l_offset type i,
        l_len type i.
      COUNT = SY-CUROW.
      IF SY-STACO GT 1.
       LEN = SY-STACO + SY-CUCOL - 1.
      ELSE.
       LEN = SY-CUCOL.
      ENDIF.
      READ LINE 4 FIELD VALUE SY-LISEL INTO MY_LISEL.
      CLEAR POS.
* GEPICKTES FELD BESORGEN
  clear field.
  l_offset = 4.
  l_maxlen = maxlen + 3.
  if len < l_offset.
  else.
  loop at %_tab2.
    if rseumod-tbmode is initial.
      l_len = strlen( %_tab2-fieldname ).
    else.
      read table field_names with key %_tab2-fieldname.
      if not field_names-scrtext_m is initial.
*        l_len = strlen( field_names-scrtext_m ).
          call method cl_scp_linebreak_util=>get_visual_stringlength
               exporting im_string = field_names-scrtext_m
*                im_langu  = sy-langu
               importing ex_pos_vis = l_len.
      elseif not field_names-scrtext_l is initial.
*        l_len = strlen( field_names-scrtext_l ).
          call method cl_scp_linebreak_util=>get_visual_stringlength
               exporting im_string = field_names-scrtext_l
*                im_langu  = sy-langu
               importing ex_pos_vis = l_len.
      elseif not field_names-scrtext_s is initial.
*        l_len = strlen( field_names-scrtext_s ).
          call method cl_scp_linebreak_util=>get_visual_stringlength
               exporting im_string = field_names-scrtext_s
*                im_langu  = sy-langu
               importing ex_pos_vis = l_len.
      elseif not field_names-fieldtext is initial.
*        l_len = strlen( field_names-fieldtext ).
          call method cl_scp_linebreak_util=>get_visual_stringlength
               exporting im_string = field_names-fieldtext
*                im_langu  = sy-langu
               importing ex_pos_vis = l_len.
      else.
*       l_len = strlen( %_tab2-fieldname ).
          call method cl_scp_linebreak_util=>get_visual_stringlength
               exporting im_string = %_tab2-fieldname
*                im_langu  = sy-langu
               importing ex_pos_vis = l_len.
      endif.
    endif.
    if l_len ge %_tab2-exlength.
      l_offset = l_offset + l_len + 1.
    else.
      l_offset = l_offset + %_tab2-exlength + 1.
    endif.
    if l_offset ge l_maxlen.
      exit.
    endif.
    if l_offset > len.
*      l_offset = sy-tabix - 1.
*      read table %_tab2 index l_offset.
      field = %_tab2-fieldname.
      exit.
    endif.
  endloop.
  endif.
*FALSCH POSITIONIERT KEIN FELD GEFUNDEN.
      IF FIELD IS INITIAL.
        IF SY-UCOMM = 'UMFE' OR SY-UCOMM = 'PRUE'.
          EXIT.
        ELSE.
         MESSAGE E480(MO).
        ENDIF.
      ENDIF.
      DO.
        IF FIELD(1) = SPACE.
          SHIFT FIELD LEFT BY 1 PLACES.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
*      IF FIELD(1) = SYM_LEFT_ARROW.
*        SHIFT FIELD LEFT BY 1 PLACES.
*        IF FIELD(1) = SYM_RIGHT_ARROW.
*          SHIFT FIELD LEFT BY 1 PLACES.
*        ENDIF.
*      ELSEIF FIELD(1) = SYM_RIGHT_ARROW.
*        SHIFT FIELD LEFT BY 1 PLACES.
*      ENDIF.
* GEPICKTE ZEILE BESTIMMEN
      IF SY-STARO GT 1.
        LEN = SY-STARO - 1 + COUNT - 4.
      ELSE.
        LEN = COUNT - 4.
      ENDIF.
      IF SY-CUROW NE 3 OR SY-UCOMM = 'SODO'
         OR SY-UCOMM = 'SOUP' OR SY-UCOMM = 'PRUE'
         OR SY-UCOMM = 'UMFE'.
*        NICHT IN KOPFZEILE GEKLICKT
* WERTE DER GEPICKTEN ZEILE LESEN
        REFRESH PZZ3002_TEILNAHME.
        READ TABLE IZZ3002_TEILNAHME INDEX LEN.
        IF SY-SUBRC = 0.
          move-corresponding IZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
          PZZ3002_TEILNAHME-%_index = len.
          APPEND PZZ3002_TEILNAHME.
        ENDIF.
* PRUEFTABELLE BESTIMMEN
        IF RSEUMOD-TBMODE IS INITIAL.
          READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD.
          CHECKTABLE = %_TAB2-CHECKTABLE.
        ELSE.
         READ TABLE FIELD_NAMES WITH KEY SCRTEXT_M = FIELD.
          IF SY-SUBRC = 0.
    READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD_NAMES-FIELDNAME.
          CHECKTABLE = %_TAB2-CHECKTABLE.
                FIELD = FIELD_NAMES-FIELDNAME.
          ELSE.
            READ TABLE FIELD_NAMES WITH KEY SCRTEXT_L = FIELD.
            IF SY-SUBRC = 0.
    READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD_NAMES-FIELDNAME.
          CHECKTABLE = %_TAB2-CHECKTABLE.
                FIELD = FIELD_NAMES-FIELDNAME.
            ELSE.
              READ TABLE FIELD_NAMES WITH KEY SCRTEXT_S = FIELD.
              IF SY-SUBRC = 0.
    READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD_NAMES-FIELDNAME.
          CHECKTABLE = %_TAB2-CHECKTABLE.
                FIELD = FIELD_NAMES-FIELDNAME.
              ELSE.
              READ TABLE FIELD_NAMES WITH KEY FIELDTEXT = FIELD.
              IF SY-SUBRC = 0.
    READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD_NAMES-FIELDNAME.
          CHECKTABLE = %_TAB2-CHECKTABLE.
                FIELD = FIELD_NAMES-FIELDNAME.
              ELSE.
                READ TABLE %_TAB2 WITH KEY FIELDNAME = FIELD.
                CHECKTABLE = %_TAB2-CHECKTABLE.
              ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT RSEUMOD-TBMODE IS INITIAL.
         READ TABLE FIELD_NAMES WITH KEY SCRTEXT_M = FIELD.
          IF SY-SUBRC = 0.
            FIELD = FIELD_NAMES-FIELDNAME.
          ELSE.
            READ TABLE FIELD_NAMES WITH KEY SCRTEXT_L = FIELD.
            IF SY-SUBRC = 0.
              FIELD = FIELD_NAMES-FIELDNAME.
            ELSE.
              READ TABLE FIELD_NAMES WITH KEY SCRTEXT_S = FIELD.
              IF SY-SUBRC = 0.
                FIELD = FIELD_NAMES-FIELDNAME.
            ELSE.
              READ TABLE FIELD_NAMES WITH KEY FIELDTEXT = FIELD.
              IF SY-SUBRC = 0.
                FIELD = FIELD_NAMES-FIELDNAME.
              ENDIF.
            ENDIF.
          ENDIF.
              ENDIF.
        ENDIF.
      ENDIF.
ENDFORM.
FORM SINGLE_VALUETABLE_FILL.
  DATA: LIN LIKE SY-LILLI.
  REFRESH PZZ3002_TEILNAHME.
  DO.
    CLEAR INPUT_ENTRY.
    READ LINE SY-INDEX FIELD VALUE INPUT_ENTRY.
    IF SY-SUBRC NE 0.
      EXIT.
    ENDIF.
    IF INPUT_ENTRY = 'X'.
      READ TABLE IZZ3002_TEILNAHME INDEX COUNT.
      move-corresponding IZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
      PZZ3002_TEILNAHME-%_INDEX = COUNT.
      APPEND PZZ3002_TEILNAHME.
    ENDIF.
  ENDDO.
  DESCRIBE TABLE PZZ3002_TEILNAHME LINES POS.
  IF POS = 0.
    GET CURSOR LINE LIN.
    IF LIN GE 5.
* CURSOR STEHT AUF GÜLTIGER ZEILE.
      READ LINE LIN.
      IF SY-SUBRC = 0.
        READ TABLE IZZ3002_TEILNAHME INDEX COUNT.
        move-corresponding IZZ3002_TEILNAHME to PZZ3002_TEILNAHME.
        PZZ3002_TEILNAHME-%_INDEX = COUNT.
        APPEND PZZ3002_TEILNAHME.
        POS = 1.
        CLEAR NEXT.
      ENDIF.
    ELSE.
      MESSAGE S435(MO).
    ENDIF.
  ELSE.
    IF POS GT 1.
      NEXT = 'X'.
    ELSE.
      CLEAR NEXT.
    ENDIF.
  ENDIF.
ENDFORM.
FORM SELECTKEYTABLE_FILL TABLES REPCODE
                                P_TAB STRUCTURE X031L.
  DATA: HELPFIELD2(255).
  DATA: BEGIN OF I_CODE OCCURS 10,
          LINE(255),
        END OF I_CODE.
  DATA: L_POS TYPE I,
        l_length type i.
  FIELD-SYMBOLS <L_F>.

  REFRESH REPCODE.
  LOOP AT P_TAB where flag1 o fkey
    and not ( dtyp = 'CLNT' and position = 1 ).
    "exclude client field or it dumps due to harsher check when
    "client field in where clause without client-specified option
      if i_code[] is initial.
        I_CODE-LINE = P_TAB-FIELDNAME.
        APPEND I_CODE.
      ELSE.
        I_CODE-LINE = 'and'.
        APPEND I_CODE.
        I_CODE-LINE = P_TAB-FIELDNAME.
        APPEND I_CODE.
      ENDIF.
ASSIGN COMPONENT P_TAB-POSITION OF STRUCTURE ZZ3002_TEILNAHME TO <L_F>.
*     EINZELHOCHKOMMATA ERSETZEN.
      case p_tab-dtyp.
        when 'CHAR' or 'NUMC' or 'DATS' or 'TIMS' or 'STRING'
             or 'SSTRING'.
        IF <L_F> CA ''''.
          helpfield2 = <l_f>.
          replace all occurrences of ''''
                  in helpfield2 with ''''''.
          ASSIGN HELPFIELD2 TO <L_F>.
        ENDIF.
      endcase.

      I_CODE-LINE = '= '.
      APPEND I_CODE.
      I_CODE-LINE = |'{ <L_F> }'|.
      APPEND I_CODE.
  ENDLOOP.

  LOOP AT I_CODE.
    REPCODE = I_CODE.
    APPEND REPCODE.
  ENDLOOP.
ENDFORM.
FORM INIT_DATA.
* IMPORT NAMETAB X030L %_TAB2 ID 'ZZ3002_TEILNAHME'.
    call function 'DDIF_FIELDINFO_GET'
         exporting
              tabname        = 'ZZ3002_TEILNAHME'
        importing
             x030l_wa       = x030l
        tables
             dfies_tab      = l_dfies.
    refresh %_tab2.
    loop at l_dfies.
     clear %_tab2.
      move-corresponding l_dfies to %_tab2.
      %_tab2-dtyp = l_dfies-datatype.
      if not l_dfies-keyflag is initial.
        %_tab2-flag1 = fkey.
      endif.
      %_tab2-exid = l_dfies-inttype.
      %_tab2-exlength = l_dfies-outputlen.
      %_tab2-dblength = l_dfies-leng.
      if %_tab2-exlength is initial.
        if l_dfies-datatype = 'SSTR' or
           l_dfies-datatype = 'RSTR' or
           l_dfies-datatype = 'SRST' or
           l_dfies-datatype = 'STRG'.
*     Bei Strings ausgabe auf 255 festlegen
          %_tab2-exlength = 255.
        endif.
      endif.
      if %_tab2-dblength is initial.
        if l_dfies-datatype = 'SSTR' or
           l_dfies-datatype = 'RSTR' or
           l_dfies-datatype = 'SRST' or
           l_dfies-datatype = 'STRG'.
*     Bei Strings ausgabe auf 255 festlegen
          %_tab2-dblength = 255.
        endif.
      endif.
      append %_tab2.
    endloop.
  LOOP AT %_TAB2.
    MOVE %_TAB2 TO RETT_%_TAB2.
    APPEND RETT_%_TAB2.
  ENDLOOP.
    CLEAR %_TAB2.
    %_TAB2-TABNAME = '*'.
    APPEND %_TAB2.

    REFRESH FIELD_NAMES.
    PERFORM FIELD_NAMES_FILL(SAPLSETB) TABLES %_TAB2
                                              FIELD_NAMES.
* INITIALISIERUNG DER KEYLAENGE.
  PERFORM KEY_INIT_FOR_TABLE(SAPLSETB)
                                   USING 'ZZ3002_TEILNAHME'
                                         KEY_LEN.
  PERFORM RSEUMOD_SELECT(SAPLSETB) CHANGING RSEUMOD.
  PERFORM FORTABLES_GET(SAPLSETB) TABLES FOR_TAB
                                         I_DD05Q
                                  USING  'ZZ3002_TEILNAHME'.
    DESCRIBE TABLE FOR_TAB LINES FOR_TABLE_LINES.
  IF NOT FOR_TABLE_LINES IS INITIAL.
    LOOP AT FOR_TAB.
      IF FOR_TAB-FORTABLE NE FOR_TAB-TABNAME.
* PRUEFUNG UEBER TABELLE AUF EINE ANDERE
        DELETE FOR_TAB.
        FOR_TABLE_LINES = FOR_TABLE_LINES - 1.
      ENDIF.
    ENDLOOP.
    IF FOR_TABLE_LINES LT 0.
      FOR_TABLE_LINES = 0.
    ENDIF.
   ENDIF.
* WELCHE PRUEFTABELLEN EXISTIEREN
    DESCRIBE TABLE I_DD05Q LINES CHECK_LINES.
  IF NOT CHECK_LINES IS INITIAL.
    LOOP AT I_DD05Q.
      IF I_DD05Q-FORTABLE NE I_DD05Q-TABNAME.
* PRUEFUNG UEBER TABELLE AUF EINE ANDERE
        DELETE I_DD05Q.
        CHECK_LINES = CHECK_LINES - 1.
      ENDIF.
    ENDLOOP.
    IF CHECK_LINES LT 0.
      CHECK_LINES = 0.
    ENDIF.
   ENDIF.
   LOOP AT %_TAB2.
     READ TABLE I_DD05Q WITH KEY  FORTABLE = %_TAB2-TABNAME
                                 FORKEY   = %_TAB2-FIELDNAME.
     IF SY-SUBRC = 0.
* AUSGEHENDE BEZIEHUNG
       %_TAB2-EXID = 2.
       %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 2.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       RETT_%_TAB2-EXID = 2.
       RETT_%_TAB2-EXLENGTH = %_TAB2-EXLENGTH.
       MODIFY RETT_%_TAB2 INDEX SY-TABIX.
     ELSE.
       %_TAB2-EXID = 0.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       IF SY-SUBRC = 0.
         RETT_%_TAB2-EXID = 0.
         MODIFY RETT_%_TAB2 INDEX SY-TABIX.
       ENDIF.
     ENDIF.
     READ TABLE FOR_TAB WITH KEY CHECKTABLE = %_TAB2-TABNAME
                                 CHECKFIELD = %_TAB2-FIELDNAME.
     IF SY-SUBRC = 0.
* EINGEHENDE BEZIEHUNG
       IF %_TAB2-EXID = 2.
* EINGEHENDE UND AUSGEHENDE BEZIEHUNG
         %_TAB2-EXID = 3.
         %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 4.
       ELSE.
         %_TAB2-EXID = 1.
         %_TAB2-EXLENGTH = %_TAB2-EXLENGTH + 2.
       ENDIF.
       MODIFY %_TAB2.
       READ TABLE RETT_%_TAB2 WITH KEY TABNAME = %_TAB2-TABNAME
                                    FIELDNAME = %_TAB2-FIELDNAME.
       RETT_%_TAB2-EXID = %_TAB2-EXID.
       RETT_%_TAB2-EXLENGTH = %_TAB2-EXLENGTH.
       MODIFY RETT_%_TAB2 INDEX SY-TABIX.
     ENDIF.
   ENDLOOP.
ENDFORM.
MODULE INTTAB_PREPARE OUTPUT.
  SUPPRESS DIALOG.
  LEAVE TO LIST-PROCESSING.
    PERFORM GLOBAL_VARIABLES_INIT(SAPLSETB) TABLES %_TAB2
                                            USING  PROGNAME.
    PERFORM GET_MAXLEN(SAPLSETB)
                       TABLES %_TAB2
                       USING RSEUMOD-TBLISTBR
                       CHANGING MAXLEN
                                ULINE_LENGTH.

    PERFORM GET_KEY_LENGTH(SAPLSETB) TABLES %_TAB2
                           CHANGING KEY_LENGTH.
    IF NOT DO_SORT IS INITIAL.
      CLEAR DO_SORT.
      READ TABLE %_TAB2_SORT WITH KEY '*'.
      ASSIGN %_TAB2_SORT+1(2) TO <DIR>.
      PERFORM SORT_TABLE USING <DIR>.
    ENDIF.
  PERFORM LIST_OUTPUT.
ENDMODULE.
MODULE INTTAB_PREPARE INPUT.
  SET SCREEN 0. LEAVE SCREEN.
ENDMODULE.

