import { LightningElement} from 'lwc';

export default class Calculator extends LightningElement {
    firstNum;
    secondNum;
    result;
    changeHandler(event) {
        if(event.target.label === 'First Number'){
            this.firstNum=parseInt(event.target.value);
        }
        if(event.target.label === 'Second Number'){
            this.secondNum=parseInt(event.target.value);
        }
    }
    handleClick(event) {
        if(event.target.label === 'ADD'){
            this.result=this.firstNum+this.secondNum;
        }
        if(event.target.label === 'SUBSTRACT'){
            this.result=this.firstNum-this.secondNum;
        }
        if(event.target.label === 'MULTIPLY'){
            this.result=this.firstNum*this.secondNum;
        }
        if(event.target.label === 'DIVIDE'){
            this.result=this.firstNum/this.secondNum;
        }
        
    }
    
}