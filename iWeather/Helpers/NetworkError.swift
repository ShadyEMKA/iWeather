//
//  ErrorsNetwork.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import Foundation

enum NetworkError {
    
    case errorServer
    case errorDecodeJSON
    case unknownError
    case urlError
    case locationError
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .errorServer:
            return NSLocalizedString("Ошибка сервера", comment: "Проверьте соединение с сетью")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "Обратитесь в службу поддержки")
        case .errorDecodeJSON:
            return NSLocalizedString("Ошибка парсинга", comment: "Обратитесь в службу поддержки")
        case .urlError:
            return NSLocalizedString("Ошибка URL", comment: "Обратитесь в службу поддержки")
        case .locationError:
            return NSLocalizedString("Необходим доступ к геолокации", comment: "Обратитесь в службу поддержки")
        }
    }
}
