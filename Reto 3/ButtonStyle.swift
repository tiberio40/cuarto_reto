//
//  ButtonStyle.swift
//  Reto 3
//
//  Created by Laurent castañeda ramirez on 9/10/19.
//  Copyright © 2019 Laurent castañeda ramirez. All rights reserved.
//

import UIKit

class ButtonStyle: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 15
        //self.layer.borderWidth = 2
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
