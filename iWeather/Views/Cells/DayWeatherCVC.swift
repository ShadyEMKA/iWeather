//
//  DayCityCVC.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit

protocol DayWeatherCVCViewModel {
    
    var time: String { get }
    var icon: String { get }
    var temperature: String { get }
}

class DayWeatherCVC: UICollectionViewCell {
    
    static let reuseId = "DayWeatherCVC"
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel(font: .customRegular(size: 15), textColor: .black)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel(font: .customBold(size: 15), textColor: .black)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .backgroundColor()
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
        imageView.image = nil
        temperatureLabel.text = nil
    }
    
    func configureCell(model: DayWeatherCVCViewModel) {
        self.timeLabel.text = model.time
        self.imageView.image = UIImage(named: model.icon)
        self.temperatureLabel.text = model.temperature
    }
}

// MARK: - Setup subviews and constraints
extension DayWeatherCVC {
    
    private func setupSubviews() {
        addSubview(timeLabel)
        addSubview(imageView)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
