//
//  WeatherResponse.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation

class WeatherResponse: Codable {
    
    var namyCity: String?
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

class CurrentWeather: Codable {
    
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let visibility: Int
    let windSpeed: Double
    let weather: [Weather]
}

class HourlyWeather: Codable {
    
    let dt: Double
    let temp: Double
    let weather: [Weather]
}

class DailyWeather: Codable {
    
    let dt: Double
    let temp: Temperature
    let weather: [Weather]
}

class Weather: Codable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}

class Temperature: Codable {
    
    let day: Double
    let night: Double
}

