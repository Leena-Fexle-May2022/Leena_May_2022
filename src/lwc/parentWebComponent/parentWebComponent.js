import { LightningElement } from 'lwc';
export default class ParentWebComponent extends LightningElement {
    handleClick(event){
        this.template.querySelector("c-child-web-component").updateParent();
    }
}