//
//  UIColor + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit

extension UIColor {
    
    static func backgroundColor() -> UIColor {
        return UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
    static func cityBackgroundColor() -> UIColor {
        return UIColor(displayP3Red: 52/255, green: 120/255, blue: 255/255, alpha: 1)
    }
    
    static func customGrayColor() -> UIColor {
        return UIColor(displayP3Red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
    }
}
