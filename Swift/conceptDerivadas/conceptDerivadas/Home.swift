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
        VStack {
            VStack {
                NavigationView{
                    VStack(alignment: .center){
                        Spacer()
                        TextField("ID", text: $id)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        TextField("Nombre", text: $nombre)
                            .textFieldStyle(.roundedBorder)
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
                        .padding()
                        .popover(isPresented: $mostrarCred) {
                            Text("Derivada del Día ha sido desarrollado por estudiantes del Tecnológico de Monterrey durante el periodo Feb-Jul del 2023, asesorados por la maestra Yolanda Martínez Treviño.\n\nDesarrolladores:\nAlejandro Hernández Carrales \n Patricio Santos Garza\n\n Derivada del Día se distribuye como está de manera gratuita y se prohíbe su distribución y uso con fines de lucro.")
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
            .background(Color.white)
            .cornerRadius(10)
            .padding(8)
        }
        .background(Color.indigo)
    }
}

    
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(alumno: Alumno(nombre: "", id: ""), nombre: "", id: "")
    }
}
