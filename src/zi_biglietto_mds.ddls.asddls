@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Biglietti'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BIGLIETTO_MDS
  as select from zbiglietto_mds as Biglietto
{
  key Biglietto.id_biglietto  as IdBiglietto,
      @Semantics.user.createdBy: true
      Biglietto.creato_da     as CreatoDa,
      @Semantics: { systemDateTime.createdAt: true }
      Biglietto.creato_a      as CreatoA,
      @Semantics.user.lastChangedBy: true
      Biglietto.modificato_da as ModificatoDa,
      @Semantics: { systemDateTime.lastChangedAt: true }
      Biglietto.modificato_a  as ModificatoA,

      case when creato_da = modificato_da
        then ' '
        else 'X'
      end                     as modificato
}
