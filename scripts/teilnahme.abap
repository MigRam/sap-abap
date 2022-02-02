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