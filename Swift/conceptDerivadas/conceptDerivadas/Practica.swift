//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct NumberPadView: View {
    @State private var enteredNumber: String = ""
    
    let rows = [
        ["1", "2", "3", "⌫"],
        ["4", "5", "6", "/"],
        ["7", "8", "9", "•"],
        ["𝑥", "0", "+", "-"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Respuesta: \(enteredNumber)")
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { number in
                        Button(action: {
                            if number.isEmpty {
                            // Handle delete or clear button actions
                            enteredNumber = ""
                            } else {
                                enteredNumber += number
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
            
            
            LaTeX("\\frac{d}{dx} f(x) = \\frac{d}{dx} x^2")
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
