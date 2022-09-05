import { LightningElement } from 'lwc';
import getTextMethod1 from '@salesforce/apex/MethodCalling.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/MethodCalling.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/MethodCalling.getTextMethod3';
export default class SequenceDisplay extends LightningElement {
    connectedCallback(){
        this.methodCalling();
    }
    method1;
    method2;
    method3;
    methodCalling(){
        getTextMethod1()
        .then((result1) => {
            this.method1=result1;
            getTextMethod2()
            .then((result2) => {
                this.method2= result1+" "+result2;
                getTextMethod3()
                .then((result3) => {
                    this.method3= result1+" "+result2+" "+result3;
                })
            })
        })
    }
}