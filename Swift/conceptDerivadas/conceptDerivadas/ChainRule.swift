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
      var result = self.exponent.toString() + "(" + self.polynomial.toString() + ")^"
      let newExponent = self.exponent - Fraction(numerator: 1, denominator: 1)
      result += newExponent.toString() + "(" + self.polynomial.differentiate().toString() + ")"
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
