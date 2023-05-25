import SwiftUI
import Polynomial
import Term

/*
EJEMPLO DE USO

var polinomio2 = generatePolynomial(noTerms: 4, derivativeType: "")
print(polinomio2.toString())

*/

// Preguntas:
//     En qué rango generar los numeros aleatorios (considerando numeros negativos)
//     Cómo se recibe el tipo de derivada
//     La clase Polinomio no considera números que no tienen variable (5, la cual su derivada es 0)

func generateRandomTerm() -> Term {
    var randomNumerator = Int.random(in: 1..<100)
    var randomDenominator = 1
    var randomCoefficient = Fraction(numerator: randomNumerator, denominator: randomDenominator)

    randomNumerator = Int.random(in: 1..<100)
    randomDenominator = 1
    var randomExponent = Fraction(numerator: randomNumerator, denominator: randomDenominator)

    return Term(coefficient: randomCoefficient, exponent: randomExponent)
}


func generatePolynomial(noTerms: Int, derivativeType: String) -> Polynomial {
    var terms = [Term]()
    let polynomial = Polynomial(terms: terms)
    
    for _ in 1...noTerms {
        let term = generateRandomTerm()
        print(term.toString())
        polynomial.addTerm(term)
    }
  
    return polynomial
}