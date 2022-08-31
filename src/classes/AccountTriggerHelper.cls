public with sharing class AccountTriggerHelper {
    public static Boolean propertyFlag = true;
    public static Boolean conFlag = true;
    public static void addAccountPrefix (List<Account> newAccount) {
        for(Account accounts : newAccount){
            if(accounts.Type==null || accounts.AccountNumber==null){
                accounts.addError('Account type and Account Number cannot be null');
            }
            if(accounts.Type !=null && accounts.AccountNumber!=null){
                if(accounts.Type=='Saving' && !accounts.AccountNumber.startsWith('SA-') ){
                    accounts.AccountNumber='SA-'+accounts.AccountNumber;
                }
                if(accounts.Type=='Fixed Deposit' && !accounts.AccountNumber.startsWith('FD-')){
                    accounts.AccountNumber='FD-'+accounts.AccountNumber;
                }
            }
        }
    }
    public static void afterInsertMail(List<Account> newAccount){
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        for(Account accounts : newAccount){
            Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{accounts.Email__c});
            mail.setSubject('Account is Created for:  '+ accounts.Name);
            String body = 'Hi, '+accounts.Name+' your account is created. Your Account Number is : '+ accounts.AccountNumber;
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }  
    public static void checkContextVariable(List<Account> newAccount, List<Account> oldAccount, System.TriggerOperation operation, Map<id,Account> newMap,  Map<id,Account> oldMap){
        system.debug('operation type : '+ operation);
        system.debug('Check  List ::: Trigger.New ' + newAccount);
        system.debug('Check List ::: Trigger.old ' + oldAccount);
        system.debug('Check  List ::: Trigger.NewMap' + newMap);
        system.debug('Check List ::: Trigger.oldMap' + oldMap);
    }
    public static void accountStatusSync(List <Account> newList, Map<Id,Account> oldMap){
        Map<Id,String> accIdStatusMap = new Map<Id,String>(); 
        Set<Property__c> propertySet = new Set<Property__c>();
        for(Account newAcc : newList){
            if(newAcc.Status__c != oldMap.get(newAcc.Id).Status__c){
                accIdStatusMap.put(newAcc.Id,newAcc.Status__c);
            }
        }
        if(!accIdStatusMap.isEmpty()){
            Map<Id,Contact> conMap = new Map<Id,Contact>([Select Status__c, AccountId, Account.Property__r.Status__c from Contact where AccountId in :accIdStatusMap.keySet()]);
            for(Contact con : conMAp.values()){
                if(conFlag){
                    con.Status__c = accIdStatusMap.get(con.AccountId);
                }
                if(propertyFlag){
                    PropertyTriggerHelper.accFlag = false;
                    con.Account.Property__r.Status__c = accIdStatusMap.get(con.AccountId);
                    propertySet.add(con.Account.Property__r);
                }
            }
            if(conFlag){
                update conMAp.values();
            }
            if(!propertySet.isEmpty()){
                update new List<Property__c>(propertySet);
            }
        }
    }
}