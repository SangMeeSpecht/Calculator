//
//  CalculatorModelSpec.swift
//  Calculator
//
//  Created by SangMee Specht on 4/26/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import Quick
import Nimble
@testable import Calculator

class CalculatorModelSpec: QuickSpec {
    override func spec() {
        var calculatorModel: CalculatorModel!
        
        beforeEach {
            calculatorModel = Calculator.CalculatorModel()
        }
        
        describe(".result") {
            context("when no numbers have been entered") {
                it("returns 0") {
                    expect(calculatorModel.result).to(equal(0))
                }
            }
            
            context("when a number has been entered") {
                it("returns the current accumulator") {
                    calculatorModel.result = 2
                    expect(calculatorModel.result).to(equal(2))
                }
            }
        }
        
        describe(".isPartialResult") {
            context("when a user is in the middle of writing an expression") {
                it("verifies that this is true") {
                    calculatorModel.setOperand(operand: 2)
                    expect(calculatorModel.isPartialResult).to(beTrue())
                }
            }
            
            context("when a user has written a complete expression") {
                it("verifies that this is false") {
                    calculatorModel.performOperation(symbol: "=")
                    expect(calculatorModel.isPartialResult).to(beFalse())
                }
            }
        }
        
        describe(".renderDescription") {
            beforeEach {
                calculatorModel.setOperand(operand: 32.0)
                calculatorModel.performOperation(symbol: "+")
            }
            
            context("when an incomplete expression is entered") {
                it("appends '...' to the end of the expression") {
                    expect(calculatorModel.renderDescription).to(equal("32.0+..."))
                }
            }
            
            context("when a complete expression is entered") {
                it("appends '=' to the end of the expression") {
                    calculatorModel.setOperand(operand: 2.0)
                    calculatorModel.performOperation(symbol: "=")
                    expect(calculatorModel.renderDescription).to(equal("32.0+2.0="))
                }
            }
        }
        
        describe(".performOperation") {
            context("when a constant is selected") {
                it("returns value of the constant") {
                    calculatorModel.performOperation(symbol: "π")
                    expect(calculatorModel.result).to(equal(Double.pi))
                }
            }
            
            context("when a unary operation is being performed") {
                it("calculates the answer to the expression") {
                    calculatorModel.setOperand(operand: 25)
                    calculatorModel.performOperation(symbol: "√")
                    expect(calculatorModel.result).to(equal(5))
                }
            }
            
            context("when a binary operation is being performed") {
                it("calculates the answer to the expression") {
                    calculatorModel.setOperand(operand: 1)
                    calculatorModel.performOperation(symbol: "+")
                    calculatorModel.setOperand(operand: 2)
                    calculatorModel.performOperation(symbol: "=")
                    expect(calculatorModel.result).to(equal(3))
                }
            }
        }
    }
}
