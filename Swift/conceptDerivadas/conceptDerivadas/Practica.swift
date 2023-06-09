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
    @State private var check:Bool = false
    @State private var next:Bool = false

    
    var body: some View {
        VStack(alignment: .center) {
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .padding()
                .dynamicTypeSize(.xLarge)
            
//            let problem = ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 3, denominator: 2), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 4, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 3, denominator: 2))
            
            let problem = ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 2, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 2, denominator: 1))
            
            LaTeX("f(x) = " + problem.toLatex())
                .parsingMode(.all)

            NumberPadView()
                .padding(.all)
            
            HStack{
                Button("Answ") {
                    print(problem.diffString())
                    check.toggle()
                }
                .padding()
                
                Button(action:{
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
        Practica()
    }
}
