public with sharing class DynamicCountryStatesDistricts {
    String jsonData; //json data string
    List<Country__c> countryName= new List<Country__c>(); //List country Name
    Map <String,Map<String, List<String>>> countryHierarchy= new Map <String,Map<String, List<String>>>();

    //Wrapper class
    public class CountryWrapper {
        String countryName{set;get;}
        Decimal code{set;get;}
        Decimal numberOfDistricts{set;get;}
        Decimal numberOfStates{set;get;}
        List <StateWrapper> stateList = new List <StateWrapper> ();
        public CountryWrapper(Decimal code, String nameCountry,Set <String> stateList1, Map<String,List<String>> districtList ){
            this.countryName=nameCountry;
            this.code=code; 
            List <AggregateResult> totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Country__r.Name like :nameCountry
                                    group by State__r.Country__r.Name Limit 1];
            if(!totalDistrict.isEmpty()){
                numberOfDistricts= (Decimal)totalDistrict[0].get('TotalDistricts');  
            }   
            List <AggregateResult> totalState = [Select COUNT(Name) Total_States from State__c where Country__r.Name =:nameCountry 
                                          group by Country__r.Name];
            if(!totalState.isEmpty()){
            	numberOfStates=(Decimal)totalState[0].get('Total_States'); 
            }
            for(String state:stateList1){
                StateWrapper objStateWrapper = new StateWrapper(state,districtList.get(state));
                this.stateList.add(objStateWrapper);
            }                           
        }
        public CountryWrapper(Decimal code, String nameCountry){
            this.code=code;
            List <AggregateResult> totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Country__r.Name = :nameCountry
                                            group by State__r.Country__r.Name];
            if(!totalDistrict.isEmpty()){
                numberOfDistricts= (Decimal)totalDistrict[0].get('TotalDistricts');   
            }      
            
            List <AggregateResult> totalState = [Select COUNT(Name) Total_States from State__c where Country__r.Name =:nameCountry 
                                          group by Country__r.Name];     
            if(!totalState.isEmpty()){
                numberOfStates=(Decimal)totalState[0].get('Total_States'); 
            }
            
        }
    }
    public class StateWrapper{
        List <DistrictWrapper> districtList = new List <DistrictWrapper>();
        String stateName{get; set;}
        Decimal totalDistrict{get; set;}
        public StateWrapper(String stateName, List <String> districtList ){
            this.stateName=stateName;
            List <AggregateResult>  totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Name = :stateName
                                            group by State__r.Name];
            if(!totalDistrict.isEmpty()){
                this.totalDistrict =(Decimal)totalDistrict[0].get('TotalDistricts'); 
            }
            for(String districtName:districtList){
                DistrictWrapper objWrapDistrict = new DistrictWrapper(districtName);
                this.districtList.add(objWrapDistrict);
            }
        }
    }
    public class DistrictWrapper{
        public String districtName{get;set;}
        public DistrictWrapper(String districtName){
            this.districtName = districtName;
        }
    }

    //Constructor with parametrised keyword to update Hierarchy Field
    public DynamicCountryStatesDistricts(String start) {
        Map<id,Country__c> mapOfCountry=new Map<id,Country__c>();
        List<District__c> districts=[select Name, State__r.Name,  State__r.Country__r.Code__c, State__r.Country__r.Name 
                                     from District__c where Name like :start+'%' and State__r.Name like :start+'%' and 
                                     State__r.Country__r.Name like :start+'%'];
        try {
            if(!districts.isEmpty()){
                for(District__c districtob :districts){
                    if(!countryHierarchy.containsKey(districtob.State__r.Country__r.Name)){
                        countryHierarchy.put(districtob.State__r.Country__r.Name,new Map<String,List <String>>());
                    }
                    if(!countryHierarchy.get(districtob.State__r.Country__r.Name).containsKey(districtob.State__r.Name)){
                        countryHierarchy.get(districtob.State__r.Country__r.Name).put(districtob.State__r.Name,new List<String>());
                    }
                    if(!countryHierarchy.get(districtob.State__r.Country__r.Name).get(districtob.State__r.Name).contains(districtob.Name)){
                        countryHierarchy.get(districtob.State__r.Country__r.Name).get(districtob.State__r.Name).add(districtob.Name);
                    }
                    System.debug('Map of country: '+countryHierarchy);
                    CountryWrapper wrapobject = new CountryWrapper(districtob.State__r.Country__r.Code__c,districtob.State__r.Country__r.Name,
                                                                   countryHierarchy.get(districtob.State__r.Country__r.Name).keyset(),
                                                                   countryHierarchy.get(districtob.State__r.Country__r.Name));
                    jsonData = Json.serialize(wrapobject);
                    districtob.State__r.Country__r.Hierarchy__c = jsonData; 
                    System.debug('Hierarchy Field on country object '+districtob.State__r.Country__r.Hierarchy__c); 
                    mapOfCountry.put(districtob.State__r.Country__r.id,districtob.State__r.Country__r);
                }
                System.debug('Map of country: '+countryHierarchy);
                if(!mapOfCountry.values().isEmpty()){
                    update mapOfCountry.values() ;
                }
            }
            else {
                throw new NotFoundCountryException();    
            }   
        }
        catch (NotFoundCountryException e) {
            countryName=[select Name,Code__c from Country__c where Name Like :start+'%'];
            try{
                if(!countryName.isEmpty()){
                    for(Country__c country:countryName){
                        CountryWrapper wrapobject = new CountryWrapper(country.Code__c,country.Name);
                        jsonData=Json.serialize(wrapobject);
                        country.Hierarchy__c=jsonData;
                        System.debug('Hierarchy Field on country object '+country.Hierarchy__c);
                    }
                    update countryName;
                } 
                else{
                    throw new NullCountryException();
                } 
            }
            catch(NullCountryException n){
                System.debug('No such country starts with string '+start);
            }
        }
    }

    //method to district greater than length passed as a parameter
    public void maxLengthDistrict(Integer maxLength){
        List <District__c> districtsName = [select Name from District__c];
        if(!districtsName.isEmpty()){
            System.debug('districts greater than equal to length '+maxLength);
            for(District__c district : districtsName ){
                if(maxLength<=district.Name.length())
                {
                    System.debug(district.Name);
                }
            }
        }
    }
}