class ProductRule {
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
    return ""
  }

  func toString() -> String {
    return ("(" + self.first.toString() + ")(" + self.second.toString() + ")")
  }

  func toLatex() -> String {
    return ""
  }
}