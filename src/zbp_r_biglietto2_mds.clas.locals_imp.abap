CLASS lhc_zr_biglietto2_mds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto.
ENDCLASS.

CLASS lhc_zr_biglietto2_mds IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.
    DATA: lv_id  TYPE zr_biglietto2_mds-IdBiglietto,
          lv_max TYPE cl_numberrange_runtime=>nr_number.

    DATA: lv_object        TYPE cl_numberrange_buffer=>nr_object,
          lv_subobject     TYPE cl_numberrange_buffer=>nr_subobject,
          lv_ignore_buffer TYPE cl_numberrange_buffer=>nr_ignore_buffer,
          lv_interval      TYPE cl_numberrange_buffer=>nr_interval,
          lv_quantity      TYPE cl_numberrange_buffer=>nr_quantity.

**    SELECT MAX( IdBiglietto )
**    FROM zr_biglietto2_mds
**    INTO @DATA(lv_max).

*    WITH +big AS (
*      SELECT MAX( IdBiglietto ) AS max
*        FROM  zr_biglietto2_mds
*      UNION
*      SELECT MAX( IdBiglietto ) AS max
*        FROM zbglietto2_mds_d
*    )
*
*    SELECT MAX(  max )
*    FROM +big AS big
*    INTO @DATA(lv_max).

    LOOP AT entities INTO DATA(ls_entity).
      IF ls_entity-IdBiglietto IS INITIAL.
**        TRY.
*        cl_numberrange_runtime=>number_get(
*          EXPORTING
*            ignore_buffer     = 'X'
*            nr_range_nr       = '01'
*            object            = 'ZID_BIGMDS'
*            quantity          = 1
**            subobject         =
**            toyear            =
*          IMPORTING
*            number            = lv_max
**            returncode        =
**            returned_quantity =
*        ).
**        CATCH cx_nr_object_not_found.
**        CATCH cx_number_ranges.

        lv_object = 'ZID_BIGMDS'.
        lv_interval = '01'.
        lv_quantity = 1.
        TRY.
            DATA(lo_get_number) = cl_numberrange_buffer=>get_instance( ).
            lo_get_number->if_numberrange_buffer~number_get_no_buffer(
              EXPORTING
                iv_object            = lv_object
                iv_subobject         = lv_subobject
                iv_interval          = lv_interval
*                iv_toyear            = lv_year
                iv_quantity          = lv_quantity
                iv_ignore_buffer     = abap_true
              IMPORTING
                ev_number            = lv_max
*                ev_returned_quantity = lv_returned_qunatity
).
          CATCH cx_number_ranges INTO DATA(lr_error).
        ENDTRY.

        lv_max += 1.
        lv_id = lv_max.
      ELSE.
        lv_id = ls_entity-IdBiglietto.
      ENDIF.

      APPEND VALUE #(
        %cid = ls_entity-%cid
        %is_draft = ls_Entity-%is_draft
        IdBiglietto = lv_id
       ) TO mapped-biglietto.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
