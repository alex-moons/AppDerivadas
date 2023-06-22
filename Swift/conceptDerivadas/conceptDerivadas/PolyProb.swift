//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class PolyProb: NSObject {
    var problem:Polynomial
    var answ:String
    var usrAnsw:String
    
    init(problem:Polynomial, usrAnsw:String){
        self.problem = problem
        self.answ = problem.differentiate().toString()
        self.usrAnsw = usrAnsw
    }
    
    func check() -> Bool {
        self.answ == self.usrAnsw
    }
}
