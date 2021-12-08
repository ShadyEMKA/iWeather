//
//  OptionsView.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 6.12.21.
//

import UIKit

class OptionsView: UIView {
    
    enum Options: String {
        case wind = "Ветер"
        case feelsLike = "Ощущается"
        case visibility = "Видимость"
        case pressure = "Давление"
        
        var image: UIImage? {
            switch self {
            case .wind:
                return UIImage(systemName: "wind")
            case .feelsLike:
                return UIImage(systemName: "thermometer")
            case .visibility:
                return UIImage(systemName: "eye")
            case .pressure:
                return UIImage(systemName: "waveform.path.ecg")
            }
        }
        
        var units: String {
            switch self {
            case .wind:
                return "м/с"
            case .feelsLike:
                return ""
            case .visibility:
                return "м"
            case .pressure:
                return "гПа"
            }
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(font: .customBold(size: 17), textColor: .white)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel(font: .customRegular(size: 15), textColor: .white)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(for option: Options) {
        super.init(frame: .zero)
    
        setupSubviews()
        backgroundColor = .clear
        
        self.nameLabel.text = option.rawValue
        self.imageView.image = option.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupValue(value: String, for option: Options) {
        self.valueLabel.text = "\(value) \(option.units)"
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
