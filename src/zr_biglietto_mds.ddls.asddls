@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Biglietti'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_BIGLIETTO_MDS
  as select from ZI_BIGLIETTO_MDS as Biglietto
{
  key Biglietto.IdBiglietto  as IdBiglietto,
      @Semantics.user.createdBy: true
      Biglietto.CreatoDa     as CreatoDa,
      @Semantics: { systemDateTime.createdAt: true }
      Biglietto.CreatoA      as CreatoA,
      @Semantics.user.lastChangedBy: true
      Biglietto.ModificatoDa as ModificatoDa,
      @Semantics: { systemDateTime.lastChangedAt: true }
      Biglietto.ModificatoA  as ModificatoA,

      case when CreatoDa = ModificatoDa
        then ' '
        else 'X'
      end                    as modificato
}
