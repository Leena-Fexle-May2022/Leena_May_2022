public class ExceptionHandling {
    public void insertOpp(Integer size){
        List<Opportunity> listOpp = new List<Opportunity>();
        for(Integer num=1 ;num<=size; num++){
            listOpp.add(new Opportunity(Name = 'Opportunity'+num, CloseDate = Date.Today()));
        }

        try{
            insert listOpp;
        }
        catch(DmlException e){
            System.debug('Error : '+e.getMessage());
        }
    }

}