//
//  Config.swift
//  conceptDerivadas
//
//  Created by Alumno on 20/06/23.
//

import UIKit

class ListProb: NSObject {
    var poly:[PolyProb]
    var chain:[ChainProb]
    var prod:[ProdProb]
    var quo:[QuoProb]
        
    init(poly:[PolyProb], chain:[ChainProb], prod:[ProdProb], quo:[QuoProb]){
        self.poly = poly
        self.chain = chain
        self.prod = prod
        self.quo = quo
    }
}
