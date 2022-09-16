import { LightningElement, track } from 'lwc';
import getContact from '@salesforce/apex/FetchingRecords.getContact';
import getOpportunity from '@salesforce/apex/FetchingRecords.getOpportunity';
import getCases from '@salesforce/apex/FetchingRecords.getCases';
import getAccountList from '@salesforce/apex/FetchingRecords.getAccountList';

export default class DisplayRecords extends LightningElement {
    listContact;
    listOpp;
    listCase;
    output;
    @track nameAccount;
    @track data =[];
    @track itemList=[];
    @track value;
    view=false;
    viewConTable=false;
    viewCaseTable=false;
    viewOppTable=false;
    @track idAccount;
    column=[{fieldName:'Name', label:'Name'},{fieldName:'Id', label:'Id'}];
    caseColumn=[{fieldName:'Id', label:'Id'},{fieldName:'CaseNumber', label:'Case Number'}];
    handleClick(event){
        this.viewConTable=false;
        this.viewCaseTable=false;
        this.viewOppTable=false;
        var inp = this.template.querySelector("lightning-input");
        console.log('OUTPUT inp.value : ',inp.value);
        this.nameAccount = inp.value;
        getAccountList({input : this.nameAccount})
        .then(result => {
            if(result.length !== 0){
                this.view=true;
            }
            else{
                this.output="There is no account named "+this.nameAccount;
            }
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
        this.sequentialRecords();
    }
    sequentialRecords(){
        getContact({accId : this.idAccount})
        .then((result1) => {
            if(result1.length !== 0){
                this.viewConTable=true;
            }
            this.listContact = result1;
            getOpportunity({accId : this.idAccount})
            .then((result2) => {
                if(result2.length !== 0){
                    this.viewOppTable=true;
                } 
                this.listOpp = result2;
            })
            getCases({accId : this.idAccount})
            .then((result3)=>{
                if(result3.length !== 0){
                    this.viewCaseTable=true;
                }
                this.listCase = result3;
            })
        })
    }
}
