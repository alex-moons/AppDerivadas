//
//  Term.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

class Term: NSObject {
    //Los Términos tienen un coeficiente y un exponente de tipo Fracción
    let coefficient: Fraction
    let exponent: Fraction

    init(coefficient: Fraction, exponent: Fraction) {
      self.coefficient = coefficient
      self.exponent = exponent
    }

    //differentiate() regresa el Término derivado
    static func differentiate(term: Term) -> Term {
      let newCoefficient = term.coefficient * term.exponent
      let newExponent = term.exponent - Fraction(numerator: 1, denominator: 1)
      return Term(coefficient: newCoefficient, exponent: newExponent)
    }

    //Comparadores
    //La comparación de Términos se hace en base al exponente, no al coeficiente
    //Un Término es mayor a otro si su exponente es mayor en valor
    static func <(_ first: Term, _ second: Term) -> Bool {
      return first.exponent < second.exponent
    }

    static func >(_ first: Term, _ second: Term) -> Bool {
      return first.exponent > second.exponent
    }

    static func ==(_ first: Term, _ second: Term) -> Bool {
      return first.exponent == second.exponent
    }

    //Funciones de output
    func toString() -> String {
        var result = ""
        if !(self.coefficient.numerator == self.coefficient.denominator){
            result += self.coefficient.toString()
        }
        if (self.exponent.numerator == self.exponent.denominator){
            result += "x"
        } else if (self.exponent.numerator != 0){
            result += "x^" + self.exponent.toString()
        }
        return result
    }

    func toLatex() -> String {
      var result = ""
        if !(self.coefficient.numerator == self.coefficient.denominator){
            result += self.coefficient.toLatex()
        }
      if (self.exponent.numerator == self.exponent.denominator){
        result += "x"
      } else if (self.exponent.numerator != 0){
        result += "x^{" + self.exponent.toLatex() + "}"
      }
      return result
    }
}
