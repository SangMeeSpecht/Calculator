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
    private var description = ""
    private var isPartialResult = true
    private var internalProgram = [AnyObject]()
    var variableValues = [String: Double]()
    
    var result: Double? {
        get {
            return accumulator
        }
        set {
            if newValue != nil {
                accumulator = newValue!
            } else {
                accumulator = 0.0
            }
        }
    }
    
    var renderDescription: String {
        get {
            if isPartialResult {
                return description + "..."
            }
            else {
                return description
            }
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
        description += String(operand)
        internalProgram.append(operand as AnyObject)
    }
    
    func setOperand(variableName: String) {
        result = variableValues[variableName]
        description += String(variableName)
        internalProgram.append(variableName as AnyObject)
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
        internalProgram.append(symbol as AnyObject)
        
        description += symbol
        
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
                isPartialResult = false
            }
        }
    }
    
    func resetCalculator() {
        resetPending()
        resetAccumulator()
        resetDescription()
        internalProgram.removeAll()
        variableValues.removeAll()
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return internalProgram as CalculatorModel.PropertyList
        }
        set {
            resetPending()
            resetAccumulator()
            resetDescription()
            internalProgram.removeAll()
            
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if variableValues[String(describing: op)] != nil {
                        setOperand(variableName: op as! String)
                    } else if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    private func resetPending() {
        pending = nil
    }
    
    private func resetAccumulator() {
        accumulator = 0.0
    }
    
    private func resetDescription() {
        description = ""
    }
    
    private func resetIsPartialResult() {
        isPartialResult = true
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            resetIsPartialResult()
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
}
