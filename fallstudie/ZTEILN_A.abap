@AbapCatalog.sqlViewName: 'ZVTEILNA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View für Teilnehmer'
@ObjectModel.representativeKey: 'Teilnehmernummer'
@Analytics.dataCategory: #DIMENSION
define view ZTEILN_A
  as select from zteilnehmer02
  association [0..1] to I_Currency as _Currency on $projection.Waehrung = _Currency.Currency
{
      //zteilnehmer02
  key tnummer      as Teilnehmernummer,
      @Semantics.name.familyName: true
      @Semantics.text: true
      tname        as Teilnehmername,
      @Semantics.amount.currencyCode: 'Waehrung'
      tkurspreis   as Kurspreis,
      @Semantics.currencyCode: true
      twaehrung    as Waehrung,
      zzkurstitel  as Kurstitel,
      _Currency
} 
 