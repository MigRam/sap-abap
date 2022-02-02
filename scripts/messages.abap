MESSAGE TABELLE

    lr_message_manager->report_t100_message(
    msgid = 'ZZ_3002_T100MESSAGE'
    msgno = '000'
    msgty = 'E' ).


bind to table
  node->bind_structure(
     new_item                 = the_new_item
     set_initial_elements = abap_false ). " false tells it to append instead of replace

     DATA lr_subnode TYPE REF TO if_wd_context_node.

        lr_subnode = lr_node->get_child_node( 'STUDENT' ).
        lr_subnode->bind_table( new_items = lt_student ).


GET ALL STUDENTS

DATA itab TYPE TABLE ZZ3002_STUDENT.

SELECT * FROM ZZ3002_STUDENT
INTO TABLE itab.

###############################################

implementierung überprüfung vorname

METHOD zuerst als initerface im COMPONENTCONTROLLER definieren.

METHOD ueberpruefen_vorname .
DATA lr_node TYPE REF TO if_wd_context_node.
DATA ls_node TYPE if_componentcontroller=>element_student.
DATA lv_vorname TYPE string.
DATA lr_api_controller TYPE REF TO if_wd_controller.
DATA lr_message_manager TYPE REF TO if_wd_message_manager.
lr_node = wd_context->get_child_node( ’STUDENT’ ).
lr_node->get_attribute( EXPORTING name = ’VORNAME’
IMPORTING value = lv_vorname ).
IF lv_vorname IS INITIAL.
lr_api_controller ?= wd_this->wd_get_api( ).
lr_message_manager = lr_api_controller->get_message_manager( ).
lr_message_manager->report_error_message(
message_text = ’Das Vornamemfeld ist leer!’). # nicht empfohlen wegen der Sprachspezifikation
ENDIF.
ENDMETHOD.


VIEW GEBRAUCH
METHOD onactionanzeigen.
DATA: lr_interfacecontroller TYPE REF TO yiwci__em_context_rm .
lr_interfacecontroller = wd_this->wd_cpifc_context( ).
lr_interfacecontroller-> ueberpruefen_vorname( ).
ENDMETHOD


DATA lv_id_bewerber TYPE yperson-id_person.
DATA lr_node TYPE REF TO if_wd_context_node.
DATA ls_data TYPE wd_this->element_bewerber.
lr_node = wd_context->get_child_node(’PRUF_ID’).
lr_node->get_attribute( EXPORTING name = ’PRUF_ID’
IMPORTING value = lv_id_bewerber ).


MIME
Anlegen->Mime Objekt -> Importieren.


HOOKS
WdDoModifyView sollte nur für UI-Manipulationen, aber nicht für die dynamische Erstellung von Context-Knoten und Context-Attributen eingesetzt werden.

METHOD wddomodifyview .
DATA lv_bind_name TYPE string.
DATA lv_bind_greeting TYPE string.
DATA lr_link_to_action TYPE REF TO cl_wd_link_to_action.
DATA lr_container TYPE REF TO cl_wd_group.
DATA lr_flow_data TYPE REF TO cl_wd_flow_data.
DATA lr_input_field TYPE REF TO cl_wd_input_field.
DATA lr_text_view TYPE REF TO cl_wd_text_view.
DATA lr_label TYPE REF TO cl_wd_label.
IF first_time EQ abap_true.
lr_label = cl_wd_label=>new_label(
id = ’LBL_NAME’
label_for = ’NAME’
text = ’NAME’ ).
lr_flow_data = cl_wd_flow_data=>new_flow_data( element =
lr_label ).
lr_container ?= view->get_element( ’GRP’ ).
lr_container->add_child( lr_label ).
lv_bind_name = ’PERSON.NAME’.
lr_input_field = cl_wd_input_field=>new_input_field(
id = ’NAME’
bind_value = lv_bind_name ).
lr_flow_data = cl_wd_flow_data=>new_flow_data(
element = lr_input_field ).
lr_container->add_child( lr_input_field ).
lr_link_to_action = cl_wd_link_to_action=>new_link_to_action(
id = ’LTA_LINKTOACTION’
on_action = ’NEXT’
image_source = ’NEXT.JPG’ ).
lr_flow_data = cl_wd_flow_data=>new_flow_data( element =
lr_link_to_action ).
lr_container->add_child( lr_link_to_action ).
lv_bind_greeting = ’PERSON.GREETING’.
lr_text_view = cl_wd_text_view=>new_text_view(
id = ’TXV_NAME’
bind_text = lv_bind_greeting ).
lr_flow_data = cl_wd_flow_data=>new_flow_data( element =
lr_text_view ).
lr_container->add_child( lr_text_view ).
ENDIF.
ENDMETHOD.

