//
//  UILabel + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont?, textColor: UIColor) {
        self.init()
        
        self.font = font
        self.textColor = textColor
    }
}
