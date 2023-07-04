//
//  Polynomial.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

protocol Rule {
    func toLatex() -> String
    // Add any other common requirements here
}

class Polynomial: Rule {
    //Un polinomio tiene una lista de Términos con sus exponentes
    var terms: [Term]
    
    init(terms: [Term]) {
        self.terms = terms
    }
    
    func generate(minVal: Int, maxVal: Int, degree: Int) {
        self.terms = [Term]()
        
        var negativeProb:Double
        var fractionProb:Double
        var expfracProb:Double
        var expnegfracProb:Double
        switch degree{
        case 3:
            negativeProb = 40.0
            fractionProb = 30.0
            expfracProb = 25.0
            expnegfracProb = 20.0
        case 2:
            negativeProb = 30.0
            fractionProb = 20.0
            expfracProb = 10.0
            expnegfracProb = 5.0
        default:
            negativeProb = 10.0
            fractionProb = 10.0
            expfracProb = 0.0
            expnegfracProb = 0.0
        }
        for _ in 0..<degree {
            var frac1:Fraction
            var numMin = 1
            var denMax = 1

            if Double.random(in: 0.0...100.0) <= negativeProb{
                numMin = minVal
            }
            if Double.random(in: 0.0...100.0) <= fractionProb{
                denMax = maxVal
            }
            repeat {
                frac1 = Fraction(numerator: Int.random(in: numMin...maxVal), denominator: Int.random(in: 1...denMax))
            } while frac1.numerator == 0
            
            var frac2:Fraction
            numMin = 0
            denMax = 1
            if Double.random(in: 0.0...100.0) <= expfracProb{
                denMax = maxVal
            }
            if Double.random(in: 0.0...100.0) <= expnegfracProb{
                numMin = minVal
            }
            repeat {
                frac2 = Fraction(numerator: Int.random(in: numMin...maxVal), denominator: Int.random(in: 1...denMax))
            } while frac2.numerator == 0
            
            self.terms.append(Term(coefficient: frac1.simplify(), exponent: frac2.simplify()))
        }
    }
    
    //Funciones
    func addTerm(_ term: Term) {
        self.terms.append(term)
    }
    
    func orderTerms() {
        //Los Términos se ordenan de mayor exponente a menor
        terms.sort(by: >)
    }
    
    func differentiate() -> Polynomial {
        var terms: [Term] = []
        for i in 0..<self.terms.count {
            if (self.terms[i].exponent.numerator != 0){
                terms.append(Term.differentiate(term: self.terms[i]))
            }
        }
        return Polynomial(terms: terms)
    }
    
    func multiplyby(coef:Fraction) -> Polynomial{
        var terms: [Term] = []
        for i in 0..<self.terms.count {
            terms.append(Term(coefficient: Fraction(numerator:self.terms[i].coefficient.numerator * coef.numerator, denominator: self.terms[i].coefficient.denominator * coef.denominator), exponent: Fraction(numerator: 0, denominator: 1)))
        }
        return Polynomial(terms: terms)
    }
    
    //Funciones de output
    func toString() -> String {
        var str = ""
        for i in 0..<self.terms.count {
            if self.terms[i].coefficient.numerator != 0 {
                if (str != "" && self.terms[i].coefficient.numerator > 0){
                    str += "+"
                }
                str += self.terms[i].toString()
            }
        }
        if str.isEmpty {
            str = "0"
        }
        return str
    }
    
    func toLatex() -> String {
        var str = ""
        for i in 0..<self.terms.count {
            if self.terms[i].coefficient.numerator != 0 {
                if (str != "" && self.terms[i].coefficient.numerator > 0){
                    str += "+"
                }
                str += self.terms[i].toLatex()
            }
        }
        if str.isEmpty {
            str = "0"
        }
        return str
    }
}
