//
//  ProductRule.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import UIKit

class ProductRule: Rule {
    let first: Polynomial
    let second: Polynomial

    init(first: Polynomial, second: Polynomial) {
      self.first = first
      self.second = second
    }

    func diffString() -> String {
      let udv = "(" + first.toString() + ")(" + second.differentiate().toString() + ")"
      let duv = "(" + first.differentiate().toString() + ")(" + second.toString() + ")"
      return udv + " + " + duv
    }

    func diffLatex() -> String {
      let udv = "(" + first.toLatex() + ")(" + second.differentiate().toLatex() + ")"
      let duv = "(" + first.differentiate().toLatex() + ")(" + second.toLatex() + ")"
      return udv + " + " + duv
    }

    func toString() -> String {
      return ("(" + self.first.toString() + ")(" + self.second.toString() + ")")
    }

    func toLatex() -> String {
        return ("(" + self.first.toLatex() + ")*(" + self.second.toLatex() + ")")
    }
}
