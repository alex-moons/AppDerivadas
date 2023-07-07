//
//  PracConfig.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import SwiftUI

struct PracConfig: View {
    @Binding var alumno:Alumno
    //los problems es qué tipo de regla hay, 0.General, 1.Cadena, 2.Producto, 3.Cociente
    @State private var problems:[Bool] = [true,false,false,false]
    //Config es para el cronómetro
    @State private var config:Bool = true
    //Grado es para dificultad
    @State private var grado:Int = 3
    //minimum se asegura que al menos una regla sea seleccionada
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
            
            Section(header: Text("General")){
                Toggle("Cronómetro", isOn: $config)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                
                Stepper("Dificultad \(grado)", value: $grado, in: 1...3)
            }
            
            NavigationLink(destination: Practica(alumno: $alumno, problemConfig: $problems, config: $config, grado: $grado), label: {Text("Empezar")})
                .buttonStyle(.plain)
                .foregroundColor(.indigo)
                .disabled(minimum)
        }
        .navigationTitle("Configuración")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PracConfig_Previews: PreviewProvider {
    static var previews: some View {
        PracConfig(alumno: .constant(Alumno(nombre: "", id: "")))
    }
}
