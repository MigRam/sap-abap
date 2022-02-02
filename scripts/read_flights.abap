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