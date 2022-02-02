METHOD onactionquery_student .
  DATA obj TYPE REF TO zcx_3002_exception.

  DATA:
    lt_student    TYPE TABLE OF zz3002_student,
    lr_query_node TYPE REF TO if_wd_context_node,
    lr_node TYPE REF TO if_wd_context_node,
    itab_student  TYPE zz3002_student,
    lv_id_student TYPE zz3002_student-matrikelnummer.

  DATA:
    lr_api_controller  TYPE REF TO if_wd_controller,
    lr_message_manager TYPE REF TO if_wd_message_manager.

  DATA:
    text_success TYPE string,
    text_error   TYPE string.

  text_error = wd_assist->if_wd_component_assistance~get_text( key = '001' ).
  text_success = wd_assist->if_wd_component_assistance~get_text( key = '002' ).

  lr_query_node = wd_context->get_child_node( 'STUDENT_QUERY' ).
  lr_node = wd_context->get_child_node( 'STUDENT' ).

  lr_api_controller ?= wd_this->wd_get_api( ).

  lr_message_manager = lr_api_controller->get_message_manager( ).

  lr_query_node->get_attribute(
    EXPORTING name = 'MATRIKELNUMMER'
    IMPORTING value = lv_id_student ).

  SELECT * FROM zz3002_student
       "INTO CORRESPONDING FIELDS OF itab_student
       INTO TABLE lt_student
       WHERE matrikelnummer = lv_id_student.

  "ENDSELECT.

  TRY.

      IF sy-subrc = 0.

        lr_node->bind_table(
          new_items = lt_student
         ).

      ELSE.
        RAISE EXCEPTION TYPE zcx_3002_exception
          EXPORTING
            textid         = zcx_3002_exception=>no_matrikelnummer
            matrikelnummer = lv_id_student.
      ENDIF.

    CATCH zcx_3002_exception INTO obj.

      lr_message_manager->report_exception( message_object = obj ).

  ENDTRY.

ENDMETHOD.