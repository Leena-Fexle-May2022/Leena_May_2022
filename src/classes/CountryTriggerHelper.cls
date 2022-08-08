public with sharing class CountryTriggerHelper {
    public static void displayCountryRecords(List<Country__c> newList, Map<Id,Country__c> oldMap){
        if(oldMap !=null){
            System.debug('New List');
            for(Country__c countryRec : newList){
                System.debug('Country Name : '+countryRec.Name + ', Country Code : '+countryRec.Code__c);
            }
            /*
            delete new List;
            DML Operations cannot be performed on Trigger.new and Trigger.old.
            DML operations can only be used in Triggers on other objects.
            When the trigger is fired there is a before and after, the before is used to update the current record 
            without stating any DML.
            */
        } 
        else{
            for(Country__c countryRec : newList){
                System.debug('Before Modification record ');
                System.debug('Country Name : '+oldMap.get(countryRec.Id).Name + ', Country Code : '+oldMap.get(countryRec.Id).Code__c);
                /*
                oldMap.get(countryRec.Id).Name + 'modify';
                not allowed in any of the triggers because trigger.old /trigger.oldMap is always read only.
                */
                System.debug('After Modification record ');
                System.debug('Country Name : '+countryRec.Name + ', Country Code : '+countryRec.Code__c);
                /*
                countryRec.Name + 'modify';
                this statement is alowed in before insert and before update trigger events. 
                But it is not allowed in after update and after update trigger events because records are read only
                */
            }
        }   
    }
}