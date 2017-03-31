//
//  CalculatorModel.swift
//  Calculator
//
//  Created by SangMee Specht on 3/31/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    private var accumulator = 0.0
    
    private var operations = [
        "π" : Operation.Constant(Double.pi),
        "√" : Operation.UnaryOperation(sqrt)
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            }
        }
        
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}   
