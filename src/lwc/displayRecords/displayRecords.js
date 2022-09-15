import { LightningElement, track } from 'lwc';
import getContact from '@salesforce/apex/FetchingRecords.getContact';
import getOpportunity from '@salesforce/apex/FetchingRecords.getOpportunity';
import getCases from '@salesforce/apex/FetchingRecords.getCases';
import getAccountList from '@salesforce/apex/FetchingRecords.getAccountList';

export default class DisplayRecords extends LightningElement {
    listContact;
    listOpp;
    listCase;
    @track nameAccount;
    @track data =[];
    @track itemList=[];
    @track value;
    view=false;
    viewTable=false;
    @track idAccount;
    column=[{fieldName:'Name', label:'Name'},{fieldName:'Id', label:'Id'}];
    caseColumn=[{fieldName:'Id', label:'Id'},{fieldName:'CaseNumber', label:'Case Number'}];
    handleClick(event){
        this.view=true;
        var inp = this.template.querySelector("lightning-input");
        this.nameAccount = inp.value;
        getAccountList({input : this.nameAccount})
        .then(result => {
            let listAccounts = result;
            this.itemList=[];
            for(var i=0;i<listAccounts.length;i++) {
                this.itemList.push({label: listAccounts[i].Name, value: listAccounts[i].Id});
            }
            this.data = this.itemList;
        });
    }
    get optionsAccount() {
        return this.data;    
    }
    handleChange(event){
        this.idAccount=event.detail.value;
        this.viewTable=true;
        this.sequentialRecords();
    }
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
