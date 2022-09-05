import { LightningElement } from 'lwc';
export default class ChildLwc extends LightningElement {
    handlePercentageChange(event){
       this.dispatchEvent(new CustomEvent('changepercent',{detail: event.target.value}));
    }
}