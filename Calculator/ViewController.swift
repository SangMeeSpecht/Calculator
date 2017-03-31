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
        
        if noDigitsSelected {
            display.text! = digit
        } else {
            let currentDisplayText = display.text!
            display.text! = currentDisplayText + digit
        }
        
        noDigitsSelected = false
        
    }

 
    

}

