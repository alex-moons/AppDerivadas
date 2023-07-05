//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class Alumno: NSObject {
    @Published var nombre: String
    @Published var id: String
    
    init(nombre: String, id: String) {
        self.nombre = nombre
        self.id = id
    }
}
