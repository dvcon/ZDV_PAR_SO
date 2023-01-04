CLASS lhc_DVPA_SOHeadM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS blockOrder FOR MODIFY
      IMPORTING keys FOR ACTION DVPA_SOHeadM~blockOrder RESULT result.

    METHODS unblockOrder FOR MODIFY
      IMPORTING keys FOR ACTION DVPA_SOHeadM~unblockOrder RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR DVPA_SOHeadM RESULT result.

ENDCLASS.

CLASS lhc_DVPA_SOHeadM IMPLEMENTATION.

  METHOD blockOrder.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_key>).

      MODIFY ENTITY Z_I_DVPA_Sales_Header_M
             UPDATE FIELDS ( block_status )
             WITH VALUE #( ( sales_doc_num = <ls_key>-sales_doc_num
                             block_status = '99' ) )
             REPORTED reported
             FAILED failed.

    ENDLOOP.

    READ ENTITY Z_I_DVPA_Sales_Header_M
         ALL FIELDS
         WITH VALUE #( ( sales_doc_num = <ls_key>-sales_doc_num ) )
         RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                      ( sales_doc_num = ls_result-sales_doc_num
                        %param-sales_doc_num = ls_result-sales_doc_num
                        %param-block_status = ls_result-block_status ) ).
  ENDMETHOD.

  METHOD unblockOrder.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_key>).

      MODIFY ENTITY Z_I_DVPA_Sales_Header_M
             UPDATE FIELDS ( block_status )
             WITH VALUE #( ( sales_doc_num = <ls_key>-sales_doc_num
                             block_status = '' ) )
             REPORTED reported
             FAILED failed.

    ENDLOOP.

    READ ENTITY Z_I_DVPA_Sales_Header_M
         ALL FIELDS
         WITH VALUE #( ( sales_doc_num = <ls_key>-sales_doc_num ) )
         RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                      ( sales_doc_num = ls_result-sales_doc_num
                        %param-sales_doc_num = ls_result-sales_doc_num
                        %param-block_status = ls_result-block_status ) ).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITY Z_I_DVPA_Sales_Header_M
         ALL FIELDS
         WITH VALUE #( FOR ls_key IN keys ( sales_doc_num = ls_key-sales_doc_num ) )
         RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                      ( %tky = ls_result-sales_doc_num
*                        %update = COND #( WHEN ls_result-block_status = '' THEN if_abap_behv=>fc-f-unrestricted
*                                          ELSE if_abap_behv=>fc-f-read_only )
                        %delete = COND #( WHEN ls_result-block_status = '' THEN if_abap_behv=>fc-o-enabled
                                          ELSE if_abap_behv=>fc-o-disabled )
                        %assoc-_SD_Item_M = COND #( WHEN ls_result-block_status = '' THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled ) ) ).

  ENDMETHOD.

ENDCLASS.

*CLASS lcl_save DEFINITION INHERITING FROM cl_abap_behavior_saver.
*
*  PROTECTED SECTION.
*    METHODS save_modified REDEFINITION.
*
*ENDCLASS.
*
*CLASS lcl_save IMPLEMENTATION.
*
*  METHOD save_modified.
*
*    DATA lt_dvpa_vbak     TYPE STANDARD TABLE OF zdvpa_vbak.
*
*    IF delete-dvpa_soheadm IS NOT INITIAL.
*
*      lt_dvpa_vbak = VALUE #( FOR ls_dvpa_soheadm IN delete-dvpa_soheadm ( vbeln = ls_dvpa_soheadm-sales_doc_num ) ).
*
*      DELETE zdvpa_vbak FROM TABLE @lt_dvpa_vbak.
*      IF sy-subrc <> 0.
*
*      ELSE.
*
*      ENDIF.
*    ENDIF.
*
*  ENDMETHOD.
*
*ENDCLASS.
