import { LightningElement, api } from 'lwc';
export default class ContactListElement extends LightningElement {
    @api contact;

    handleClick(event) {
        // Prevent default behavior of anchor tag click which is to navigate to the href url
        event.preventDefault();
        // Fire the custom event
        this.dispatchEvent(new CustomEvent('select', {detail: this.contact.Id}));
    }
}