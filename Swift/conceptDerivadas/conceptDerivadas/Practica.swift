//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct NumberPadView: View {
    @State private var laTex: String = ""
    @State private var bonito: String = ""
    @State private var lastTerm: Int = 0

    let rows = [
        ["1", "2", "3", "⌫", "^"],
        ["4", "5", "6", "/", "{"],
        ["7", "8", "9", "﹡", "}"],
        ["𝑥", "0", "+", "-", "."]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Respuesta: \(laTex)")
            HStack{
                LaTeX("f'(x) =")
                    .parsingMode(.all)
                
                LaTeX(laTex)
                    .parsingMode(.all)
                    .errorMode(.original)
            }
            
            Text("LastTerm: \(lastTerm)")
            
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { number in
                        Button(action: {
                            switch number{
                            case "⌫":
                                if lastTerm != 0 && Int(laTex.suffix(lastTerm)) == nil {
                                    let temp = laTex.dropLast(lastTerm)
                                    laTex = String(temp)
                                }else if lastTerm != 0{
                                    laTex.removeLast()
                                }
                            case "𝑥":
                                laTex.append("x")
                                lastTerm = 1
                            case "+":
                                laTex.append(number)
                                lastTerm = 1
                            case "-":
                                laTex.append(number)
                                lastTerm = 1
                            case "﹡":
                                laTex.append(" *")
                                lastTerm = 1
                            case "/":
                                let numerator = laTex.suffix(lastTerm)
                                let temp = laTex.dropLast(lastTerm)
                                laTex = String(temp)
                                laTex.append("\\frac{\(numerator)}{")
                                lastTerm = lastTerm + 12
                            default:
                                laTex.append(number)
                                lastTerm = 1
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
            
            
            LaTeX("\\ f(x) = \\frac{d}{dx} x^2")
                .parsingMode(.all)
            

            NumberPadView()
                .padding(.all)
            
            HStack{
                Button("Checar") {
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
