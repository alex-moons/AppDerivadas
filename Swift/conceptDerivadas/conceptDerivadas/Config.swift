//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class Config {
    var general: Bool
    var cadena: Bool
    var producto: Bool
    var cociente: Bool
    var crono: Bool
    var grado: Int

    init(general: Bool, cadena: Bool, producto: Bool, cociente: Bool, crono: Bool, grado: Int) {
        self.general = general
        self.cadena = cadena
        self.producto = producto
        self.cociente = cociente
        self.crono = crono
        self.grado = grado
    }

    init() {
        self.general = true
        self.cadena = false
        self.producto = false
        self.cociente = false
        self.crono = true
        self.grado = 3
    }

    func valid() -> Bool {
        if self.general || self.cadena || self.producto || self.cociente {
            return true
        }
        return false
    }
}
