//
//  StringProtocol + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 8.12.21.
//

import Foundation

extension StringProtocol {
    
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}
