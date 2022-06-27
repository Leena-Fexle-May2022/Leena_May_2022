public with sharing class Student extends Person {
    Integer rollNumber;
    String course;

    // without parametrize constructor
    public Student() {
        super();
        rollNumber=0; 
        course='NULL';  
    }

    //parametrized constructor
    public Student(String fName, String lName, Integer rollNo, String stream){
        super(fName,lName);
        rollNumber=rollNo; 
        course=stream;
    }

    //overidding display method
    public override void display(){
        super.display();
        System.debug('Roll Number: '+rollNumber);
        System.debug('Course: '+course);
    }
}