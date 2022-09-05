import { LightningElement } from 'lwc';
export default class ParentLwc extends LightningElement {
    percentage = 50;
    handlePercent(event){
        this.percentage=event.detail;
    }
}