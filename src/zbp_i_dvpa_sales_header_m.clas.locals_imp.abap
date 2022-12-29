CLASS lhc_DVPA_SOHeadM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS blockOrder FOR MODIFY
      IMPORTING keys FOR ACTION DVPA_SOHeadM~blockOrder RESULT result.

    METHODS unblockOrder FOR MODIFY
      IMPORTING keys FOR ACTION DVPA_SOHeadM~unblockOrder RESULT result.

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

ENDCLASS.
