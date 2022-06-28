public with sharing class Fruit {

    //outer class contructor
    public Fruit(){
        System.debug('This is outter class fruit constuctor');
    }

    //inner class Apple
    public class Apple{

        //inner class Apple constructor
        public Apple(){
            System.debug('This is inner class Apple constructor');
        }
        public void display(){
            System.debug('Apple is a Fruit');
        }
    }

    //inner class Banana
    public class Banana{
        //inner class Banana constructor
        public Banana(){
            System.debug('This is inner class banana  constructor');
        }
        public void display(){
            System.debug('Banana is a Fruit');
        }
    }
}