public with sharing class CountryAndStates {
    //Map of continent code for country map with states anfd states map wih districts
    Map<String, Map<String, Map<String, List<String>>>> mapContinentCode = new Map<String, Map<String, Map<String, List<String>>>>();
    
    public CountryAndStates(){
        intializingData(); //calling private method for intializing data    
    }

    // intailising the data in the map
    private void intializingData(){
        List<String> listCountry = new List<String>{'India', 'Australia', 'Germany'};
        //India
        //For Rajasthan
        List<String> rajdistrict = new List<String>{'Sikar', 'Jaipur', 'Udaipur', 'Jodhpur'};
        //For Uttar Pradesh
        List<String> upDistrict = new List<String>{'Sultan', 'Lucknow', 'Agra', 'Mathura'};
        //For Uttarakhand
        List<String> ukDistrict = new List<String>{'Srinagar', 'Dehradun', 'Haridwar'};
        
        //China
        //For Shangai
        List<String> shangaiDistrict = new List<String>{'Haungpu', 'Nanhui', 'Xuhui'};
        //For Bejing
        List<String> bejingDistrict = new List<String>{'changping', 'pinggu', 'Chaoyang'};

        //Syria
        //For Safita
        List<String> safitaDistrict = new List<String>{'Safita'};
        //For Harem
        List<String> haremDistrict = new List<String>{'harem'};

        //Spain
        //For Soria
        List<String> soriaDistrict = new List<String>{'Soria','Pinares','Berlanga'};
        //For Barcelona
        List<String> barcelonaDistrict = new List<String>{'Nou Barris','Sant Andreu','Sant Marti'};

        Map<String, List<String>> mapIndia = new Map<String, List<String>>{'Rajasthan'=>rajdistrict , 'Uttar Pradesh'=>upDistrict , 'Uttarakhand'=>ukDistrict};
        Map<String, List<String>> mapChina = new Map<String, List<String>>{'Shangai'=>shangaiDistrict , 'Bejing'=>bejingDistrict};
        Map<String, List<String>> mapSyria = new Map<String, List<String>>{'Safita'=>safitaDistrict , 'Harem'=>haremDistrict};
        Map<String, List<String>> mapSpain = new Map<String, List<String>>{'Soria'=>soriaDistrict , 'Barcelona'=>barcelonaDistrict};

        Map<String, Map<String, List<String>>> mapAsia =  new Map<String, Map<String, List<String>>>{'India'=> mapIndia, 'China'=> mapChina, 'Syria'=> mapSyria};
        Map<String, Map<String, List<String>>> mapEurope =  new Map<String, Map<String, List<String>>>{'Spain'=> mapSpain};

        mapContinentCode.put('AS', mapAsia);
        mapContinentCode.put('EU',mapEurope);
    }

    //checking if country,state and district starts from same letter
    public void startsFrom(String letter){
        //When Country not found
        Boolean notFound=true;

        //To get Continent Code
        for(String continentCodes  : mapContinentCode.keySet())
        {
            //To get Continent Map
            Map<String, Map<String, List<String>>> mapContinentName = mapContinentCode.get(continentCodes);

            //To get Country Name
            for(String countries : mapContinentName.keySet())
            {
                //To check country starting with
                if(countries.startsWith(letter))
                {
                    //To get Country Map
                    Map<String, List<String>> mapState = mapContinentName.get(countries);

                    //To get State Name
                    for(String states : mapState.keySet())
                    {
                        //To check state starting with
                        if(states.startsWith(letter))
                        {
                            //To get district list
                            List<String> districtList = mapState.get(states);

                            //To get district name
                            for(String districts : districtList)
                            {
                                //To check district name
                                if(districts.startsWith(letter))
                                {
                                    System.debug('Country Name Starts with '+letter+' : '+countries);
                                    System.debug('State Name Starts with '+letter+' : '+states);
                                    System.debug('District Name Starts with '+letter+' : '+districts);

                                    notFound = false;
                                }
                            }
                        }
                    }
                }
            }
        } 
        
        if(notFound)
        {
            System.debug('Combination of Country, state and district not found with same alphabet : '+letter);
        }
    }

    //finding the district with the greater than max length
    public void largestLengthDistrict(Integer maxLength)
    {
        List<String> districtAll = new List<String>();

        for(String continentCodes  : mapContinentCode.keySet())
        {
            //To get Continent Map
            Map<String, Map<String, List<String>>> mapContinentName = mapContinentCode.get(continentCodes);

            //To get Country Name
            for(String countries : mapContinentName.keySet())
            {
                //To get Country Map
                Map<String, List<String>> mapState = mapContinentName.get(countries);
                //To get State Name
                for(String states : mapState.keySet())
                {
                    //To get district list
                    List<String> districtList = mapState.get(states);
                    //To get district name
                    for(String districts : districtList)
                    {
                        if(maxLength<districts.length())
                        {
                            districtAll.add(districts);
                        }

                    }
                }
            }
        }
        System.debug('District greater than length '+maxLength+' : '+ districtAll);
    }
}