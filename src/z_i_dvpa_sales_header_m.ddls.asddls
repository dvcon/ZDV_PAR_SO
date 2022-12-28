@AbapCatalog.sqlViewName: 'ZDVPASOHEADM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root CDS view (Managed)'
@Metadata.allowExtensions: true
define root view Z_I_DVPA_Sales_Header_M
  as select from Z_I_DVPA_Sales_Header
  composition [0..*] of Z_I_DVPA_Sales_Item_M as _SD_Item_M

{
  key sales_doc_num,
      date_created,
      person_created,
      sales_org,
      sales_dist,
      sales_div,
      total_cost,
      cost_currency,
      block_status,
      last_changed,
//      /* Associations */
//      _SD_Item
      _SD_Item_M
}
