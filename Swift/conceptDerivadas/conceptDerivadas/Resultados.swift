//
//  Resultados.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Resultados: View {
    @Binding var results: [PolyProb]
    @Binding var time:Int
    
    var hours: Int {
        time / 3600
    }

    var minutes: Int {
        (time % 3600) / 60
    }

    var seconds: Int {
        time % 60
    }

    
    var body: some View {
        VStack(alignment: .center) {
            Text("Tiempo:")
            
            VStack {
                HStack(spacing: 0) {
                    StopwatchUnit(timeUnit: hours)
                    Text(":")
                        .font(.system(size: 20))
                        .offset(y: -1)
                    StopwatchUnit(timeUnit: minutes)
                    Text(":")
                        .font(.system(size: 20))
                        .offset(y: -1)
                    StopwatchUnit(timeUnit: seconds)
                }
                
                Text("Calificación: \(getGrade(results:results))")
                
                List{
//                    ForEach(Array(results.enumerated()), id: \.1) { index, result in
//                        VStack(alignment: .leading){
//                            HStack{
//                                Text("Problema \(index+1):")
//                                LaTeX(results[index].problem.toLatex())
//                                    .parsingMode(.all)
//                            }
//                            HStack{
//                                Text("Respuesta:")
//                                Text(results[index].answ)
//                            }
//                            HStack{
//                                Text("Se contestó:")
//                                Text(results[index].usrAnsw)
//                            }
//                        }
//                    }
                }
            }
        }
    }
}

func getGrade(results:[PolyProb]) -> Int {
    var correctAnsw = 0
    for result in results {
        if result.correct{
            correctAnsw += 1
        }
    }
    return Int(Double(correctAnsw) / Double(results.count) * 100)
}

struct Resultados_Previews: PreviewProvider {
    static var previews: some View {
        Resultados(results: .constant([PolyProb(problem: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1))]), usrAnsw: "")]), time: .constant(0))
    }
}
