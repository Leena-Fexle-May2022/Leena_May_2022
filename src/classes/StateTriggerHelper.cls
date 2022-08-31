public with sharing class StateTriggerHelper {
    public static void updateCountryRecord(List <State__c> newList, Map<Id, State__c> oldMap){
        Map<Id,Integer> mapCountryCount = new Map<Id,Integer>();
        Map<Id,Decimal> mapCountrywithDistCount = new Map<Id,Decimal>();
        if(newList != null){
            for(State__c recState : newList){
                if(oldMap != null){
                    State__c oldState = oldMap.get(recState.Id);
                    if(oldState.Country__c != recState.Country__c){
                        if(mapCountryCount.containsKey(recState.Country__c)){
                            Integer count =  mapCountryCount.get(recState.Country__c);
                            if(mapCountrywithDistCount.containsKey(recState.Country__c)){
                               	if(recState.Count_District__c != null && recState.Count_District__c >0 ){
                                    Decimal districtCount = mapCountrywithDistCount.get(recState.Country__c) + recState.Count_District__c;
                                    mapCountrywithDistCount.put(recState.Country__c,districtCount);
                                }
                                else{
                                    mapCountrywithDistCount.put(recState.Country__c,recState.Count_District__c);      
                                }
                            }
                        }
                        else{
                            mapCountryCount.put(recState.Country__c,1);
                            if(recState.Count_District__c != null && recState.Count_District__c >0 ){
                            	mapCountrywithDistCount.put(recState.Country__c,recState.Count_District__c);
                            }
                        }
                        if(mapCountryCount.containsKey(oldState.Country__c)){
                            Integer count =  mapCountryCount.get(oldState.Country__c);
                            mapCountryCount.put(oldState.Country__c, count - 1); 
                            if(mapCountrywithDistCount.containsKey(recState.Country__c)){
                                if(recState.Count_District__c != null  && recState.Count_District__c >0){
                                    Decimal districtCount = mapCountrywithDistCount.get(oldState.Country__c) - oldState.Count_District__c;
                                    mapCountrywithDistCount.put(oldState.Country__c,districtCount);   
                                }
                                else{
                            		mapCountrywithDistCount.put(oldState.Country__c, -oldState.Count_District__c);  
                                }
                            }
                        }
                        else{
                            mapCountryCount.put(oldState.Country__c,-1);  
                            if(oldState.Count_District__c != null  && oldState.Count_District__c >0){
                            	mapCountrywithDistCount.put(oldState.Country__c, -oldState.Count_District__c);
                            }
                        }
                    }
                } 
                else{
                    if(mapCountryCount.containsKey(recState.Country__c)){
                        Integer count =  mapCountryCount.get(recState.Country__c);
                        mapCountryCount.put(recState.Country__c, count + 1);
                        if(mapCountrywithDistCount.containsKey(recState.Country__c)){
                        	if(recState.Count_District__c != null  && recState.Count_District__c >0){
                            	Decimal districtCount = mapCountrywithDistCount.get(recState.Country__c) + recState.Count_District__c;
                            	mapCountrywithDistCount.put(recState.Country__c,districtCount);
                            }
                            else{
                                mapCountrywithDistCount.put(recState.Country__c,recState.Count_District__c);  
                            }
                        }
                    }
                    else{
                        mapCountryCount.put(recState.Country__c, 1);
                        if(recState.Count_District__c != null  && recState.Count_District__c >0){
                        	mapCountrywithDistCount.put(recState.Country__c,recState.Count_District__c);
                        }
                    }    
                }
            }
        }
        
        else{
            for(State__c oldState : oldMap.values()){
                if(mapCountryCount.containsKey(oldState.Country__c)){
                    Integer count =  mapCountryCount.get(oldState.Country__c);
                    mapCountryCount.put(oldState.Country__c, count - 1);  
                    if(oldState.Count_District__c != null  && oldState.Count_District__c >0){
                    	if(mapCountrywithDistCount.containsKey(oldState.Country__c)){
                        	Decimal districtCount = mapCountrywithDistCount.get(oldState.Country__c);
                        	mapCountrywithDistCount.put(oldState.Country__c, districtCount - oldState.Count_District__c);
                    	}
                    	else{
                        	mapCountrywithDistCount.put(oldState.Country__c, -oldState.Count_District__c);
                    	}
                    }
                }
                else{
                    mapCountryCount.put(oldState.Country__c, -1);
                    if(oldState.Count_District__c != null  && oldState.Count_District__c >0){
                    	mapCountrywithDistCount.put(oldState.Country__c, -oldState.Count_District__c);
                    }
                }
            }
        }
        List<Country__c> listCountry = [Select Id, Name, Count_State__c, Count_District__c from Country__c where Id IN: mapCountryCount.keySet()];
        Set<String> startsWithSet = new Set<String>();
        for(Country__c recCountry : listCountry){
            startsWithSet.add(recCountry.Name.left(1));
            Integer stateCount = mapCountryCount.get(recCountry.Id);
            if(recCountry.Count_State__c != null){
                recCountry.Count_State__c = recCountry.Count_State__c + stateCount;
                if (!mapCountrywithDistCount.isEmpty()){   
                    if(recCountry.Count_District__c == null){
                        recCountry.Count_District__c = mapCountrywithDistCount.get(recCountry.id);
                    }
                    else{
                        recCountry.Count_District__c = recCountry.Count_District__c + mapCountrywithDistCount.get(recCountry.id);
                    }          
                }
            }
            else{
                recCountry.Count_State__c = stateCount; 
            }
        }
        if(!listCountry.isEmpty()){
            update listCountry;
        }
        for(String start: startsWithSet){
            new DynamicCountryStatesDistricts(start);
        }
    }
}