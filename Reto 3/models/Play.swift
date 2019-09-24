//
//  Plays.swift
//  Reto 3
//
//  Created by Laurent castañeda ramirez on 9/11/19.
//  Copyright © 2019 Laurent castañeda ramirez. All rights reserved.
//

import Foundation

struct Play {
    
    var state:Int
    
    init(state: Int) {
        self.state = state
    }
    
    
    mutating func editValue(state: Int){
        self.state = state
    }
    
}
