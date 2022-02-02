METHOD wddoinit .
  DATA lo_nd_destination_from TYPE REF TO if_wd_context_node.

  DATA lo_el_destination_from TYPE REF TO if_wd_context_element.
  DATA ls_destination_from TYPE wd_this->element_destination_from.
  DATA lv_city TYPE wd_this->element_destination_from-city.

*   navigate from <CONTEXT> to <DESTINATION_FROM> via lead selection
  lo_nd_destination_from = wd_context->path_get_node( path = `IMPORTING.DESTINATION_FROM` ).
*    lo_nd_destination_from = wd_context->get_element().

*   @TODO handle non existant child
*   IF lo_nd_destination_from IS INITIAL.
*   ENDIF.

*   get element via lead selection
  lo_el_destination_from = lo_nd_destination_from->get_element( ).

*   @TODO handle not set lead selection
  IF lo_el_destination_from IS INITIAL.
  ENDIF.

*   @TODO fill attribute
*   lv_city = 1.

*   Abflugstadt mit den meisten Flugverbindungen.

*  DATA: count     TYPE i,
*        condition TYPE string.
*
*  condition = 'COUNT(*) > 5'.
*
*  SELECT DISTINCT cityfrom
*    INTO @DATA(city)
*    FROM spfli
*    GROUP BY cityfrom
*    HAVING (condition).
*    lv_city =  city.
*  ENDSELECT.



  SELECT cityfrom,
  COUNT(*) AS cnt
  FROM spfli
  INTO @DATA(city)
  UP TO 1 ROWS
  GROUP BY cityfrom
  ORDER BY cnt DESCENDING.
    lv_city = city-cityfrom.
  ENDSELECT.

*   set single attribute
  lo_el_destination_from->set_attribute(
    name =  `CITY`
    value = lv_city ).


ENDMETHOD.



resutls_view
##########

DATA lo_componentcontroller TYPE REF TO ig_componentcontroller .
lo_componentcontroller =   wd_this->get_componentcontroller_ctr( ).

  lo_componentcontroller->execute_bapi_flight_getlist(
  ).