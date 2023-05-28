class QuotientRule {
  let numerator: Polynomial
  let denominator: Polynomial

  init(numerator: Polynomial, denominator: Polynomial) {
    self.numerator = numerator
    self.denominator = denominator
  }

  func diffString() -> String {
    let udv = "(" + numerator.toString() + ")(" + denominator.differentiate().toString() + ")"
    let duv = "(" + numerator.differentiate().toString() + ")(" + denominator.toString() + ")"
    let v2 = "(" + denominator.toString() + ")^2"
    return "(" + udv + " - " + duv + ")/" + v2
  }

  func diffLatex() -> String {
    let udv = "(" + numerator.toLatex() + ")(" + denominator.differentiate().toLatex() + ")"
    let duv = "(" + numerator.differentiate().toLatex() + ")(" + denominator.toLatex() + ")"
    let v2 = "(" + denominator.toLatex() + ")^2"
    return "\\frac{" + udv + " - " + duv + "}{" + v2 + "}"
  }

  func toString() -> String {
    return ("(" + self.numerator.toLatex() + ")/(" + self.denominator.toLatex() + ")")
  }

  func toLatex() -> String {
    return ("\\frac{(" + self.numerator.toLatex() + ")}{(" + self.denominator.toLatex() + ")}")
  }
}