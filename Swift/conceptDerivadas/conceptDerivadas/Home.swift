//
//  Home.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

struct Home: View {
    @State var alumno:Alumno
    @State var nombre:String
    @State var id:String
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                TextField("Nombre", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("ID", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(destination: PracConfig(alumno: $alumno)){
                    Text("Práctica")
                }
                .navigationTitle("Derivada del Día")
            }
            .onDisappear(perform: {
                alumno.nombre = nombre
                alumno.id = id
            })
        }
    }
}

    
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(alumno: Alumno(nombre: "", id: ""), nombre: "", id: "")
    }
}
