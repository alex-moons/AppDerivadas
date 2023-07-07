//
//  Generation.swift
//  conceptDerivadas
//
//  Created by Alumno on 29/06/23.
//

import Foundation

//Generación de cada problema
func genPoly(grado:Int, poly:Bool)->Polynomial{
    //Si es regla general (poly), el grado afecta la cantidad de términos en el polinomio. Si no, el default es 3
    let problem = Polynomial(terms: [Term]())
    let _: () = problem.generate(minVal: -9, maxVal: 9, degree: grado, poly: poly)
    let _: () = problem.orderTerms()
    print("Generado: \(problem.toString())")
    return problem
}

func genChain(grado:Int)->ChainRule{
    var num = 1
    var den = 1
    
    switch grado{
    case 3:
        repeat{
            num = Int.random(in: -9...9)
            den = Int.random(in: 1...9)
        }while num == 0 || abs(num) == abs(den)
    case 2:
        repeat{
            num = Int.random(in: 2...9)
            den = Int.random(in: 1...9)
        }while num == den
    default:
        num = Int.random(in: 2...9)
    }
    let problem = ChainRule(polynomial: genPoly(grado: grado, poly: false), exponent: Fraction(numerator: num, denominator: den).simplify())
    return problem
}

func genProd(grado:Int)->ProductRule{
    let problem = ProductRule(first: genPoly(grado: grado, poly: false), second: genPoly(grado: grado, poly: false))
    return problem
}

func genQuo(grado:Int)->QuotientRule{
    let problem = QuotientRule(numerator: genPoly(grado: grado, poly: false), denominator: genPoly(grado: grado, poly: false))
    return problem
}
