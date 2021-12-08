//
//  NetworkManager.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation

final class NetworkManager {
    
    typealias handler = (Result<Data,Error>) -> Void
    
    func getRequest(path: String, options: [String: String], completion: @escaping handler) {
        guard let url = configureURL(path: path, options: options) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.unknownError))
                    return
                }
                completion(.success(data))
            }.resume()
        }
    }
    
    private func configureURL(path: String, options: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = path
        var allOptions = options
        allOptions["appid"] = API.token
        allOptions["lang"] = "ru"
        allOptions["exclude"] = "minutely,alerts"
        urlComponents.queryItems = allOptions.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url
    }
}
