//
//  ViewController.swift
//  Calculator
//
//  Created by app on 11.04.17.
//  Copyright © 2017 h_da. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var sequence: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    

    @IBAction func numberBtnPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if(digit == "." && (!userIsInTheMiddleOfTyping || display!.text!.contains("."))) {
            return;
        }
        
        if(userIsInTheMiddleOfTyping) {
            let textCurrentlyInDisplay = display!.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        if let description = brain.description {
            sequence.text = description
        }
    }
}

