//
//  Extensions.swift
//  DropImage
//
//  Created by Omar Alqabbani on 7/11/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static var paintPadBackgroundColor = rgb(r: 250, g: 190, b: 90)
}
