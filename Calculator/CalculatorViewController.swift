//
//  ViewController.swift
//  Calculator
//
//  Created by SangMee Specht on 3/31/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var renderExpression: UILabel!
    
    private var model = CalculatorModel()
    
    private var userInMiddleOfTyping = false
    private var decimal = "."
    
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
            renderExpression.text = model.renderDescription
        }
        
        if invalidFactorialNumber(mathematicalSymbol: mathematicalSymbol) {
            display.text = "Not a number"
        } else {
            model.performOperation(symbol: mathematicalSymbol)
            displayValue = model.result!
            renderExpression.text = model.renderDescription
        }
    }
    
    @IBAction private func clearDisplay(_ sender: UIButton) {
        display.text = "0"
        renderExpression.text = " "
        model.resetCalculator()
        userInMiddleOfTyping = false
    }
    
//    ->M
    @IBAction func saveValue() {
        model.variableValues["M"] = displayValue
        userInMiddleOfTyping = false
        uploadSavedProgram()
    }
    
//    M
    @IBAction func getSavedValue() {
        model.setOperand(variableName: "M")
        userInMiddleOfTyping = false
        displayValue = model.result!
    }
    
    @IBAction func undo() {
        if userInMiddleOfTyping && !display.text!.isEmpty {
            display.text! = display.text!.substring(to: display.text!.index(before: display.text!.endIndex))
        } else if !display.text!.isEmpty {
            model.undoLastOperation()
            model.program = model.program
            renderExpression.text = model.renderDescription
        }
    }
    
    private func uploadSavedProgram() {
        model.program = model.program
        displayValue = model.result!
    }
    
    private func appendDigits(_ digit: String) {
        if userInMiddleOfTyping {
            if !numberContainsDecimal(digit: digit) {
                display.text! += digit
            }
        } else {
            display.text! = digit
        }
    }
    
    private func numberContainsDecimal(digit: String) -> Bool {
        return digit == decimal && display.text!.characters.contains(Character(decimal))
    }
    
    private func isDoubleAnInteger(num: Double) -> Bool {
        return num.truncatingRemainder(dividingBy: 1.0) == 0.0
    }
    
    private func invalidFactorialNumber(mathematicalSymbol: String) -> Bool {
        return mathematicalSymbol == "x!" && !isDoubleAnInteger(num: displayValue)
    }
    
}

