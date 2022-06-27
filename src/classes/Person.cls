public virtual class Person {
    private String firstName;
    private String lastName;
    
    // without parametrize constructor
    public Person(){
        firstName='NULL';
        lastName='NULL';
    }
    
    //parametrized constructor
    public Person(String fName, String lName){
        firstName=fName;
        lastName=lName;
    }

    //use of virtual function
    public virtual void display(){
        System.debug('First Name : '+firstName);
        System.debug('Last Name : '+lastName);
    }
}