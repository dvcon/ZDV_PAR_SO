@AbapCatalog.sqlViewName: 'ZDVPASOHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Header Basic Interface View'
@ObjectModel.representativeKey: 'sales_doc_num'
@ObjectModel.semanticKey: ['sales_doc_num']
define view Z_I_DVPA_Sales_Header
  as select from zdvpa_vbak
  association [0..*] to Z_I_DVPA_Sales_Item as _SD_Item on $projection.sales_doc_num = _SD_Item.sales_doc_num
{
  key vbeln                  as sales_doc_num,
      erdat                  as date_created,
      @Semantics.user.createdBy: true
      ernam                  as person_created,
      vkorg                  as sales_org,
      vtweg                  as sales_dist,
      spart                  as sales_div,
      @Semantics.amount.currencyCode: 'cost_currency'
      netwr                  as total_cost,
      waerk                  as cost_currency,
      faksk                  as block_status,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_timestamp as last_changed,
      _SD_Item
}
