//
//  PracConfig.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import SwiftUI

struct PracConfig: View {
    @Binding var alumno:Alumno
    @State private var problems:[Bool] = [true,false,false,false]
    @State private var config:Bool = true
    @State private var grado:Int = 3
    @State private var minimum:Bool = false
    
    var body: some View {
        Form{
            Section(header: Text("Tipos de Problemas")){
                let tipos:[String]=["General","Cadena","Producto","Cociente"]
                
                ForEach(Array(tipos.enumerated()), id:\.offset){ index, element in
                    Toggle(element, isOn: $problems[index])           .toggleStyle(SwitchToggleStyle(tint: .indigo))
                        .onChange(of: problems[index]){ value in
                            if problems.allSatisfy({$0 == false}){
                                minimum = true
                            }else{
                                minimum = false
                            }
                        }
                }
            }
            
            Section(header: Text("Configuraciones")){
                Toggle("Cronómetro", isOn: $config)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                
                Stepper("Dificultad \(grado)", value: $grado, in: 1...3)
            }
            
            NavigationLink(destination: Practica(alumno: .constant(Alumno(nombre: "", id: "")), problemConfig: $problems, config: $config, grado: $grado), label: {Text("Empezar")})
                .buttonStyle(.plain)
                .foregroundColor(.indigo)
                .disabled(minimum)
        }
    }
}

struct PracConfig_Previews: PreviewProvider {
    static var previews: some View {
        PracConfig(alumno: .constant(Alumno(nombre: "", id: "")))
    }
}
