import { LightningElement, wire } from "lwc";

//1. Importing the named imports 
//[library to publish data and the message channel]

import { publish, MessageContext } from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";

export default class PublisherComponent extends LightningElement {
  //2. Wiring the MessageContext to a property
  @wire(MessageContext)
  messageContext;

  //3. Handling the user input.
  //which in our case is going to be a button click
  handleClick() {
    const messaage = {mssg: "Sample Messaging Service"};

    //4. Publishing the message
    publish(this.messageContext, MY_MESSAGE_CHANNEL, messaage);
  }
}