@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMPONENTI_MDS'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMPONENTI_MDS
  as projection on ZR_COMPONENTI_MDS
  association [1..1] to ZR_COMPONENTI_MDS as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto and $projection.Progressivo = _BaseEntity.Progressivo  
{
  key IdBiglietto,
  key Progressivo,
  TipoUtente,
  @Semantics: {
    user.createdBy: true
  }
  Creatoda,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  Creatoa,
  @Semantics: {
    user.lastChangedBy: true
  }
  Modificatoda,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Modificatoa,
//  @Semantics: {
//    systemDateTime.localInstanceLastChangedAt: true
//  }
//  Locallastchanged,
  Stato,
  _BaseEntity,
  _Biglietto : redirected to parent ZC_BIGLIETTO2_MDS 
}
