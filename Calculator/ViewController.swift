//
//  ViewController.swift
//  Calculator
//
//  Created by SangMee Specht on 3/31/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var noDigitsSelected = true

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
    
        appendDigits(digit)
    }

    @IBAction func performOperation(_ sender: UIButton) {
        noDigitsSelected = true
        
        let mathematicalSymbol = sender.currentTitle
        
        if mathematicalSymbol == "π" {
            display.text = String(Double.pi)
        }
    }
    
    func appendDigits(_ digit: String) {
        if noDigitsSelected {
            display.text! = digit
        } else {
            display.text! += digit
        }
        
        noDigitsSelected = false
    }
}

