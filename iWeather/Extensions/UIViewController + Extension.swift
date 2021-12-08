//
//  UIViewController + Extension.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, handler: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
