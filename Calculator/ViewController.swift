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
    private var decimalUsed = false
    private var model = CalculatorModel()
    
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
        
        userInMiddleOfTyping = true
    }

    @IBAction private func performOperation(_ sender: UIButton) {
        let mathematicalSymbol = sender.currentTitle!

        if userInMiddleOfTyping {
            model.setOperand(operand: displayValue)
            userInMiddleOfTyping = false
            decimalUsed = false
        }
        
        model.performOperation(symbol: mathematicalSymbol)
        displayValue = model.result
    }
    
    @IBAction func clearDisplay(_ sender: UIButton) {
        displayValue = 0
        model.setOperand(operand: displayValue)
    }
    
    private func appendDigits(_ digit: String) {
        if userInMiddleOfTyping {
            if digit == "." && decimalUsed == false {
                display.text! += digit
                decimalUsed = true
            } else if digit != "." {
                display.text! += digit
            }
        } else {
            display.text! = digit
        }
    }
    
    
}

