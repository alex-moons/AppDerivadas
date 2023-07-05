//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

protocol Problem {
    associatedtype problemType
    var problem: problemType { get set }
    var answ: String {get}
    var usrAnsw: String {get set}
    var correct: Bool {get}

    func check()
}

class PolyProb: Problem {
    var problem:Polynomial
    var answ:String
    var usrAnsw:String
    var correct:Bool
    
    init(problem:Polynomial, usrAnsw:String){
        self.problem = problem
        self.answ = problem.differentiate().toString()
        self.usrAnsw = usrAnsw
        self.correct = false
    }
    
    func check(){
        var usr = self.usrAnsw
        usr = usr.replacingOccurrences(of: "(", with: "")
        usr = usr.replacingOccurrences(of: ")", with: "")
        usr = usr.replacingOccurrences(of: "*", with: "")
        if self.answ == usr{
            self.correct = true
        }
    }
}
