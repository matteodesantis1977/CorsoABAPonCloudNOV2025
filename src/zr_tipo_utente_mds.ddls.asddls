@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tipo utente'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_tipo_utente_mds as select from ztipo_utente_mds
{
    key id as Id,
    descrizione as Descrizione,
    limitazioni as Limitazioni,
    @Semantics.amount.currencyCode: 'Valuta'
    prezzo as Prezzo,
    valuta as Valuta
}
