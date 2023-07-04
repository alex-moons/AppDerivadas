//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class Problems: NSObject {
    var poly:[PolyProb]
    var chain:[ChainProb]
    var prod:[ProdProb]
    var quo:[QuoProb]
    
    init(grado:Int) {
        self.poly = [PolyProb(problem: genPoly(grado: grado), usrAnsw: "")]
        self.chain = [ChainProb(problem: genChain(grado: grado), usrAnsw: "")]
        self.prod = [ProdProb(problem: genProd(grado: grado), usrAnsw: "")]
        self.quo = [QuoProb(problem: genQuo(grado: grado), usrAnsw: "")]
    }
}
