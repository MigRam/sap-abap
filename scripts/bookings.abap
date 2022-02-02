METHOD wddobeforeaction .

  DATA lo_nd_connection TYPE REF TO if_wd_context_node.
  DATA lo_el_connection TYPE REF TO if_wd_context_element.
  DATA ls_connection TYPE wd_this->element_connection.

*     get message manager
  DATA lo_api_controller     TYPE REF TO if_wd_controller.
  DATA lo_message_manager    TYPE REF TO if_wd_message_manager.

  DATA lt_params TYPE wdr_name_value_list.
  DATA wa_param TYPE wdr_name_value.

  DATA lt_spfli TYPE TABLE OF spfli.

* navigate from <CONTEXT> to <CONNECTION> via lead selection
  lo_nd_connection = wd_context->get_child_node( name = wd_this->wdctx_connection ).

* @TODO handle non existant child
* IF lo_nd_connection IS INITIAL.
* ENDIF.

* get element via lead selection
  lo_el_connection = lo_nd_connection->get_element( ).
* @TODO handle not set lead selection
*  IF lo_el_connection IS INITIAL.
*  ENDIF.

* get all declared attributes
  lo_el_connection->get_static_attributes(
    IMPORTING
      static_attributes = ls_connection ).

  SELECT * FROM spfli
    INTO TABLE lt_spfli
    WHERE carrid = ls_connection-carrid
    AND connid = ls_connection-connid.


  IF sy-subrc <> 0.
    wa_param-name = 'carrid'.
    wa_param-value = ls_connection-carrid.
    APPEND wa_param TO lt_params.

    wa_param-name = 'connid'.
    wa_param-value = ls_connection-connid.
    APPEND wa_param TO lt_params.

    lo_api_controller ?= wd_this->wd_get_api( ).

    SELECT carrid connid FROM spfli
      INTO CORRESPONDING FIELDS OF TABLE lt_spfli
      WHERE carrid = ls_connection-carrid
      AND connid = ls_connection-connid.

    CALL METHOD lo_api_controller->get_message_manager
      RECEIVING
        message_manager = lo_message_manager.

*     report message
    CALL METHOD lo_message_manager->report_element_error_message
      EXPORTING
        message_text = ` Keine Flüge zu &carrid von &connid. `
        element      = lo_el_connection
*       attributes   =
        params       = lt_params
*       msg_user_data             =
*       is_permanent = ABAP_FALSE
*       scope_permanent_msg       = CO_MSG_SCOPE_CTXT_ELEMENT
*       msg_index    =
*       cancel_navigation         =
*       is_validation_independent = ABAP_FALSE
*       enable_message_navigation =
*       view         =
*       component    =
*      RECEIVING
*       message_id   =
      .
  ENDIF.




ENDMETHOD.

####################################################################

DATA lo_componentcontroller TYPE REF TO ig_componentcontroller .

  lo_componentcontroller =   wd_this->get_componentcontroller_ctr( ).

    lo_componentcontroller->read_flights(
    ).

####################################################################


METHOD read_flights .
  DATA lo_nd_connection TYPE REF TO if_wd_context_node.

  DATA lo_el_connection TYPE REF TO if_wd_context_element.

  DATA ls_connection TYPE wd_this->element_connection.

*   navigate from <CONTEXT> to <CONNECTION> via lead selection
  lo_nd_connection = wd_context->get_child_node( name = wd_this->wdctx_connection ).

*   @TODO handle non existant child
*   IF lo_nd_connection IS INITIAL.
*   ENDIF.

*   get element via lead selection
  lo_el_connection = lo_nd_connection->get_element( ).
*   @TODO handle not set lead selection
*  IF lo_el_connection IS INITIAL.
*  ENDIF.

*   get all declared attributes
  lo_el_connection->get_static_attributes(
    IMPORTING
      static_attributes = ls_connection ).

  " Task
  DATA: itab_connection TYPE TABLE OF if_componentcontroller=>element_flightdata,
        node_flightdata TYPE REF TO if_wd_context_node.

  SELECT * FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE itab_connection
    WHERE carrid = ls_connection-carrid
    AND connid = ls_connection-connid.

  node_flightdata = wd_context->get_child_node( name = 'FLIGHTDATA' ).

  CALL METHOD node_flightdata->bind_table
    EXPORTING
      new_items = itab_connection.



ENDMETHOD.

####################################################################



METHOD read_bookings .
* General Notes
* =============
* A common scenario for a supply method is to aquire key
* informations from the parameter <parent_element> and then
* to invoke a data provider.
* A free navigation thru the context, especially to nodes on
* the same or deeper hierachical level is strongly discouraged,
* because such a strategy may easily lead to unresolvable
* situations!!

*  if necessary, get static attributes of parent element
  "DATA ls_flight TYPE wd_this->element_flightdata.
  DATA ls_flight TYPE if_componentcontroller=>element_flightdata.
  parent_element->get_static_attributes(
    IMPORTING
      static_attributes = ls_flight ).
*
** data declaration
  DATA lt_bookingdata TYPE wd_this->elements_bookingdata. "lokale Tabelle bookignsdata
  DATA ls_bookingdata LIKE LINE OF lt_bookingdata. "lokale struktur bokkingsdata
  "DATA stru_flight TYPE if_componentcontroller=>element_flightdata. "struktur von typ der flugtabelle des kontexts
** @TODO compute values
** e.g. call a data providing FuBa
*

  SELECT *
    FROM sbook
    WHERE carrid = @ls_flight-carrid
    AND connid = @ls_flight-connid
    AND fldate = @ls_flight-fldate
    INTO TABLE @lt_bookingdata.

** bind all the elements
  node->bind_table(
    new_items            =  lt_bookingdata
    set_initial_elements = abap_true ).

ENDMETHOD.