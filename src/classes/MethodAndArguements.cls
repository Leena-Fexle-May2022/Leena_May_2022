public with sharing class MethodAndArguements {
    public MethodAndArguements(){
        Integer value1=5;
        Integer value2=7;
        swap(value1,value2);
        System.debug('values outside the method value1= '+value1+' value2= '+value2);
        Integer[] mylist=new Integer[]{8,9};
        swapall(mylist);
        System.debug('list outside the method '+mylist);

    } 

    //use of method overloading
    public static void sum(Integer value1, Integer value2) {
        System.debug('addition is: '+(value1 + value2));
    }
    public static void sum(Integer value1, Integer value2, Integer value3) {
        System.debug('addition is: '+(value1 + value2 + value3));
    }

    //swapping using call by value
    public void swap(Integer value1,Integer value2)
    {
        Integer value3=value1;
        value1=value2;
        value2=value3;
        System.debug('in method value1= '+value1+'value2= '+value2);
    }

    //swapping using call by refference
    public void swapall(List<integer> mylist)
    {
        Integer i=mylist[0];
        mylist[0]=mylist[1];
        mylist[1]=i;
        System.debug('in method list '+mylist);
    }
}