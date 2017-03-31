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
    
    private var noDigitsSelected = true
    
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
        noDigitsSelected = true
        
        let mathematicalSymbol = sender.currentTitle
        
        if mathematicalSymbol == "π" {
            displayValue = Double.pi
        } else if mathematicalSymbol == "√" {
            displayValue = sqrt(displayValue)
        }
    }
    
    private func appendDigits(_ digit: String) {
        if noDigitsSelected {
            display.text! = digit
        } else {
            display.text! += digit
        }
        
        noDigitsSelected = false
    }
}

