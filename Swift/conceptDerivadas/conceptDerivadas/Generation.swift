//
//  Generation.swift
//  conceptDerivadas
//
//  Created by Alumno on 29/06/23.
//

import Foundation

func genPoly(grado:Int)->Polynomial{
    let problem = Polynomial(terms: [Term]())
    let _: () = problem.generate(minVal: -9, maxVal: 9, degree: grado)
    let _: () = problem.orderTerms()
    print("Generado: \(problem.toString())")
    return problem
}

func genChain(grado:Int)->ChainRule{
    var num:Int
    var den = 1
    
    switch grado{
    case 2:
        repeat{
            num = Int.random(in: -9...9)
        }while num != 0
        den = Int.random(in: 1...9)
    case 1:
        num = Int.random(in: 1...9)
        den = Int.random(in: 1...9)
    default:
        num = Int.random(in: 1...9)
    }
    let problem = ChainRule(polynomial: genPoly(grado: grado), exponent: Fraction(numerator: num, denominator: den))
    return problem
}

func genProd(grado:Int)->ProductRule{
    let problem = ProductRule(first: genPoly(grado: grado), second: genPoly(grado: grado))
    return problem
}

func genQuo(grado:Int)->QuotientRule{
    let problem = QuotientRule(numerator: genPoly(grado: grado), denominator: genPoly(grado: grado))
    return problem
}
