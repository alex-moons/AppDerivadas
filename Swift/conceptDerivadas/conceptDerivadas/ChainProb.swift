//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class ChainProb: Problem {
    var problem:ChainRule
    var answ:String
    var usrAnsw:String
    var correct:Bool
    
    init(problem:ChainRule, usrAnsw:String){
        self.problem = problem
        self.answ = problem.diffString()
        self.usrAnsw = usrAnsw
        self.correct = false
    }
    
    func check(){
        var usr = self.usrAnsw
        usr = usr.replacingOccurrences(of: "(", with: "")
        usr = usr.replacingOccurrences(of: ")", with: "")
        if self.answ == usr{
            self.correct = true
        }
    }
}
