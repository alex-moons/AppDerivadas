//
//  Resultados.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Resultados: View {
    @Binding var results: [Any]
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
                
                VStack{
                    Text("Nombre:")
                    Text("ID:")
                    Text("Tiempo:")
                    Text("Fecha:")
                    Text("Hora:")
                    Text("Nombre:")
                }
                
                List{
                    ForEach(results.indices, id: \.self) { index in
                        VStack{
                            Text("Problema \(index+1):")
                            
                            if let problem = results[index] as? PolyProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            } else if let problem = results[index] as? ChainProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            } else if let problem = results[index] as? ProdProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            } else if let problem = results[index] as? QuoProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            }
                        }
                    }
                }
            }
        }
    }
}

func getGrade(results:[Any]) -> Int {
    var correctAnsw = 0
    for result in results {
        if let problem = result as? PolyProb {
            if problem.correct{
                correctAnsw += 1
            }
        } else if let problem = result as? ChainProb {
            if problem.correct{
                correctAnsw += 1
            }
        } else if let problem = result as? ProdProb {
            if problem.correct{
                correctAnsw += 1
            }
        } else if let problem = result as? QuoProb {
            if problem.correct{
                correctAnsw += 1
            }
        }
    }
    return Int(Double(correctAnsw) / Double(results.count) * 100)
}

struct Resultados_Previews: PreviewProvider {
    static var previews: some View {
        Resultados(results: .constant([PolyProb(problem: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1))]), usrAnsw: "")]), time: .constant(0))
    }
}
