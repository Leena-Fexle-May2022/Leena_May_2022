trigger Country_Trigger on Country__c (before insert, before update, after insert, after update) {
    CountryTriggerHelper.displayCountryRecords(Trigger.New,Trigger.oldMap);
}