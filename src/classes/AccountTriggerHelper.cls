public with sharing class AccountTriggerHelper {
    public static void addAccountPrefix (List<Account> newAccount) {
        for(Account accounts : newAccount){
            if(accounts.Type==null && accounts.AccountNumber==null){
                accounts.addError('Account type and Account Number cannot be null');
            }
            if(accounts.Type=='Saving' && !accounts.AccountNumber.startsWith('SA-') ){
                accounts.AccountNumber='SA-'+accounts.AccountNumber;
            }
            if(accounts.Type=='Fixed Deposit' && !accounts.AccountNumber.startsWith('FD-')){
                accounts.AccountNumber='FD-'+accounts.AccountNumber;
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
    public static void checkUpdate(List<Account> newAccount, List<Account> oldAccount){
        system.debug('Check Update List ::: Trigger.New ' + newAccount);
        system.debug('Check Update List ::: Trigger.old ' + oldAccount);
    }   
}