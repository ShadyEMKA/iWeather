//
//  DataFetcher.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation
import CoreLocation

final class DataFetcher {
    
    private init() {}
    
    static let shared = DataFetcher()
    typealias handler = (Result<WeatherResponse,Error>) -> Void
    private let userDefaults = UserDefaults.standard
    
    private let networkManager = NetworkManager()
    
    func getWeatherFromNetwork(forLocation location: CLLocation, completion: @escaping (Error?) -> Void) {
        getNameCity(location: location) { name in
            let options = ["lat": String(location.coordinate.latitude),
                           "lon": String(location.coordinate.longitude)]
            self.networkManager.getRequest(path: API.getCurrent, options: options) { [unowned self] result in
                switch result {
                case .success(let data):
                    self.userDefaults.set(name, forKey: "cityName")
                    self.userDefaults.set(data, forKey: "weather")
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    func getWeatherFromStorage(completion: @escaping handler) {
        DispatchQueue.global(qos: .utility).async {
            guard let weatherData = self.userDefaults.object(forKey: "weather") as? Data,
                  let nameCity = self.userDefaults.object(forKey: "cityName") as? String,
                  let models = self.decodeJSON(for: WeatherResponse.self, data: weatherData) else {
                      completion(.failure(NetworkError.errorServer))
                      return
                  }
            models.namyCity = nameCity
            completion(.success(models))
        }
    }
    
    private func decodeJSON<T: Codable>(for type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            return nil
        }
    }
    
    private func getNameCity(location: CLLocation, completion: @escaping (String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { item, _ in
            let name = item?.last?.administrativeArea ?? ""
            completion(name)
        }
    }
}
