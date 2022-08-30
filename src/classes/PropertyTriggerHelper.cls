public class PropertyTriggerHelper {
    public static Boolean accFlag = true;
    public static void propertyStatusSync(List <Property__c> newList, Map<Id,Property__c> oldMap){
        if(accFlag){
            Map<Id,String> propertyIdStatusMap = new Map<Id,String>(); 
            for(Property__c newproperty : newList){
                if(newproperty.Status__c != oldMap.get(newproperty.Id).Status__c){
                    propertyIdStatusMap.put(newproperty.id,newproperty.Status__c);
                }
            }
            if(!propertyIdStatusMap.isEmpty()){
                AccountTriggerHelper.propertyFlag = false;
                Map<Id,Account> mapAcc = new Map<Id ,Account>([Select Status__c, Property__r.Id  from Account where Property__r.Id In :propertyIdStatusMap.keySet()]);
                if(!mapAcc.isEmpty()){
                    for(Account acc: mapAcc.values()){
                        acc.Status__c = propertyIdStatusMap.get(acc.Property__r.Id);
                    }
                    update mapAcc.values();
                }
            }
        }
    }
}