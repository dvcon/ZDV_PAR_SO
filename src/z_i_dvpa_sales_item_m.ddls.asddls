@AbapCatalog.sqlViewName: 'ZDVPASOITEMM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Composite view (Managed)'
@Metadata.allowExtensions: true
define view Z_I_DVPA_Sales_Item_M
  as select from Z_I_DVPA_Sales_Item
  association to parent Z_I_DVPA_Sales_Header_M as _SD_Head_M on $projection.sales_doc_num = _SD_Head_M.sales_doc_num 
{
  key sales_doc_num,
  key item_position,
      mat_num,
      mat_desc,
      unit_cost,
      total_item_cost,
      cost_currency,
      quantity,
      unit,
      last_changed,
//      /* Associations */
//      _SD_Head
      _SD_Head_M
}
