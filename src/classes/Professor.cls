public with sharing class Professor extends University.College {
    String name;
    public Professor(){
        this('null','null','null','null','null');
    }
    public Professor(String name,String name1,String address1, String name2,String address2) {
        super(name1,address1,name2,address2);
        this.name=name;  
    }
    public override void  display(){
        super.display();
        System.debug('Name of professor: '+name);
    }
}