//
//  Home.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var appInfo: AppInfo
    @State var idTrig:Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Button(action:{
                    self.idTrig = true
                }){
                    Text("ID")
                }
                HStack{
                    Button(action:{
                        
                    }){
                        if (appInfo.nombre != "" && appInfo.matricula != ""){
                            NavigationLink(destination: Practica()){
                                Text("Práctica")
                            }
                            .navigationTitle(appInfo.matricula + " " + appInfo.nombre)
                            
                        } else {
                            NavigationLink(destination: Practica()){
                                Text("Práctica")
                            }
                            .navigationTitle("Home")
                        }
                    }
                    
                    Button(action:{
                        
                    }){
                        NavigationLink(destination: Examen()){
                            Text("Examen")
                        }
                        
                    }
                }
            }
                .sheet(isPresented: $idTrig){ Matricula()
                }
                
            }
        }
    }
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }

class AppInfo: ObservableObject{
    @Published var matricula = ""
    @Published var nombre = ""
}
