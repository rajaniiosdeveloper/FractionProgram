//
//  IOFraction.swift
//  OneIdentityProject

//  Created by Rajani on 04/09/23.
//

import Foundation

enum IOFractionError: Error {
    case undefinedError
    case invalidOperator
    case invalidInput
    
    var errorMessage: String {
        switch self {
        case .undefinedError:
            return "undefinedError"
        case .invalidOperator:
            return "invalidOperator"
        case .invalidInput:
            return "invalidInput"
        }
   }
}

struct IOFraction {
    
    func processFraction(input: String) throws -> String {
        
        guard !input.isEmpty else {
            throw IOFractionError.invalidInput
        }
        let inputExpression = input
        
        var output = ""
        
        // Calculate the result
        let result = try calculateExpression(inputExpression)

        // Simplify and output the result as a mixed number
        let simplifiedResult = simplifyFraction(numerator: result.numerator, denominator: result.denominator)
        let wholePart = simplifiedResult.numerator / simplifiedResult.denominator
        let remainder = simplifiedResult.numerator % simplifiedResult.denominator

        if remainder == 0 {
            output = "\(wholePart)"
        } else {
            if wholePart != 0 {
                output = "\(wholePart)&\(remainder)/\(simplifiedResult.denominator)"
            } else {
                output = "\(remainder)/\(simplifiedResult.denominator)"
            }
            
        }
        return output
    }
    
    
    // Function to convert a mixed number string to a fraction
    private func mixedNumberToFraction(_ mixedNumber: String) -> (numerator: Int, denominator: Int)? {
        
        guard !mixedNumber.isEmpty else {return nil}
        
        let components = mixedNumber.components(separatedBy: "&")
        if components.count == 2 {
            let wholePart = Int(components[0]) ?? 0
            let fractionPart = components[1]
            let fractionComponents = fractionPart.components(separatedBy: "/")
            if fractionComponents.count == 2 {
                let numerator = Int(fractionComponents[0]) ?? 0
                let denominator = Int(fractionComponents[1]) ?? 1
                let totalNumerator = wholePart * denominator + numerator
                return (totalNumerator, denominator)
            }
        } else if components.count == 1 {
            let simpleBreakup = components[0].components(separatedBy: "/")
            if simpleBreakup.count == 2 {
                return (Int(simpleBreakup[0]) ?? 0, Int(simpleBreakup[1]) ?? 0)
            } else if simpleBreakup.count == 1, let value = Int(simpleBreakup[0]) {
                return (value, 1)
            }
        }
        return nil
    }
    
    // Function to simplify a fraction
    private func simplifyFraction(numerator: Int, denominator: Int) -> (numerator: Int, denominator: Int) {
        let gcd = greatestCommonDivisor(a: abs(numerator), b: denominator)
        let sign = numerator < 0 ? -1 : 1
        return (sign * abs(numerator) / gcd, denominator / gcd)
    }
    
    // Function to calculate the greatest common divisor
    private func greatestCommonDivisor(a: Int, b: Int) -> Int {
        if b == 0 {
            return a
        }
        return greatestCommonDivisor(a: b, b: a % b)
    }
    
    // Function to calculate the result of an expression
    private func calculateExpression(_ expression: String) throws -> (numerator: Int, denominator: Int) {
        let components = expression.components(separatedBy: " ")
        if components.count == 3 {
            guard let operand1 = mixedNumberToFraction(components[0]),
                  let operand2 = mixedNumberToFraction(components[2]) else {
                throw IOFractionError.undefinedError
            }
            let operatorSymbol = components[1]
            
            switch operatorSymbol {
            case "+":
                return (operand1.numerator * operand2.denominator + operand2.numerator * operand1.denominator, operand1.denominator * operand2.denominator)
            case "-":
                return (operand1.numerator * operand2.denominator - operand2.numerator * operand1.denominator, operand1.denominator * operand2.denominator)
            case "*":
                return (operand1.numerator * operand2.numerator, operand1.denominator * operand2.denominator)
            case "/":
                return (operand1.numerator * operand2.denominator, operand1.denominator * operand2.numerator)
            default:
                throw IOFractionError.invalidOperator
            }
        } else {
            throw IOFractionError.invalidInput
        }
    }
}
