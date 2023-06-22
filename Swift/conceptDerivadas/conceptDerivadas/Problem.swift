//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class Problem: NSObject {
    var problem:Polynomial
    var answ:String
    var usrAnsw:String
    
    init(problem:Polynomial, answ:String, usrAnsw:String){
        self.problem = problem
        self.answ = answ
        self.usrAnsw = usrAnsw
    }

}

