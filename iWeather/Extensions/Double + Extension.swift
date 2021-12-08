//
//  Double + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation

extension Double {
    
    func kelvinInCelsius(forDaily daily: Bool = false) -> String {
        let result = self - 273.15
        if daily {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.1f", result) + " ℃"
        }
    }
    
    func roundToOne() -> String {
        return String(format: "%.1f", self)
    }
    
    func dateFormat(forHour hour: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        if hour {
            dateFormatter.dateFormat = "HH:'00'"
        } else {
            dateFormatter.dateFormat = "EEEE, d MMM"
        }
        let date = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: date).firstCapitalized
    }
}
