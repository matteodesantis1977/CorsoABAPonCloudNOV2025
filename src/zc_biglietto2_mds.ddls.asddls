@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGLIETTO2_MDS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO2_MDS
  provider contract transactional_query
  as projection on ZR_BIGLIETTO2_MDS
  association [1..1] to ZR_BIGLIETTO2_MDS as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto
{
  key IdBiglietto,
  @Semantics: {
    user.createdBy: true
  }
  CreatoDa,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatoA,
  @Semantics: {
    user.lastChangedBy: true
  }
  ModificatoDa,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ModificatoA,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  Stato,
  _BaseEntity,
  _Componenti : redirected to composition child ZC_COMPONENTI_mds
}
