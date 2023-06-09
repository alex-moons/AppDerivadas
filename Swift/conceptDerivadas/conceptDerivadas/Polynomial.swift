//
//  Polynomial.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

class Polynomial: NSObject {
    //Un polinomio tiene una lista de Términos con sus exponentes
    var terms: [Term]
    
    init(terms: [Term]) {
        self.terms = terms
    }
    
    func generate(minVal: Int, maxVal: Int, degree: Int) {
        self.terms = [Term]()
        for _ in 0..<degree {
            let frac1 = Fraction(numerator: Int.random(in: minVal...maxVal), denominator: Int.random(in: minVal...maxVal))
            let frac2 = Fraction(numerator: Int.random(in: minVal...maxVal), denominator: Int.random(in: minVal...maxVal))
            self.terms.append(Term(coefficient: frac1, exponent: frac2))
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
        if self.terms[i].coefficient.numerator == 0 {
              continue
          }
        if (i != 0 && self.terms[i].coefficient.isPositive()){
          str += "+"
        }

        str += self.terms[i].toString()
      }
      if str.isEmpty {
          str = "0"
      }
      return str
    }

    func toLatex() -> String {
      var str = ""
      for i in 0..<self.terms.count {
        if self.terms[i].coefficient.numerator == 0 {
              continue
          }
        if (i != 0 && self.terms[i].coefficient.isPositive()){
          str += "+"
        }

        str += self.terms[i].toLatex()
      }
      if str.isEmpty {
          str = "0"
      }
      return str
    }
}
