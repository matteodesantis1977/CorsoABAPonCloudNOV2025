CLASS zcl_mds_hello_cloud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      l_m_test
        IMPORTING
          iv_input      TYPE char3
        RETURNING
          VALUE(rv_ret) TYPE char10.
ENDCLASS.



CLASS zcl_mds_hello_cloud IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world!' ).
    out->write( 'Ciao Mondo!!!' ).
    out->write( l_m_test( 'Mat' ) ).
  ENDMETHOD.

  METHOD l_m_test.
    rv_ret = |Ciao { iv_input }|.
  ENDMETHOD.
ENDCLASS.
