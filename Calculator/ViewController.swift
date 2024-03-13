//
//  ViewController.swift
//  Calculator
//
//  Created by intozoom on 1/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping : Bool = false
    
    var displayValue:Double{
        get{
            return Double(display!.text!)!
        }set(myNewValue){
            display!.text = String(myNewValue)
        }
    }
    

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(String(describing: digit)) function was called")
        
        if digit == "CLEAR"
        {
            display!.text = ""
            
        }
        else if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            display!.text = textCurrentlyInDisplay + digit
          
        } else {
            display!.text = ""
            display!.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    private var brain = CalculatorBrain()

    
    @IBAction func performOperation(_ sender: UIButton) {
        if sender.currentTitle! == "CLEAR"
        {
            displayValue = 0
        }
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result{
            displayValue = result
        }
    }
}