METHOD onactionnext.
DATA: lv_name TYPE string,
lv_greeting TYPE string.
DATA lr_node TYPE REF TO if_wd_context_node.
DATA ls_data TYPE wd_this->element_person.
lr_node = wd_context->get_child_node( ’PERSON’ ).
lr_node->get_attribute( EXPORTING name = ’NAME’
IMPORTING value = lv_name ).
CONCATENATE
’Willkommen’ lv_name INTO lv_greeting SEPARATED BY space.
ls_data-greeting = lv_greeting.
lr_node->set_static_attributes( ls_data ).
ENDMETHOD.


required: state = cl_wd_input_field=>e_state-required



INBOUND OUTBOUND PLUG METHODS onaction example
METHOD onactionweiter .
DATA: lr_api_controller TYPE REF TO if_wd_controller,
lr_api_manager TYPE REF TO if_wd_message_manager.
lr_api_controller?= wd_this->wd_get_api( ).
lr_message_manager = lr_api_controller->get_message_manager( ).
wd_this->fire_op_to_v_view2_plg( p_mm = lr_message_manager ).
ENDMETHOD.



########################################################################


METHOD onactionquery_student .

  wd_comp_controller->check_student( ).

ENDMETHOD.

METHOD onactionsave_student .

  "wd_comp_controller->create_student( ).

   DATA:
    text_success TYPE string,
    text_error   TYPE string.

  text_error = wd_assist->if_wd_component_assistance~get_text( key = '001' ).

  text_success = wd_assist->if_wd_component_assistance~get_text( key = '002' ).

  DATA:
    lr_node    TYPE REF TO if_wd_context_node,
    lt_student TYPE REF TO zz3002_student,
    lv_matr    TYPE i,
    lv_name    TYPE string,
    lv_vorname TYPE string,
    lv_fach    TYPE string.

  lr_node = wd_context->get_child_node( 'DATA' ).

  lr_node->get_attribute(
    EXPORTING name = 'MATRIKELNUMMER'
    IMPORTING value = lv_matr ).

  lr_node->get_attribute(
      EXPORTING name = 'NAME'
      IMPORTING value = lv_name ).

  lr_node->get_attribute(
    EXPORTING name = 'VORNAME'
    IMPORTING value = lv_vorname ).

  lr_node->get_attribute(
    EXPORTING name = 'STUDIENFACH'
    IMPORTING value = lv_fach ).

  DATA  wa_student TYPE zz3002_student.

  wa_student-mandt = sy-mandt.
  wa_student-matrikelnummer = lv_matr.
  wa_student-name = lv_name.
  wa_student-vorname = lv_vorname.
  wa_student-studienfach = lv_fach.

  DATA:
    lr_api_controller  TYPE REF TO if_wd_controller,
    lr_message_manager TYPE REF TO if_wd_message_manager.

  lr_api_controller ?= wd_this->wd_get_api( ).

  lr_message_manager = lr_api_controller->get_message_manager( ).

  IF lv_matr IS INITIAL OR lv_name IS INITIAL.

    lr_message_manager->report_error_message( message_text = text_error ).

  ELSE.
" TODO CHECK IF STUDENT EXIST AND CLEAR INPUT VALUE AFTER SAVED DATA

    INSERT INTO zz3002_student VALUES wa_student.
    lr_message_manager->report_success( message_text = text_success ).


text_success = |Student mit der ID: { lv_matr } erfolgreich gespeichert!.|.
  ENDIF.

ENDMETHOD.


########################################################################
########################################################################


