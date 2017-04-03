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
    @IBOutlet private weak var renderEquation: UILabel!
    private var userInMiddleOfTyping = false
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
        }
        
        if mathematicalSymbol == "x!" && !isDoubleAnInteger(num: displayValue) {
            display.text = "Not a number"
        } else {
            model.performOperation(symbol: mathematicalSymbol)
            displayValue = model.result
            renderEquation.text = model.renderDescription()
        }
    }
    
    @IBAction func clearDisplay(_ sender: UIButton) {
        userInMiddleOfTyping = false
        display.text = "0"
        model.setOperand(operand: displayValue)
        model.resetDescription()
        renderEquation.text = ""
    }
    
    private func appendDigits(_ digit: String) {
        if userInMiddleOfTyping {
            if digit == "." && display.text!.characters.contains(".") {
//                don't do anything
            } else {
                display.text! += digit
            }
        } else {
            display.text! = digit
        }
    }
    
    private func isDoubleAnInteger(num: Double) -> Bool {
        return num.truncatingRemainder(dividingBy: 1.0) == 0.0
    }
    
}

