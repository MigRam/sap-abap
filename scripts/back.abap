DATA:
    lr_node       TYPE REF TO if_wd_context_node,
    lt_teilnahme  TYPE TABLE OF zz3002_teilnahme,
    lv_id         TYPE i,
    lv_prufdate   TYPE dats,
    lv_prufid     TYPE i,
    lv_prufname   TYPE string,
    lv_prufp      TYPE string,
    lv_prufart    TYPE string,
    lv_matr       TYPE i,
    lv_teilnehmer TYPE string,
    lv_fach       TYPE string,
    lv_punkte     TYPE i,
    lv_note       TYPE p DECIMALS 2.

  lr_node = wd_context->get_child_node( 'DATA' ).

  lr_node->get_attribute(
  EXPORTING name = 'ID'
  IMPORTING value = lv_id ).

  lr_node->get_attribute(
  EXPORTING name = 'PRUF_DATUM'
  IMPORTING value = lv_prufdate ).

  lr_node->get_attribute(
  EXPORTING name = 'PRUF_ID'
  IMPORTING value = lv_prufid ).

  lr_node->get_attribute(
 EXPORTING name = 'PRUF_NAME'
 IMPORTING value = lv_prufname ).

  lr_node->get_attribute(
 EXPORTING name = 'PRUF_PRUEFER'
 IMPORTING value = lv_prufp ).

  lr_node->get_attribute(
 EXPORTING name = 'PRUF_ART'
 IMPORTING value = lv_prufart ).

  lr_node->get_attribute(
    EXPORTING name = 'MATRIKELNUMMER'
    IMPORTING value = lv_matr ).

  lr_node->get_attribute(
  EXPORTING name = 'TEILNEHMER'
  IMPORTING value = lv_teilnehmer ).

  lr_node->get_attribute(
    EXPORTING name = 'STUDIENFACH'
    IMPORTING value = lv_fach ).

  lr_node->get_attribute(
      EXPORTING name = 'KREDITPUNKTE'
      IMPORTING value = lv_punkte ).

  lr_node->get_attribute(
      EXPORTING name = 'NOTE'
      IMPORTING value = lv_note ).

  DATA:
    wa_teilnahme       TYPE zz3002_teilnahme,
    lr_api_controller  TYPE REF TO if_wd_controller,
    lr_message_manager TYPE REF TO if_wd_message_manager.

  lr_api_controller ?= wd_this->wd_get_api( ).

  lr_message_manager = lr_api_controller->get_message_manager( ).


  SELECT * FROM zz3002_teilnahme
    INTO TABLE lt_teilnahme.

  LOOP AT lt_teilnahme INTO wa_teilnahme.

    wa_teilnahme-id = lv_id.
    wa_teilnahme-pruf_datum = lv_prufdate.
    wa_teilnahme-pruf_id = lv_prufid.
    wa_teilnahme-pruf_name = lv_prufname.
    wa_teilnahme-pruf_pruefer = lv_prufp.
    wa_teilnahme-pruf_art = lv_prufart.
    wa_teilnahme-matrikelnummer = lv_matr.
    wa_teilnahme-teilnehmer = lv_teilnehmer.
    wa_teilnahme-studienfach = lv_fach.
    wa_teilnahme-kreditpunkte = lv_punkte.
    wa_teilnahme-note = lv_note.

    MODIFY lt_teilnahme INDEX sy-tabix FROM wa_teilnahme.

  ENDLOOP.

  IF lv_id IS INITIAL OR lv_prufid IS INITIAL.

    lr_message_manager->report_error_message( message_text = |Geben Sie eine Teilnahme ID und eine Prüfungs ID ein!.| ).

  ELSE.

    INSERT INTO zz3002_teilnahme VALUES wa_teilnahme.

    lr_node->set_attribute_null( name = 'ID' ).
    lr_node->set_attribute_null( name = 'PRUF_DATUM' ).
    lr_node->set_attribute_null( name = 'PRUF_ID' ).
    lr_node->set_attribute_null( name = 'PRUF_NAME' ).
    lr_node->set_attribute_null( name = 'PRUF_PRUEFER' ).
    lr_node->set_attribute_null( name = 'PRUF_ART' ).
    lr_node->set_attribute_null( name = 'MATRIKELNUMMER' ).
    lr_node->set_attribute_null( name = 'TEILNEHMER' ).
    lr_node->set_attribute_null( name = 'STUDIENFACH' ).
    lr_node->set_attribute_null( name = 'KREDITPUNKTE' ).
    lr_node->set_attribute_null( name = 'NOTE' ).

    lr_message_manager->report_success( message_text = |Teilnahme ID: { lv_matr } für den Student { lv_teilnehmer } an der Prüfung { lv_prufname } mit der ID: { lv_prufid } erfolgreich gespeichert!.| ).

  ENDIF.