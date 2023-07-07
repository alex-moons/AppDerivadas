//
//  Resultados.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Resultados: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var results: [Any]
    @Binding var time:Int
    @Binding var alumno:Alumno
    
    //FormatHelper para el timer
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
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("ID:\(alumno.id)")
                Text("Nombre: \(alumno.nombre)")
                HStack{
                    Text("Tiempo:")
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
                }
                Text("Fecha: \(formattedDate())")
                Text("Hora: \(formattedTime())")
                Text("\(getGrade(results:results))/\(results.count)")
            }
            .font(.system(size: 18))
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10))
            
            List{
                //Muestra cada problema y si fue resuelto
                ForEach(results.indices, id: \.self) { index in
                    HStack{
                        VStack(alignment: .leading){
                            Text("Problema \(index+1):")
                            
                            if let problem = results[index] as? PolyProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            } else if let problem = results[index] as? ChainProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            } else if let problem = results[index] as? ProdProb {
                                VStack(){
                                    let components = problem.problem.toLatex().components(separatedBy: "*")
                                    LaTeX(components[0])
                                        .parsingMode(.all)
                                        .blockMode(.alwaysInline)
                                    LaTeX("*" + components[1])
                                        .parsingMode(.all)
                                        .blockMode(.alwaysInline)
                                }
                            } else if let problem = results[index] as? QuoProb {
                                LaTeX(problem.problem.toLatex())
                                    .parsingMode(.all)
                            }
                        }
                        
                        Spacer()

                        if let problem = results[index] as? PolyProb {
                            (problem.correct ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "multiply.circle.fill"))
                                .foregroundColor(problem.correct ? .green : .red)
                        } else if let problem = results[index] as? ChainProb {
                            (problem.correct ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "multiply.circle.fill"))
                                .foregroundColor(problem.correct ? .green : .red)
                        } else if let problem = results[index] as? ProdProb {
                            (problem.correct ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "multiply.circle.fill"))
                                .foregroundColor(problem.correct ? .green : .red)
                        } else if let problem = results[index] as? QuoProb {
                            (problem.correct ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "multiply.circle.fill"))
                                .foregroundColor(problem.correct ? .green : .red)
                        }
                    }
                }
            }
        }
        .navigationTitle("Resultados")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton: some View {
        Button(
            "Terminar",
            action: { self.presentationMode.wrappedValue.dismiss() }
        )
    }
}

//FormatHelper para fecha y hora
func formattedDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d/MMMM/yyyy"
    dateFormatter.locale = Locale(identifier: "es")
    return dateFormatter.string(from: Date())
}
func formattedTime() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.locale = Locale(identifier: "es")
    return dateFormatter.string(from: Date())
}

//Calcula la cantidad de aciertos
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
    return correctAnsw
}

struct Resultados_Previews: PreviewProvider {
    static var previews: some View {
        Resultados(results: .constant([PolyProb(problem: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1))]), usrAnsw: "")]), time: .constant(0), alumno: .constant(Alumno(nombre: "", id: "")))
    }
}
