//
//  CalculatorModel.swift
//  Calculator
//
//  Created by SangMee Specht on 3/31/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import Foundation

private func factorial(number: Double) -> Double {
    var currentProduct = number
    var intNumber = Int(number)
    var factor: Int {
        get {
            return Int(currentProduct)
        }
        set(newProduct) {
            currentProduct = Double(newProduct)
        }
    }
    
    for num in (2...intNumber - 1).reversed() {
        factor *= num
    }
    
    return currentProduct
}

class CalculatorModel {
    
    private var accumulator = 0.0
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations = [
        "π" : Operation.Constant(Double.pi),
        "√" : Operation.UnaryOperation(sqrt),
        "x!": Operation.UnaryOperation(factorial),
        "x²": Operation.UnaryOperation({ $0 * $0 }),
        "x³": Operation.UnaryOperation({ $0 * $0 * $0 }),
        "xª": Operation.BinaryOperation({ pow($0, $1) }),
        "1/x": Operation.UnaryOperation({ 1 / $0 }),
        "±" : Operation.UnaryOperation({ -$0 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
}
