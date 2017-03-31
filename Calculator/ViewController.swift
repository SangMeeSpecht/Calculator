//
//  ViewController.swift
//  Calculator
//
//  Created by SangMee Specht on 3/31/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    
    private var userInMiddleOfTyping = false
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
    
        appendDigits(digit)
    }
    
    private var model = CalculatorModel()

    @IBAction private func performOperation(_ sender: UIButton) {
        let mathematicalSymbol = sender.currentTitle

        if userInMiddleOfTyping {
            model.setOperand(operand: displayValue)
            userInMiddleOfTyping = false
        }
        
        model.performOperation(symbol: mathematicalSymbol!)
        displayValue = model.result
    }
    
    private func appendDigits(_ digit: String) {
        if userInMiddleOfTyping {
            display.text! += digit
        } else {
            display.text! = digit
        }
        
        userInMiddleOfTyping = true
    }
}

