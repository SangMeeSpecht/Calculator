//
//  CalculatorViewControllerSpec.swift
//  Calculator
//
//  Created by SangMee Specht on 4/26/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import Quick
import Nimble
@testable import Calculator

class CalculatorViewControllerSpec: QuickSpec {
    override func spec() {
        var calculatorViewController: CalculatorViewController!
        
        beforeEach {
            let storyboard = UIStoryboard(name:"Main", bundle:nil)
            calculatorViewController = storyboard.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
            
            expect(calculatorViewController.view).notTo(beNil())
            expect(calculatorViewController.display).notTo(beNil())
        }
        
        describe("display label") {
            context("when the calculator first loads") {
                it("displays 0") {
                    expect(calculatorViewController.display.text!).to(equal("0"))
                }
            }
        }
        
        describe(".clearDisplay") {
            it("clears the display by setting it back to 0") {
                calculatorViewController.display.text = "123"
                calculatorViewController.clearDisplay(UIButton())
                expect(calculatorViewController.display.text!).to(equal("0"))
            }
        }
        
        describe(".touchDigit") {
            context("when one digit is pressed") {
                it("displays that digit in the display label") {
                    let button = UIButton()
                    button.setTitle("1", for: .normal)
                    calculatorViewController.touchDigit(button)
                    expect(calculatorViewController.display.text!).to(equal("1"))
                }
            }
        }
    }
}
