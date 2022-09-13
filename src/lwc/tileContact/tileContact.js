import { LightningElement, wire, api } from 'lwc';
import getContactList from '@salesforce/apex/FetchingRecords.getContactList'
export default class TileContact extends LightningElement {
    @api flexipageRegionWidth;
    selectedContact;
    @wire(getContactList) contacts;
    handleSelect(event) {
        const contactId = event.detail;
        this.selectedContact = this.contacts.data.find(
            (contact) => contact.Id === contactId
        );
    }
}