//
//  ChainRule.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

class ChainRule: NSObject {
    let polynomial: Polynomial
    let exponent: Fraction

    init(polynomial: Polynomial, exponent: Fraction) {
      self.polynomial = polynomial
      self.exponent = exponent
    }

    func diffString() -> String {
        
      var result = "(" + self.polynomial.toString()+")"
        var newExponent: Fraction = Fraction(numerator: 0, denominator: 1)

        if self.exponent.numerator == 2 && self.exponent.denominator == 1{
            
        }else if self.exponent.denominator == 1{
            newExponent = self.exponent - Fraction(numerator: 1, denominator: 1)
            result+="^" + newExponent.toString()
        }else{
            newExponent = self.exponent - Fraction(numerator: self.exponent.denominator, denominator: self.exponent.denominator)
            result+="^" + newExponent.toString()
        }
        
      let polydiff = self.polynomial.differentiate()
        if polydiff.terms.count == 1 {
            result = polydiff.multiplyby(coef: self.exponent).toString() + result
        }else{
            result = "(" + polydiff.multiplyby(coef: self.exponent).toString() + ")" + result
        }
      return result
    }

    func diffLatex() -> String {
      var result = self.exponent.toLatex() + "(" + self.polynomial.toLatex() + ")^{"
      let newExponent = self.exponent - Fraction(numerator: 1, denominator: 1)
      result += newExponent.toLatex() + "}(" + self.polynomial.differentiate().toLatex() + ")"
      return result
    }

    func toString() -> String {
      if (self.exponent.isWhole() && self.exponent.numerator == 1){
        return self.polynomial.toString()
      }
      return ("(" + self.polynomial.toString() + ")^" + self.exponent.toString())
    }

    func toLatex() -> String {
      if (self.exponent.isWhole() && self.exponent.numerator == 1){
        return self.polynomial.toLatex()
      }
      return ("(" + self.polynomial.toLatex() + ")^{" + self.exponent.toLatex()) + "}"
    }
}
