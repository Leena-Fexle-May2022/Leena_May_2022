/*
  *  Purpose         :    Adding prefix to account number and sending mails
  *  Created By      :    Leena Ahuja
  *  Created Date    :    2022/07/20
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
trigger Trigger_Account on Account (before insert, after insert,before update) {
    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHelper.afterInsertMail(Trigger.New);       
    }
    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHelper.addAccountPrefix(Trigger.New);
    }
    if(Trigger.isUpdate){
        AccountTriggerHelper.checkUpdate(Trigger.New, Trigger.Old);
    }
}