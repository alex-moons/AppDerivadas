//
//  Resultados.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

struct Resultados: View {
    @State var results: [[String]] =
    [
        ["#1", "Correcta", "0:34"],
        ["#2", "Correcta", "0:54"],
        ["#3", "Incorrecta", "1:01"],
        ["#4", "Correcta", "0:32"],
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(results, id: \.self){ i in
                VStack{
                    List(i, id: \.self){
                        item in
                        Text(item)
                    }
                }
            }
        }
 
    }
}

struct Resultados_Previews: PreviewProvider {
    static var previews: some View {
        Resultados()
    }
}
