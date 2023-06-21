//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct NumberPadView: View {
    @State private var usrInput: String = ""
    @State private var insertIndex: Int = 0

    let rows = [
        ["1", "2", "3", "^", "⌫"],
        ["4", "5", "6", "(", ")"],
        ["7", "8", "9", "﹡", "÷"],
        ["𝑥", "0", ".", "+", "-"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                LaTeX("f'(x) =")
                    .parsingMode(.all)
                
                TextField("Respuesta", text: $usrInput)
            }
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { number in
                        Button(action: {
                            switch number{
                            case "⌫":
                                if usrInput.count > 0{
                                    usrInput.removeLast()
                                }
                            case "÷":
                                usrInput.append("/")
                            case "𝑥":
                                usrInput.append("x")
                            case "﹡":
                                usrInput.append("*")
                            default:
                                usrInput.append(number)
                            }
                        }, label: {
                            Text(number)
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        })
                    }
                }
            }
        }
    }
}


struct Practica: View {
    @Binding var problems:[Bool]
    @Binding var config:Bool
    @State private var check:Bool = false
    @State private var next:Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .padding()
                .dynamicTypeSize(.xLarge)

            let problem = Polynomial(terms: [Term]())
            let _: () = problem.generate(minVal: 0, maxVal: 9, degree: 4)
            let _: () = problem.orderTerms()
            
            LaTeX("f(x) = " + problem.toLatex())
                .parsingMode(.all)

            NumberPadView()
                .padding(.all)
            
            HStack{
                Button("Answ") {
                    print("Problema: \(problem.toString())")
                    print("Answ: \(problem.differentiate().toString())")
                    check.toggle()
                }
                .padding()
                
                Button(action:{
                    print("\n 1: \(problems[0]) \n 2: \(problems[1]) \n 3: \(problems[2]) \n 4: \(problems[3])")
                    next.toggle()
                }){
                    Image(systemName: "chevron.right")
                }
                .padding()

            }
        }
        .padding()
        
    }
}




struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problems: .constant([true,true,true,true]), config: .constant(true))
    }
}
