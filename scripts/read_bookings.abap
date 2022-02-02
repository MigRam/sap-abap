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