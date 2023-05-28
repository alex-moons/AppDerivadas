class Polynomial {
  //Un polinomio tiene una lista de Términos con sus exponentes
  var terms: [Term]
  
  init(terms: [Term]) {
    self.terms = terms
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