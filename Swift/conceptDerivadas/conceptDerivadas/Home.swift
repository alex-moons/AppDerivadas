//
//  Home.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

struct Home: View {
    
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
                        NavigationLink(destination: Practica()){
                            Text("Práctica")
                        }
                        .navigationTitle("Home")
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

