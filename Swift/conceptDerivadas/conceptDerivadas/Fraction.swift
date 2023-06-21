//
//  Fraction.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

class Fraction: NSObject {
    //Las fracciones solo tienen numerador y denominador. Despues de cada operación
    //se simplifican los números y el signo se deja en el numerador
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        if (denominator == 0){
            self.denominator = 1
        } else {
            self.denominator = denominator
        }
    }
    
    func selfSimplify() {
        var numerator = self.numerator
        var denominator = self.denominator
        var commonDivisor = 1
        let upper = min(abs(numerator), abs(denominator))
        if !(upper < 2){
            for i in 2...upper {
              while numerator % i == 0 && denominator % i == 0 {
                numerator /= i
                denominator /= i
                commonDivisor *= i
              }
            }
            if (self.numerator < 0 && self.denominator < 0) {
              numerator *= -1
              denominator *= -1
            }
            self.numerator = numerator
            self.denominator = denominator
        }
    }

    //Operadores y comparadores
    static func *(_ first: Fraction, _ second: Fraction) -> Fraction {
      let newNumerator = first.numerator * second.numerator
      let newDenominator = first.denominator * second.denominator
      return Fraction(numerator: newNumerator, denominator: newDenominator).simplify()
    }
    
    static func +(_ first: Fraction, _ second: Fraction) -> Fraction {
      let newNumerator = first.numerator * second.denominator + second.numerator * first.denominator
      let newDenominator = first.denominator * second.denominator
      return Fraction(numerator: newNumerator, denominator: newDenominator).simplify()
    }
    
    static func -(_ first: Fraction, _ second: Fraction) -> Fraction {
      let newNumerator = first.numerator * second.denominator - second.numerator * first.denominator
      let newDenominator = first.denominator * second.denominator
      return Fraction(numerator: newNumerator, denominator: newDenominator).simplify()
    }
    
    static func /(_ first: Fraction, _ second: Fraction) -> Fraction {
      let newNumerator = first.numerator * second.denominator
      let newDenominator = first.denominator * second.numerator
      return Fraction(numerator: newNumerator, denominator: newDenominator).simplify()
    }

    static func <(_ first: Fraction, _ second: Fraction) -> Bool {
      let firstDouble = Double(first.numerator) / Double(first.denominator)
      let secondDouble = Double(second.numerator) / Double(second.denominator)
      return firstDouble < secondDouble
    }

    static func >(_ first: Fraction, _ second: Fraction) -> Bool {
      let firstDouble = Double(first.numerator) / Double(first.denominator)
      let secondDouble = Double(second.numerator) / Double(second.denominator)
      return firstDouble > secondDouble
    }

    static func ==(_ first: Fraction, _ second: Fraction) -> Bool {
      let firstDouble = Double(first.numerator) / Double(first.denominator)
      let secondDouble = Double(second.numerator) / Double(second.denominator)
      return firstDouble == secondDouble
    }

    //Funciones
    func isPositive() -> Bool {
      return (self.numerator > 0 || self.denominator > 0)
    }

    func isWhole() -> Bool {
      return self.denominator == 1
    }

    //simplify() convierte la fracción en la forma más simple posible
    func simplify() -> Fraction {
      var numerator = self.numerator
      var denominator = self.denominator
      var commonDivisor = 1
      let upper = min(abs(numerator), abs(denominator))
      if (upper < 2){
        return self
      }
      for i in 2...upper {
        while numerator % i == 0 && denominator % i == 0 {
          numerator /= i
          denominator /= i
          commonDivisor *= i
        }
      }
      if (self.numerator < 0 && self.denominator < 0) {
        numerator *= -1
        denominator *= -1
      }
      return Fraction(numerator: numerator, denominator: denominator)
    }

    //Funciones de output
    func toString() -> String {
        if (denominator == 1){
            return String(self.numerator)
        }
        if denominator == numerator{
            return "1"
        }
        return "\(self.numerator)/\(self.denominator)"
    }
    
    func toLatex() -> String {
      if (denominator == 1){
        return String(self.numerator)
      }
        if denominator == numerator{
            return "1"
        }
      if (numerator < 0){
        return "-\\frac{" + String(numerator * -1) + "}{" + String(denominator) + "}"
      }
      return "\\frac{" + String(numerator) + "}{" + String(denominator) + "}"
    }
}
