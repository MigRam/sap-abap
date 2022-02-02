 SELECT SINGLE *
  FROM zz3002_student
  INTO CORRESPONDING FIELDS OF wa_student
  WHERE matrikelnummer = lv_matr
    AND name = lv_name
    AND vorname = lv_vorname
    AND studienfach = lv_fach.


  IF lv_matr IS INITIAL OR lv_name IS INITIAL.

    lr_message_manager->report_error_message( message_text = text_error ).

  ELSEIF sy-dbcnt <> 1.

    INSERT INTO zz3002_student VALUES wa_student.

    text_success = |Student mit der ID: { lv_matr } erfolgreich gespeichert!.|.
    lr_message_manager->report_success( message_text = text_success ).

    lr_node->set_attribute_null( name = 'MATRIKELNUMMER' ).
    lr_node->set_attribute_null( name = 'NAME' ).
    lr_node->set_attribute_null( name = 'VORNAME' ).
    lr_node->set_attribute_null( name = 'STUDIENFACH' ).

    CLEAR: lv_matr,
        lv_name,
        lv_vorname,
        lv_fach.

  ELSE.

    lr_message_manager->report_error_message( message_text = |Student mit der Matrikelnummer: { lv_matr } bereits vorhanden!. Bitte vergeben Sie eine andere Matrikelnummer.| ).

  ENDIF.