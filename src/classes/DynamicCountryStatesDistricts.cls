public with sharing class DynamicCountryStatesDistricts {
    String jsonData; //json data string
    List<Country__c> countryName= new List<Country__c>(); //List country Name
    Map <String,Map<String, List<String>>> countryHierarchy= new Map <String,Map<String, List<String>>>();

    //Wrapper class
    public class CountryWrapper {
        Decimal code{set;get;}
        Decimal numberOfDistricts{set;get;}
        Decimal numberOfStates{set;get;}
        List <StateWrapper> stateList = new List <StateWrapper> ();
        public CountryWrapper(Decimal code, String nameCountry,StateWrapper state){
            this.code=code;
            AggregateResult totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Country__r.Name like :nameCountry
                                    group by State__r.Country__r.Name Limit 1];
            numberOfDistricts= (Decimal)totalDistrict.get('TotalDistricts');                      
            AggregateResult totalState = [Select COUNT(Name) Total_States from State__c where Country__r.Name =:nameCountry 
                                          group by Country__r.Name];
            numberOfStates=(Decimal)totalState.get('Total_States');                              
            stateList.add(state); 
        }
        public CountryWrapper(Decimal code, String nameCountry){
            this.code=code;
            AggregateResult totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Country__r.Name = :nameCountry
                                            group by State__r.Country__r.Name];
            numberOfDistricts= (Decimal)totalDistrict.get('TotalDistricts');                      
            AggregateResult totalState = [Select COUNT(Name) Total_States from State__c where Country__r.Name =:nameCountry 
                                          group by Country__r.Name];
            numberOfStates=(Decimal)totalState.get('Total_States');  
        }
    }
    public class StateWrapper{
        List <DistrictWrapper> districtList = new List <DistrictWrapper>();
        String stateName{get; set;}
        Decimal totalDistrict{get; set;}
        public StateWrapper(String stateName, List <DistrictWrapper> districtList ){
            this.stateName=stateName;
            this.districtList=districtList;
            AggregateResult totalDistrict =[Select Count(Name) TotalDistricts from District__c where State__r.Name = :stateName
                                            group by State__r.Name];
            this.totalDistrict =(Decimal)totalDistrict.get('TotalDistricts'); 
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
        List<District__c> districts=[select Name, State__r.Name,  State__r.Country__r.Code__c, State__r.Country__r.Name 
                                     from District__c where Name like :start+'%' and State__r.Name like :start+'%' and 
                                     State__r.Country__r.Name like :start+'%'];
        try {
            if(!districts.isEmpty()){
                for(Integer i=0;i<districts.size();i++){
                    List<DistrictWrapper> districtList = new List<DistrictWrapper>();
                    DistrictWrapper objWrapDistrict = new DistrictWrapper(districts[i].Name);
                    districtList.add(objWrapDistrict);
                    for(Integer j=i+1;j<districts.size();j++){
                        if(districts[i].State__r.Name==districts[j].State__r.Name){
                            objWrapDistrict = new DistrictWrapper(districts[j].Name);
                            districtList.add(objWrapDistrict);
                            i++;
                        }
                    }
                   
                    StateWrapper objStateWrapper = new StateWrapper(districts[i].State__r.Name,districtList);
                    CountryWrapper wrapobject = new CountryWrapper(districts[i].State__r.Country__r.Code__c,districts[i].State__r.Country__r.Name,
                                                                  objStateWrapper);
                    jsonData = Json.serialize(wrapobject);
                    districts[i].State__r.Country__r.Hierarchy__c = jsonData; 
                    System.debug('Hierarchy Field on country object '+districts[i].State__r.Country__r.Hierarchy__c); 
                    countryName.add(districts[i].State__r.Country__r);
                }
                update countryName;
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