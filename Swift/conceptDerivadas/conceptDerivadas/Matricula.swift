//
//  Matricula.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI

struct Matricula: View {
    @EnvironmentObject var appInfo: AppInfo
    @Environment(\.dismiss) private var dismiss
    @State var mat:String = ""
    @State var nombre:String = ""

    var body: some View {
        VStack(alignment: .center){
            TextField(
                "Matricula",
                text: $mat
            )
            .padding()
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            TextField(
                "Nombre",
                text: $nombre
            )
            .padding()
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)

            Button(action:{
                appInfo.nombre = nombre
                appInfo.matricula = mat
                dismiss()
            }){
                Text("Entrar")
            }
            .padding()
        }

    }
}


struct Matricula_Previews: PreviewProvider {
    static var previews: some View {
        Matricula()
    }
}
