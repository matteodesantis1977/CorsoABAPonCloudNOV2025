@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCOMPONENTI_MDS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
//define root view entity ZR_COMPONENTI_MDS
define view entity ZR_COMPONENTI_MDS
  as select from zcomponenti_mds
  association to parent ZR_BIGLIETTO2_MDS as _Biglietto
    on _Biglietto.IdBiglietto = $projection.IdBiglietto
{
  key id_biglietto as IdBiglietto,
  key progressivo as Progressivo,
  tipo_utente as TipoUtente,
  @Semantics.user.createdBy: true
  creatoda as Creatoda,
  @Semantics.systemDateTime.createdAt: true
  creatoa as Creatoa,
  @Semantics.user.lastChangedBy: true
  modificatoda as Modificatoda,
  @Semantics.systemDateTime.lastChangedAt: true
  modificatoa as Modificatoa,
//  @Semantics.systemDateTime.localInstanceLastChangedAt: true
//  locallastchanged as Locallastchanged,
  stato as Stato,
//Assocation
  _Biglietto
}
