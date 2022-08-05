public with sharing class OpportunityTriggerHelper {
    public static void checkDuplicateRecords(Set<String> sensorSet, String sensorType){
        if(sensorSet.size()>0){
            if(sensorType == 'Sensor')  {
                List <Automobile_Sensor__c> autoSensor = [select Name from Automobile_Sensor__c where Name IN :sensorSet ];
                for(Automobile_Sensor__c s1 : autoSensor){
                    sensorSet.remove(s1.Name);
                }
            }
            else if(sensorType == 'Presence Sensor')  {
            List <Automobile_Presence_Sensor__c> autoSensor = [select Name from Automobile_Presence_Sensor__c where Name IN :sensorSet ];
            for(Automobile_Presence_Sensor__c s1 : autoSensor){
                    sensorSet.remove(s1.Name);
                }
            }     
            else if(sensorType == 'TDU Sensor'){
                List<Automobile_TDU__c> autoSensor = [select Name from Automobile_TDU__c where Name IN :sensorSet ];
                for(Automobile_TDU__c s1 : autoSensor){
                    sensorSet.remove(s1.Name);
                }      
            }
            else if(sensorType == 'Tag Sensor'){
                List <Automobile_Tag__c> autoSensor = [select Name from Automobile_Tag__c where Name IN :sensorSet ];
                for(Automobile_Tag__c s1 : autoSensor){
                    sensorSet.remove(s1.Name);
                } 
            }
        }
    }

    public static void insertOpportunity(List<Opportunity> newOpp){
        List <Sobject> insertObject = new List <Sobject>();
        List <Opportunity> oppInsert = new List <Opportunity>(); 
        Set <String> setAutoSensor = new Set <String>();
        Set <String> setPresenceSensor = new Set <String>();
        Set <String> setTDU = new Set<String>();
        Set <String> setTag = new Set <String>();
        Map <string, Opportunity> mapSensorOpp = new Map<string, Opportunity>();
        for(Opportunity opp: newOpp){
            if(opp.StageName=='Shipped to Customer' || opp.StageName=='Return to Customer' || opp.StageName=='Return to HQ'){
                oppInsert.add(opp);
            }
        }  
        for(Opportunity opp: oppInsert){
            Set <String> sensorSet= new Set <String>();
            if(opp.Automobile_Tag_Details_1__c != null){
                sensorSet.addAll(opp.Automobile_Tag_Details_1__c.split('\n'));    
            }
            if(opp.Automobile_Tag_Details_2__c != null){
                sensorSet.addAll(opp.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(opp.Automobile_Tag_Details_3__c != null){
                sensorSet.addAll(opp.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(opp.Return_To_HQ__c != null){
                sensorSet.addAll(opp.Return_To_HQ__c.split('\n'));
            }
            for(String sensor :sensorSet){
                if(sensor.length()>18){
                    sensor = sensor.replace(sensor, sensor.substring(0,18));   
                }
                mapSensorOpp.put(sensor.deleteWhitespace(),opp);  
            }
        }
        for(String sensor: mapSensorOpp.keySet()){
            if(sensor.startsWith('00:11:CE:00')){
                setAutoSensor.add(sensor);     
            }  
            else if(sensor.startsWith('00:11:CE:D')){
                setPresenceSensor.add(sensor);    
            }
            else if(sensor.startsWith('00:11:CE:E')){
                setTDU.add(sensor);
            }
            else if(sensor.substring(0,3).isNumeric() && sensor.indexOf('-',3)==3 && sensor.indexOf('-',7)== 7){
                setTag.add(sensor); 
            }
        }
        if(!mapSensorOpp.isEmpty()){
            checkDuplicateRecords(setAutoSensor, 'Sensor');
            checkDuplicateRecords(setPresenceSensor, 'Presence Sensor');
            checkDuplicateRecords(setTDU, 'TDU Sensor');
            checkDuplicateRecords(setTag,'Tag Sensor');
            if(setAutoSensor.size()>0){
                for(String sensor : setAutoSensor){
                    Automobile_Sensor__c sensorRec = new Automobile_Sensor__c(Name = sensor, Opportunity__c = mapSensorOpp.get(sensor).id);
                    if(mapSensorOpp.get(sensor).StageName == 'Return to HQ'){
                        sensorRec.Account__c = mapSensorOpp.get(sensor).Shipment_Account__c;
                    }
                    else{
                        sensorRec.Account__c = mapSensorOpp.get(sensor).AccountId;  
                    }
                    insertObject.add(sensorRec);
                }
            }
            if(setPresenceSensor.size()>0){ 
                for(String sensor : setPresenceSensor){
                    Automobile_Presence_Sensor__c sensorRec = new Automobile_Presence_Sensor__c(Name = sensor, Opportunity__c = mapSensorOpp.get(sensor).id );
                    if(mapSensorOpp.get(sensor).StageName == 'Return to HQ'){
                        sensorRec.Account__c = mapSensorOpp.get(sensor).Shipment_Account__c;
                    }
                    else{
                        sensorRec.Account__c = mapSensorOpp.get(sensor).AccountId;  
                    }
                    insertObject.add(sensorRec);
                }
            }
            if(setTDU.size()>0){
                for(String sensor : setTDU){
                    Automobile_TDU__c sensorRec = new Automobile_TDU__c(Name = sensor, Opportunity__c = mapSensorOpp.get(sensor).id);
                    if(mapSensorOpp.get(sensor).StageName == 'Return to HQ'){
                        sensorRec.Account__c = mapSensorOpp.get(sensor).Shipment_Account__c;
                    }
                    else{
                        sensorRec.Account__c = mapSensorOpp.get(sensor).AccountId;  
                    }
                    insertObject.add(sensorRec);
                }
            }
            if(setTag.size()>0){
                for(String sensor : setTag){
                    Automobile_Tag__c sensorRec = new Automobile_Tag__c(Name = sensor, Opportunity__c = mapSensorOpp.get(sensor).id);
                        if(mapSensorOpp.get(sensor).StageName == 'Return to HQ'){
                                sensorRec.Account__c = mapSensorOpp.get(sensor).Shipment_Account__c;
                        }
                        else{
                            sensorRec.Account__c = mapSensorOpp.get(sensor).AccountId;  
                        }
                        insertObject.add(sensorRec);
                }
            }
        }
        if(insertObject!=null){
            insert insertObject;
        }         
    }


    public static void updateOpportunity(List<Opportunity> newOpp, Map<Id,Opportunity> mapOldOpp){
        List<SObject> listObject = new List<SObject>(); 
        Map <Id,Opportunity> mapOpp = new Map <Id,Opportunity>();
        Map<Id,Opportunity> mapAutoIdAndOpp = new Map <Id,Opportunity>();
        Set<String> setSensor = new Set<String>();
        for(Opportunity opp : newOpp){
            if(opp.StageName != mapOldOpp.get(opp.id).StageName){
                mapOpp.put(opp.Id,opp);
            }
        }
        if(!mapOpp.isEmpty()){
            listObject.addAll([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Sensor__c where Opportunity__c IN : mapOpp.keySet()]);
            listObject.addAll([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Presence_Sensor__c where Opportunity__c IN : mapOpp.keySet()]);
            listObject.addAll([Select Id, Name, Account__c,Account__r.Name, Opportunity__c from Automobile_TDU__c where Opportunity__c IN : mapOpp.keySet()]);
            listObject.addAll([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Tag__c where Opportunity__c IN : mapOpp.keySet()]);
        }
       
        for(Opportunity opp : mapOpp.values()){
            if(opp.StageName=='Return to HQ' && (mapOldOpp.get(opp.id).StageName=='Return to customer' || mapOldOpp.get(opp.id).StageName=='Shipped to Customer')){
                if(opp.Return_to_HQ__c != null){
                    List<String> listSensor = opp.Return_To_HQ__c.split('\n');
                    System.debug('listSensor = ' + listSensor);
                    for(Sobject sensor : listObject){
                        if(sensor.get('Opportunity__c') == opp.Id && listSensor.contains((String)sensor.get('Name'))){
                            sensor.put('Account__c', opp.Shipment_Account__c);
                        } 
                    }   
                }   
            }
            else if((mapOldOpp.get(opp.id).StageName=='Return to HQ')&& (opp.StageName=='Shipped to Customer' || opp.StageName=='Return to Customer')){
                List<String> listSensor = new List<String>();
                if(opp.Automobile_Tag_Details_1__c != null)
                listSensor.addAll(opp.Automobile_Tag_Details_1__c.split('\n'));
                if(opp.Automobile_Tag_Details_2__c != null)
                listSensor.addAll(opp.Automobile_Tag_Details_2__c.split('\n'));
                if(opp.Automobile_Tag_Details_3__c != null)
                listSensor.addAll(opp.Automobile_Tag_Details_3__c.split('\n'));    
                for(String sensor :listSensor){
                    if(sensor.length()>18){
                        sensor = sensor.replace(sensor, sensor.substring(0,18));   
                    }
                    listSensor.set(listSensor.indexOf(sensor),sensor.deleteWhitespace()); 
                }
                for(Sobject sensor : listObject){
                    if(sensor.get('Opportunity__c')==opp.Id && listSensor.contains((String)sensor.get('Name'))){
                        sensor.put('Account__c', opp.AccountId);
                    }
                }
            }
        }
        update listObject;    
    }


    public static void deleteRecords(List<Opportunity> listnewOpp, Map<Id,Opportunity> mapOldOpp ){
        List<SObject> listObject = new List<SObject>();
        Set <String> oldSensor = new Set<String>();
        Set<String> newSensor = new Set<String>();

        for(Opportunity newOpp : listnewOpp){
            if(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_1__c != null){
                oldSensor.addAll(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_1__c.split('\n'));
            }
            if(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_2__c != null){
                oldSensor.addAll(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_2__c.split('\n'));
            }
            if(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_3__c != null){
                oldSensor.addAll(mapOldOpp.get(newOpp.id).Automobile_Tag_Details_3__c.split('\n'));
            }
            if((mapOldOpp.get(newOpp.id).Return_To_HQ__c != null)){
                oldSensor.addAll(mapOldOpp.get(newOpp.id).Return_To_HQ__c.split('\n'));
            }


            if(newOpp.Automobile_Tag_Details_1__c != null){
                newSensor.addAll(newopp.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(newOpp.Automobile_Tag_Details_2__c != null){
                newSensor.addAll(newopp.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(newOpp.Automobile_Tag_Details_3__c != null){
                newSensor.addAll(newopp.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(newOpp.Return_To_HQ__c != null){
                newSensor.addAll(newopp.Return_To_HQ__c.split('\n'));
            }
        }
        for(String sensor :newSensor){
            String sensorEdit= sensor.deleteWhitespace();
            if(sensorEdit.length()>18){
                sensorEdit = sensorEdit.replace(sensorEdit, sensorEdit.substring(0,18));   
            }
            newSensor.remove(sensor);
            newSensor.add(sensorEdit);
        }
        for(String sensor :oldSensor){
            String sensorEdit= sensor.deleteWhitespace();
            if(sensorEdit.length()>18){
                sensorEdit = sensorEdit.replace(sensorEdit, sensorEdit.substring(0,18));   
            }
            oldSensor.remove(sensor);
            oldSensor.add(sensorEdit);
        }
        oldSensor.removeAll(newSensor);
        if(!oldSensor.isEmpty()){
            listObject.addAll([Select Name  from Automobile_Sensor__c where Name IN :oldSensor]);
            listObject.addAll([Select  Name  from Automobile_Presence_Sensor__c where Name IN :oldSensor]);
            listObject.addAll([Select Name from Automobile_TDU__c where Name IN :oldSensor]); 
            listObject.addAll([Select  Name  from Automobile_Tag__c where Name IN :oldSensor]);
            delete listObject;
        }     
    }
   

    public static void sendEmail2(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap){
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        Map <Id,Opportunity> mapOpp = new Map <Id,Opportunity>();
        Map<Id,Automobile_Sensor__c> mapAutoSensor;
        Map<Id,Automobile_Presence_Sensor__c> mapPresenceSensor  =new Map<Id,Automobile_Presence_Sensor__c>();
        Map<Id,Automobile_TDU__c> mapTDU  =new Map<Id,Automobile_TDU__c>();
        Map<Id,Automobile_Tag__c> mapTag =new Map<Id,Automobile_Tag__c>();
        Map<Id, User> mapUser;
        List<Id> listOwnerId = new List<Id>();
        for(Opportunity newOpp : newOppList){
            if(newOpp.StageName != oldOppMap.get(newOpp.id).StageName){
                mapOpp.put(newOpp.Id,newOpp);
                listOwnerId.add(newOpp.OwnerId);
            }
        }
        if(!mapOpp.isEmpty()){
            mapAutoSensor =new Map<Id,Automobile_Sensor__c>([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Sensor__c where Opportunity__c IN : mapOpp.keySet()]);
            mapPresenceSensor  =new Map<Id,Automobile_Presence_Sensor__c>([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Presence_Sensor__c where Opportunity__c IN : mapOpp.keySet()]);
            mapTDU  =new Map<Id,Automobile_TDU__c> ([Select Id, Name, Account__c,Account__r.Name, Opportunity__c from Automobile_TDU__c where Opportunity__c IN : mapOpp.keySet()]);
            mapTag = new Map<Id,Automobile_Tag__c>([Select Id, Name, Account__c, Account__r.Name, Opportunity__c from Automobile_Tag__c where Opportunity__c IN : mapOpp.keySet()]);
            mapUser = new  Map<Id, User>([Select Id, Name,Email From User Where Id IN :listOwnerId]);
        }
        for(Opportunity opp : mapOpp.values()){
            List <String> sensorName = new List<String>(); 
            if(opp.Automobile_Tag_Details_1__c != null){
                sensorName.addAll(opp.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(opp.Automobile_Tag_Details_2__c != null){
                sensorName.addAll(opp.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(opp.Automobile_Tag_Details_3__c != null){
                sensorName.addAll(opp.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(opp.Return_To_HQ__c != null){
                sensorName.addAll(opp.Return_To_HQ__c.split('\n'));
            }
            for(String sensor :sensorName){
                if(sensor.length()>18){
                    sensor = sensor.replace(sensor, sensor.substring(0,18));   
                }
                sensorName.set(sensorName.indexOf(sensor),sensor.deleteWhitespace()); 
            }
            if(sensorName.size()>0){
                Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{mapUser.get(opp.OwnerId).Email});
                System.debug(opp.Owner.Email);
                String subject = opp.Name+' '+System.today();
                mail.setSubject(subject);
                mail.setSenderDisplayName('Leena');
            
                String content='Sensor shipment process is completed. Please refer below mentioned details to get all the success and failure details.<br/><br/>Successful:<br/><table border="2">';            
                String rowDetails='<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

                for(Automobile_Sensor__c sensor : mapAutoSensor.values()){
                    if(sensor.Opportunity__c== opp.id ){
                        sensorName.remove(sensorName.indexOf(sensor.Name));
                        if(sensor.Account__c == opp.AccountId){
                            rowDetails = rowDetails + '<tr><td>Sensor</td><td>'+sensor.Name+'</td><td>Sensor inserted under installation account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                        else{
                            rowDetails = rowDetails + '<tr><td>Sensor</td><td>'+sensor.Name+'</td><td>Sensor moved from installation account to Shipment account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                    }
                }
                for(Automobile_Presence_Sensor__c sensor : mapPresenceSensor.values()){
                    if(sensor.Opportunity__c== opp.id ){
                        sensorName.remove(sensorName.indexOf(sensor.Name));
                        if(sensor.Account__c == opp.AccountId){
                            rowDetails = rowDetails + '<tr><td>Presence Sensor</td><td>'+sensor.Name+'</td><td>Sensor inserted under installation account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                        else{
                            rowDetails = rowDetails + '<tr><td>Presence Sensor</td><td>'+sensor.Name+'</td><td>Sensor moved from installation account to Shipment account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                    }          
                }
                for(Automobile_TDU__c sensor : mapTDU.values()){
                    if(sensor.Opportunity__c== opp.id ){
                        sensorName.remove(sensorName.indexOf(sensor.Name));
                        if(sensor.Account__c == opp.AccountId){
                            rowDetails = rowDetails + '<tr><td>TDU  Sensor</td><td>'+sensor.Name+'</td><td>Sensor inserted under installation account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                        else{
                            rowDetails = rowDetails + '<tr><td>TDU Sensor</td><td>'+sensor.Name+'</td><td>Sensor moved from installation account to Shipment account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                    }            
                }
                for(Automobile_Tag__c sensor : mapTag.values()){
                    if(sensor.Opportunity__c== opp.id ){
                        sensorName.remove(sensorName.indexOf(sensor.Name));
                        if(sensor.Account__c == opp.AccountId){
                            rowDetails = rowDetails + '<tr><td> Tag Sensor</td><td>'+sensor.Name+'</td><td>Sensor inserted under installation account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                        else{
                            rowDetails = rowDetails + '<tr><td> Tag Sensor</td><td>'+sensor.Name+'</td><td>Sensor moved from installation account to Shipment account : '+sensor.Account__r.Name+'</td></tr>';
                        }
                    }
                }
                content = content+rowDetails+'</table>'+'<br/>';
                if(!sensorName.isEmpty()){
                    content = content + 'unsucessfull <br/> <table border="2"> ';
                    rowDetails = '<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
                    for(String unsuccessfull : sensorName){
                        if(unsuccessfull.startsWith('00:11:CE:00')){
                            rowDetails = rowDetails + '<tr><td>Sensor</td><td>'+unsuccessfull+'</td><td>Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';

                        }
                        else if(unsuccessfull.startsWith('00:11:CE:D')){
                            rowDetails = rowDetails + '<tr><td> Presence Sensor</td><td>'+unsuccessfull+'</td><td>Presence Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                        }
                        else if(unsuccessfull.startsWith('00:11:CE:E')){
                            rowDetails = rowDetails + '<tr><td>TDU Sensor</td><td>'+unsuccessfull+'</td><td>TDU Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                        }
                        else if(unsuccessfull.substring(0,3).isNumeric() && unsuccessfull.indexOf('-',3)==3 && unsuccessfull.indexOf('-',7)==7){
                            rowDetails = rowDetails + '<tr><td>Tag Sensor</td><td>'+unsuccessfull+'</td><td>Tag Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                        }
                        else{
                            rowDetails = rowDetails + '<tr><td>Sensor</td><td>'+unsuccessfull+'</td><td> Invalid Sensor not inserted .</td></tr>';
                        }
                    }
                    content = content+rowDetails+'</table>';
                }

                mail.setHtmlBody(content);
                mails.add(mail);  
            }
        }
        if(mails.size()>0){
            Messaging.sendEmail(mails);   
        }
    }
}