public with sharing class ContactTriggerHandler {
    public static void insertStatus(List <Contact> newList){
        List <Contact> contactList = new List <Contact>();
        Set <Id> setAccount = new Set <Id>();
        List <Account> listAcc = new List <Account>(); 
        for(Contact newCon : newList){
            if(newCon.Status__c == null){
                contactList.add(newCon);
                setAccount.add(newCon.AccountId);
            }
        }
        Map <Id, Account> accMap = new Map <Id, Account> ([select Status__c, Property__r.Status__c from Account where Id In : setAccount]);
		for(Contact con : contactList){
            if(accMap.get(con.AccountId).Status__c != null){
            	con.Status__c =accMap.get(con.AccountId).Status__c;
            }
			else if(accMap.get(con.AccountId).Property__r.Status__c != null){
				con.Status__c = accMap.get(con.AccountId).Property__r.Status__c;
                accMap.get(con.AccountId).Status__c = accMap.get(con.AccountId).Property__r.Status__c;
                listAcc.add(accMap.get(con.AccountId));
            }    
        }
        if(!listAcc.isEmpty()){
            update listAcc;
        } 
    }
    public static void contactStatusSync(List<Contact> newList, Map<id,Contact> oldMap){
        Map<id,String> accIdStatusMap = new Map<id,String>();
        for(Contact newCon : newList){
            if(newCon.Status__c != oldMap.get(newCon.Id).Status__c){
                accIdStatusMap.put(newCon.AccountId,newCon.Status__c);
            } 
        }
        if(!accIdStatusMap.isEmpty()){
            AccountTriggerHelper.conFlag= false;
            Map <Id, Account> accMap = new Map <Id, Account> ([Select Status__c, Property__r.Status__c from Account where Id In : accIdStatusMap.keySet()]);
            for(Account acc : accMap.values()){
                acc.Status__c = accIdStatusMap.get(acc.Id);
            }
            update accMap.values();
        }
    }
}