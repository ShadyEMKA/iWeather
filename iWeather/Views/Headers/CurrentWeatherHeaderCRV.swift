//
//  CityHeaderCRV.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import UIKit

protocol CurrentWeatherHeaderCRVViewModel {
    var nameCity: String { get }
}

class CurrentWeatherHeaderCRV: UICollectionReusableView {
        
    static let reuseId = "CurrentWeatherHeaderCRV"
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel(font: .customBold(size: 34), textColor: .black)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(name: String?) {
        self.nameLabel.text = name
    }
}

// MARK: - Setup subviews and constraints
extension CurrentWeatherHeaderCRV {
    
    private func setupSubviews() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
