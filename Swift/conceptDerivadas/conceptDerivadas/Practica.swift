//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Practica: View {
    @State private var answ:String = ""
    @State private var check:Bool = false
    @State private var next:Bool = false

    
    var body: some View {
        VStack(alignment: .center) {
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .padding()
            
            
            LaTeX("\\frac{d}{dx} f(x) = \\frac{d}{dx} x^2")
                .parsingMode(.all)
 
            
            TextField(
                "Respuesta",
                text: $answ
            )
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            .padding()

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
