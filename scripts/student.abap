METHOD onactionsave_student .

  DATA:
    text_success TYPE string,
    text_error   TYPE string.

  text_error = wd_assist->if_wd_component_assistance~get_text( key = '001' ).

  DATA:
    lr_node       TYPE REF TO if_wd_context_node,
    lr_query_node TYPE REF TO if_wd_context_node,
    lt_student    TYPE TABLE OF zz3002_student,
    lv_matr       TYPE i,
    lv_name       TYPE string,
    lv_vorname    TYPE string,
    lv_fach       TYPE string.

  lr_node = wd_context->get_child_node( 'STUDENT' ).
  lr_query_node = wd_context->get_child_node( 'STUDENT_QUERY' ).

  lr_node->get_attribute(
    EXPORTING name = 'MATRIKELNUMMER'
    IMPORTING value = lv_matr ).

  "CLEAR lv_matr.

  lr_node->get_attribute(
      EXPORTING name = 'NAME'
      IMPORTING value = lv_name ).

  "CLEAR lv_name.

  lr_node->get_attribute(
    EXPORTING name = 'VORNAME'
    IMPORTING value = lv_vorname ).

  "CLEAR lv_vorname.

  lr_node->get_attribute(
    EXPORTING name = 'STUDIENFACH'
    IMPORTING value = lv_fach ).

  "CLEAR lv_fach.

  DATA  wa_student TYPE zz3002_student.

  DATA:
    lr_api_controller  TYPE REF TO if_wd_controller,
    lr_message_manager TYPE REF TO if_wd_message_manager.

  lr_api_controller ?= wd_this->wd_get_api( ).

  lr_message_manager = lr_api_controller->get_message_manager( ).


  SELECT * FROM zz3002_student
    INTO TABLE lt_student.

  LOOP AT lt_student INTO wa_student.

    wa_student-matrikelnummer = lv_matr.
    wa_student-name = lv_name.
    wa_student-vorname = lv_vorname.
    wa_student-studienfach = lv_fach.

    MODIFY lt_student INDEX sy-tabix FROM wa_student.

  ENDLOOP.

  IF lv_matr IS INITIAL OR lv_name IS INITIAL.

    lr_message_manager->report_error_message( message_text = text_error ).

  ELSE.

    UPDATE zz3002_student FROM TABLE lt_student.

    text_success = |Student mit der ID: { lv_matr } erfolgreich gespeichert!.|.
    lr_message_manager->report_success( message_text = text_success ).

    lr_node->set_attribute_null( name = 'MATRIKELNUMMER' ).
    lr_node->set_attribute_null( name = 'NAME' ).
    lr_node->set_attribute_null( name = 'VORNAME' ).
    lr_node->set_attribute_null( name = 'STUDIENFACH' ).

    lr_query_node->set_attribute_null( name = 'MATRIKELNUMMER' ).

  ENDIF.
ENDMETHOD.