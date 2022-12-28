@AbapCatalog.sqlViewName: 'ZDVPASOITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Item Basic Interface View'
@ObjectModel.representativeKey: 'item_position'
@ObjectModel.semanticKey: ['sales_doc_num', 'item_position']
define view Z_I_DVPA_Sales_Item
  as select from zdvpa_vbap
  association [1..1] to Z_I_DVPA_Sales_Header as _SD_Head on $projection.sales_doc_num = _SD_Head.sales_doc_num
{
  key vbeln                  as sales_doc_num,
  key posnr                  as item_position,
      matnr                  as mat_num,
      @Semantics.text: true
      arktx                  as mat_desc,
      @Semantics.amount.currencyCode: 'cost_currency'
      netpr                  as unit_cost,
      @Semantics.amount.currencyCode: 'cost_currency'
      netwr                  as total_item_cost,
      waerk                  as cost_currency,
      @Semantics.quantity.unitOfMeasure: 'unit'
      kpein                  as quantity,
      kmein                  as unit,
      @Semantics.systemDateTime.createdAt: true
      last_changed_timestamp as last_changed,
      _SD_Head
}
