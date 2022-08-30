public with sharing class DistrictTriggerHelper {
    public static void updateStateRecord(List <District__c> newList, Map<Id, District__c> oldMap){
        Map <Id,Integer> mapStateCount = new Map <Id,Integer>();
        Map <Id,Integer> mapCountryCount = new Map <Id,Integer>();
        if(newList != null){
            for(District__c recDistrict : newList){
                if(oldMap != null){
                    District__c oldDistrict = oldMap.get(recDistrict.Id);
                    if(oldDistrict.State__c != recDistrict.State__c){
                        if(mapStateCount.containsKey(recDistrict.State__c)){
                            Integer num =  mapStateCount.get(recDistrict.State__c);
                            mapStateCount.put(recDistrict.State__c, ++num);
                        }
                        else{
                            mapStateCount.put(recDistrict.State__c, 1);
                        }
                        
                        if(mapStateCount.containsKey(oldDistrict.State__c)){
                            Integer num =  mapStateCount.get(oldDistrict.State__c);
                            mapStateCount.put(oldDistrict.State__c,--num);    
                        }
                        else{
                            mapStateCount.put(oldDistrict.State__c, -1);  
                        }
                    }
                    oldDistrict=null;
                }
                else{
                    if(mapStateCount.containsKey(recDistrict.State__c)){
                        Integer num =  mapStateCount.get(recDistrict.State__c);
                        mapStateCount.put(recDistrict.State__c, ++num);
                    }
                    else{
                        mapStateCount.put(recDistrict.State__c, 1);
                    }    
                }  
            }
        }
        else{
            for(District__c oldDist : oldMap.values()){
                if(mapStateCount.containsKey(oldDist.State__c)){
                    Integer num =  mapStateCount.get(oldDist.State__c);
                    mapStateCount.put(oldDist.State__c, --num);    
                }
                else{
                    mapStateCount.put(oldDist.State__c, -1);
                }
            }
        }
        List<State__c> listState = [Select Id, Name, Count_District__c, Country__r.Name, Country__r.Count_District__c from State__c where Id IN: mapStateCount.keySet() All Rows];
        Set<String> startsWithSet = new Set<String>();
        for(State__c recState : listState){
            startsWithSet.add(recState.Country__r.Name.left(1));
            Integer districtCount = mapStateCount.get(recState.Id);
            if(recState.Count_District__c != null){
                recState.Count_District__c = recState.Count_District__c + districtCount;
                if(mapCountryCount.containsKey(recState.Country__r.Id)){
                    Integer num = mapCountryCount.get(recState.Country__r.Id);
                    num += districtCount;
                    mapCountryCount.put(recState.Country__r.Id, num);
                }
                else{
                    mapCountryCount.put(recState.Country__r.Id, districtCount);
                }
            }
            else{
                recState.Count_District__c = districtCount;  

                if(mapCountryCount.containsKey(recState.Country__r.Id)){
                    Integer num = mapCountryCount.get(recState.Country__r.Id);
                    num += districtCount;
                    mapCountryCount.put(recState.Country__r.Id, num);
                }
                else{
                    mapCountryCount.put(recState.Country__r.Id, districtCount);
                }
            }
        }
        if(listState.size()>0){
            update listState;
        }
        List<Country__c> listCountry = new List<Country__c>();
        for(State__c recState : listState){
            Integer districtCount = mapCountryCount.get(recState.Country__r.Id);
            if(districtCount != 0){
                if(recState.Country__r.Count_District__c != null){
                    recState.Country__r.Count_District__c += districtCount;
                }
                else{
                    recState.Country__r.Count_District__c = districtCount;
                }  
                listCountry.add(recState.Country__r);
            }
        }
       
        if(listCountry.size()>0){
            update listCountry;
        }
        for(String start: startsWithSet){
            new DynamicCountryStatesDistricts(start);
        }  
    }
}