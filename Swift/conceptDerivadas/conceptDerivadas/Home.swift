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
    @State private var mostrarCred:Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Spacer()
                TextField("ID", text: $id)
                    .padding()
                
                TextField("Nombre", text: $nombre)
                    .padding()
                
                NavigationLink(destination: PracConfig(alumno: $alumno)){
                    Text("Práctica")
                }
                .navigationTitle("Derivada del Día")
                .disabled((nombre == "" || id == ""))
                
                Spacer()
                
                VStack{
                    Button("Créditos"){
                        mostrarCred = true
                        print("credito")
                    }
                }
                .popover(isPresented: $mostrarCred) {
                    Text("Derivada del Día ha sido desarrollado por estudiantes del Tecnológico de Monterrey durante el verano de 2023, como parte del proyecto social 'Acciones Ciudadanas' y asesorados por la maestra Yolanda Martínez Treviño.\n\nDesarrolladores:\nAlejandro Hernández Carrales \n Patricio Santos Garza\n\n Derivada del Día se distribuye como está de manera gratuita y se prohíbe su distribución y uso con fines de lucro.")
                        .multilineTextAlignment(.leading)
                        .padding()
                }
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
