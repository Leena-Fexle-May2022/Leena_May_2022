import { LightningElement,api } from 'lwc';
export default class ChildWebComponent extends LightningElement {
    display="before";
    @api updateParent(){
        this.display="child data";
    }
}