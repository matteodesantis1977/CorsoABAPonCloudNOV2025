@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_BIGLIETTI_MDS
  provider contract transactional_query
  as projection on ZI_BIGLIETTO_MDS
{
  key IdBiglietto,
      CreatoDa,
      CreatoA,
      ModificatoDa,
      ModificatoA,
      modificato
}
