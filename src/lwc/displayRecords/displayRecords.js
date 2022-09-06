import { LightningElement, track } from 'lwc';
import getContact from '@salesforce/apex/FetchingRecords.getContact';
import getOpportunity from '@salesforce/apex/FetchingRecords.getOpportunity';
import getCases from '@salesforce/apex/FetchingRecords.getCases';

export default class DisplayRecords extends LightningElement {
    listContact;
    listOpp;
    listCase;
    idAccount;
    handleClick(event){
        var inp = this.template.querySelector("lightning-input");
        this.idAccount = inp.value;
        //this.idAccount=this.template.querySelector('lightning-input');
        this.sequentialRecords();
    }
    column=[{fieldName:'Name', label:'Name'},{fieldName:'Id', label:'Id'}];
    caseColumn=[{fieldName:'Id', label:'Id'},{fieldName:'CaseNumber', label:'Case Number'}];
    sequentialRecords(){
        getContact({accId : this.idAccount})
        .then((result1) => {
            this.listContact = result1;
            getOpportunity({accId : this.idAccount})
            .then((result2) => {
                this.listOpp = result2;
            })
            getCases({accId : this.idAccount})
            .then((result3)=>{
                this.listCase = result3;
            })
        })
    }
}