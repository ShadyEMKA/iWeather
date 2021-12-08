//
//  UIFont + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit

extension UIFont {
    
    static func customRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "HeliosC", size: size)
    }
    
    static func customBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "HeliosC-Bold", size: size)
    }
}
