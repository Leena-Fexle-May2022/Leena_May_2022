/*
  *  Purpose         :    Adding prefix to account number and sending mails
  *  Created By      :    Leena Ahuja
  *  Created Date    :    2022/07/20
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
trigger Trigger_Account on Account (before insert, after insert,before update, after update, after delete, before delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHelper.afterInsertMail(Trigger.New);
            AccountTriggerHelper.checkContextVariable(Trigger.New,Trigger.Old,Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isUpdate){
            AccountTriggerHelper.accountStatusSync(Trigger.New, Trigger.OldMap);
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old,Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old,Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isUndelete){
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old,Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
    }

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHelper.addAccountPrefix(Trigger.New);
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old, Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isUpdate){
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old, Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old, Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isUndelete){
            AccountTriggerHelper.checkContextVariable(Trigger.New, Trigger.Old, Trigger.operationType,Trigger.newMap, Trigger.oldMap);
        }
    }
}