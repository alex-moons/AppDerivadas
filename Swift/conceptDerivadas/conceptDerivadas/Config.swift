//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class Config: NSObject {
    var problemas:[Bool]
    var general:Bool
    
    init(problemas:[Bool], general:Bool){
        self.problemas = [true, false, false, false]
        self.general = true
    }

}

