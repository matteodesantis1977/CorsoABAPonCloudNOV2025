CLASS zcl_mds_estrazione_flight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mds_estrazione_flight IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT carrier_id
      FROM /dmo/flight
      INTO TABLE @DATA(lt_flight).

    out->write(
      EXPORTING
        data   = lt_flight
*        name   =
*      RECEIVING
*        output =
    ).
  ENDMETHOD.
ENDCLASS.
