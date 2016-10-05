//
//  UIColor+Hex.swift
//  PGD
//
//  Created by Pedro Oliveira on 28/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import Foundation

extension UIColor {
    
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience init(hex: Int, alpha: Float) {
        let components = (
            Red: Float((hex >> 16) & 0xff) / 255,
            Green: Float((hex >> 08) & 0xff) / 255,
            Blue: Float((hex >> 00) & 0xff) / 255
        )
        self.init(colorLiteralRed: components.Red, green: components.Green, blue: components.Blue, alpha: alpha)
    }
}
