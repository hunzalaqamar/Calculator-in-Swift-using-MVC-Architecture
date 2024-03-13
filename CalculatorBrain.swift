//
//  CalculatorBrain.swift
//  Calculator
//
//

import Foundation

func changeSign(operand:Double) -> Double
{
    return -operand
}

struct  CalculatorBrain
{
    private var accumulator: Double?
    
    private enum operation{
        case constant (Double)
        case unaryOperation ((Double) -> Double)
        case binaryOperation ((Double, Double) -> Double)
        case equals
        case reset
        case randomb
        case factorialclass ((Double) -> Double)
    }
    
    func factorial(factorialNumber: Double) -> Double {
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber: factorialNumber - 1)
        }
    }
    
    
    private lazy var operations: Dictionary <String,operation> = [
        "π" : .constant(Double.pi),
        "e" : .constant(M_E),
        "√" : .unaryOperation(sqrt),
        "sin" : .unaryOperation { sin( $0 * Double.pi / 180) },
        "cos" : .unaryOperation{ cos( $0 * Double.pi / 180) },
        "tan" : .unaryOperation{ tan( $0 * Double.pi / 180) },
        "sinh" : .unaryOperation(sinh),
        "cosh" : .unaryOperation(cosh),
        "tanh" : .unaryOperation(tanh),
        "±" : .unaryOperation { -$0 },
        "+" : .binaryOperation { $0 + $1 },
        "-" : .binaryOperation { $0 - $1 },
        "×" : .binaryOperation { $0 * $1 },
        "÷" : .binaryOperation { $0 / $1 },
        "=" : .equals,
        "%" : .unaryOperation { $0 / 100 },
        "x²" : .unaryOperation { pow($0, 2) },
        "x³" : .unaryOperation { pow($0, 3) },
        "xʸ" : .binaryOperation { pow($0, $1) },
        "10ˣ" : .unaryOperation { pow(10, $0) },
        "eˣ" : .unaryOperation { pow(M_E, $0) },
        "1/x" : .unaryOperation { 1 / $0 },
        "∛" : .unaryOperation { pow($0, 1/3) },
        "ʸ√x" : .binaryOperation { pow($0, 1/$1) },
        "ln" : .unaryOperation { log($0) },
        "log₁₀" : .unaryOperation { log10($0) },
        "x!" : .factorialclass { $0 },
        "Rand" : .randomb,
        
        
        "AC" : .reset
    ]
    
    
    mutating func performOperation(_ symbol: String)
    {
        if let constant = operations[symbol]{
            switch constant
            {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil
                {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil
                {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            case .reset:
                pbo = nil
                accumulator = nil
                
            case .randomb:
                var randomboy = Double.random(in: 0...1)
                accumulator = randomboy
                randomboy = 0
                
            case .factorialclass(let function):
                if accumulator != nil
                {
                    accumulator = function(accumulator!)
                    accumulator = factorial(factorialNumber: accumulator!)
                }
            }
        }
    }
    
    private mutating func performPendingBinaryOperation()
    {
        if pbo != nil && accumulator != nil
        {
            accumulator = pbo!.perform(with: accumulator!)
        }
    }
    
    private var pbo : PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        var function: (Double, Double) -> Double
        var firstOperand: Double
        
        func perform (with secondOperand: Double) -> Double
        {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand:Double){
        
        accumulator = operand
        
    }
    var result: Double? {
        get{
            return accumulator
        }
        
    }
    
}
