CLASS zcl_biglietto_mds DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_biglietto_mds IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_biglietto_mds TYPE TABLE OF zbiglietto_mds WITH EMPTY KEY.
  ENDMETHOD.
ENDCLASS.
