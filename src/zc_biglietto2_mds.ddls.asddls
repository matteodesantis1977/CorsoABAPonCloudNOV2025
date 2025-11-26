@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBIGLIETTO2_MDS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO2_MDS
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_BIGLIETTO2_MDS
  association [1..1] to ZR_BIGLIETTO2_MDS as _BaseEntity on $projection.IDBIGLIETTO = _BaseEntity.IDBIGLIETTO
{
  key IdBiglietto,
  @Semantics: {
    User.Createdby: true
  }
  CreatoDa,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatoA,
  @Semantics: {
    User.Lastchangedby: true
  }
  ModificatoDa,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  ModificatoA,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchanged,
  _BaseEntity
}
