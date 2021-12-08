//
//  WeatherModel.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation

struct CurrentWeatherModel: CurrentWeatherCVCViewModel {

    var nameCity: String?
    var image: String
    var nameWeather: String
    var date: String
    var temperature: String
    var wind: String
    var feelsLike: String
    var visibility: String
    var pressure: String
}

struct HourlyWeatherModel: DayWeatherCVCViewModel {
    
    var time: String
    var icon: String
    var temperature: String
}

struct DailyWeatherModel: DailyWeatherTVCViewModel {
    
    var icon: String
    var date: String
    var tempDay: String
    var tempNight: String
}
