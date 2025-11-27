CLASS lhc_zr_biglietto2_mds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto,
      CheckStatus FOR VALIDATE ON SAVE
        IMPORTING keys FOR Biglietto~CheckStatus,
      GetDefaultsForCreate FOR READ
        IMPORTING keys FOR FUNCTION Biglietto~GetDefaultsForCreate RESULT result,
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features FOR Biglietto RESULT result,
      onSave FOR DETERMINE ON SAVE
        IMPORTING keys FOR Biglietto~onSave,
      CustomDelete FOR MODIFY
        IMPORTING keys FOR ACTION Biglietto~CustomDelete RESULT result.
ENDCLASS.

CLASS lhc_zr_biglietto2_mds IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.
    DATA: lv_id   TYPE zr_biglietto2_mds-IdBiglietto,
          lv_max  TYPE cl_numberrange_runtime=>nr_number,
          lv_curr TYPE cl_numberrange_runtime=>nr_number.

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

    IF entities IS NOT INITIAL.
      LOOP AT entities INTO DATA(ls_entity).
        IF ls_entity-IdBiglietto IS INITIAL.
          TRY.
              cl_numberrange_runtime=>number_get(
                EXPORTING
                  ignore_buffer     = ' '
                  nr_range_nr       = '01'
                  object            = 'ZID_BIGMDS'
                  quantity          = 1 "CONV #( lines( all_entities ) )
*            subobject         =
*            toyear            =
                IMPORTING
                  number            = lv_max
                  returncode        = DATA(retcode)
                  returned_quantity = DATA(return_qty)
              ).
            CATCH cx_nr_object_not_found.
            CATCH cx_number_ranges.
          ENDTRY.

*      lv_curr = lv_max - return_qty.

*          lv_curr += 1.
*          lv_id = lv_curr.
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
    ENDIF.
  ENDMETHOD.

  METHOD CheckStatus.
    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto2_mds.
    READ ENTITIES OF zr_biglietto2_mds
      IN LOCAL MODE
      ENTITY Biglietto
      FIELDS ( Stato )
      WITH CORRESPONDING #( keys )
      RESULT lt_biglietto.

    LOOP AT lt_biglietto INTO DATA(ls_biglietto)
                         WHERE stato NE 'BOZZA'
                           AND stato NE 'FINALE'
                           AND stato NE 'CANC'.

* Non valorizzando FAILED posso mettere il warning sotto
      APPEND VALUE #( %tky = ls_biglietto-%tky
**                      %is_draft = ls_biglietto-%is_draft
                    ) TO failed-biglietto.
      APPEND VALUE #( %tky = ls_biglietto-%tky
                      %msg = NEW zcx_error_biglietti_mds(
                        textid   = zcx_error_biglietti_mds=>gc_invalid_status
**                        previous =
                        severity = if_abap_behv_message=>severity-error
*                        severity = if_abap_behv_message=>severity-warning
                        iv_stato = ls_biglietto-Stato
                        )
                        %element-Stato = if_abap_behv=>mk-on
                    ) TO reported-biglietto.
    ENDLOOP.
  ENDMETHOD.

  METHOD GetDefaultsForCreate.
    result = VALUE #( FOR key IN keys (
                 %cid = key-%cid
                 %param-stato = 'BOZZA'
                  ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    DATA: ls_result LIKE LINE OF result.

    READ ENTITIES OF zr_biglietto2_mds IN LOCAL MODE
      ENTITY Biglietto FIELDS ( Stato ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto INTO DATA(ls_biglietto).
      CLEAR ls_result.
      ls_result-%tky = ls_biglietto-%tky.
      ls_result-%field-Stato = if_abap_behv=>fc-f-read_only.
      ls_result-%action-CustomDelete = COND #(
        WHEN ls_biglietto-Stato = 'FINALE'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled ).

      APPEND ls_result
          TO result.

*      APPEND VALUE #(
*        %tky = ls_biglietto-%tky
*
*        %field-Stato = if_abap_behv=>fc-f-read_only
*                    ) TO result.
    ENDLOOP.

*    MODIFY ENTITIES OF zr_biglietto2_mds
*        IN LOCAL MODE
*        ENTITY Biglietto
*        UPDATE FROM lt_update.
  ENDMETHOD.

  METHOD onSave.
    READ ENTITIES OF zr_biglietto2_mds IN LOCAL MODE
      ENTITY Biglietto FIELDS ( Stato ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto INTO DATA(ls_biglietto)
                         WHERE stato EQ 'BOZZA'.
      MODIFY ENTITIES OF zr_biglietto2_mds
          IN LOCAL MODE
          ENTITY Biglietto
          UPDATE FROM VALUE #( (
            %tky = ls_biglietto-%tky
            Stato = 'FINALE'
            %control-Stato = if_abap_behv=>mk-on
          ) ).
    ENDLOOP.

  ENDMETHOD.

  METHOD CustomDelete.
*    mapped-biglietto = VALUE #(
*      FOR line IN keys
*       ( %tky = line-%tky ) ).
*    result = VALUE #(
*      FOR line IN keys
*       ( %tky = line-%tky
*         %param-Stato = 'CANC' ) ).
    DATA: lt_update TYPE TABLE FOR UPDATE zr_biglietto2_mds,
          ls_update LIKE LINE OF lt_update.

    READ ENTITIES OF zr_biglietto2_mds
      IN LOCAL MODE
      ENTITY Biglietto
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<biglietto>).
      <biglietto>-Stato = 'CANC'.
      APPEND VALUE #( %tky = <biglietto>-%tky
                      %param = <biglietto> )
          TO result.
      ls_update = CORRESPONDING #( <biglietto> ).
      ls_update-%control-Stato = if_abap_behv=>mk-on.
      APPEND ls_update TO lt_update.
    ENDLOOP.

    MODIFY ENTITIES OF zr_biglietto2_mds
        IN LOCAL MODE
        ENTITY Biglietto
        UPDATE FROM lt_update.

  ENDMETHOD.

ENDCLASS.
