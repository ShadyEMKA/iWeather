//
//  CityCVC.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit

protocol CurrentWeatherCVCViewModel {
    var image: String { get }
    var nameWeather: String { get }
    var date: String { get }
    var temperature: String { get }
    var wind: String { get }
    var feelsLike: String { get }
    var visibility: String { get }
    var pressure: String { get }
}

class CurrentWeatherCVC: UICollectionViewCell {
    
    static let reuseId = "CurrentWeatherCVC"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel(font: .customBold(size: 23), textColor: .white)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel(font: .customRegular(size: 17), textColor: .white)
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel(font: .customBold(size: 57), textColor: .white)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    private let horizontalLineFirst: UIView = {
        let horizontalLineFirst = UIView()
        horizontalLineFirst.backgroundColor = .white
        horizontalLineFirst.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLineFirst
    }()
    
    private let horizontalLineSecond: UIView = {
        let horizontalLineSecond = UIView()
        horizontalLineSecond.backgroundColor = .white
        horizontalLineSecond.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLineSecond
    }()
    
    private let verticalLine: UIView = {
        let verticalLine = UIView()
        verticalLine.backgroundColor = .white
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        return verticalLine
    }()
    
    private let windView: OptionsView = {
        let view = OptionsView(for: .wind)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let feelsLikeView: OptionsView = {
        let view = OptionsView(for: .feelsLike)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let visibilityView: OptionsView = {
        let view = OptionsView(for: .visibility)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pressureView: OptionsView = {
        let view = OptionsView(for: .pressure)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cityBackgroundColor()
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.cityBackgroundColor().cgColor
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
        temperatureLabel.text = nil
    }
    
    func configureCell(model: CurrentWeatherCVCViewModel) {
        self.nameLabel.text = model.nameWeather
        self.dateLabel.text = model.date
        self.temperatureLabel.text = model.temperature
        self.imageView.image = UIImage(named: model.image)
        self.windView.setupValue(value: model.wind, for: .wind)
        self.feelsLikeView.setupValue(value: model.feelsLike, for: .feelsLike)
        self.visibilityView.setupValue(value: model.visibility, for: .visibility)
        self.pressureView.setupValue(value: model.pressure, for: .pressure)
    }
}

// MARK: - Setup subviews and constraints
extension CurrentWeatherCVC {
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(horizontalLineFirst)
        addSubview(horizontalLineSecond)
        addSubview(verticalLine)
        addSubview(windView)
        addSubview(feelsLikeView)
        addSubview(visibilityView)
        addSubview(pressureView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            windView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            windView.leadingAnchor.constraint(equalTo: leadingAnchor),
            windView.trailingAnchor.constraint(equalTo: verticalLine.leadingAnchor),
            windView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            feelsLikeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            feelsLikeView.leadingAnchor.constraint(equalTo: verticalLine.trailingAnchor),
            feelsLikeView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            horizontalLineFirst.bottomAnchor.constraint(equalTo: windView.topAnchor),
            horizontalLineFirst.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalLineFirst.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalLineFirst.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            horizontalLineSecond.topAnchor.constraint(equalTo: windView.bottomAnchor),
            horizontalLineSecond.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalLineSecond.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalLineSecond.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        NSLayoutConstraint.activate([
            visibilityView.topAnchor.constraint(equalTo: horizontalLineSecond.bottomAnchor),
            visibilityView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visibilityView.trailingAnchor.constraint(equalTo: verticalLine.leadingAnchor),
            visibilityView.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            pressureView.topAnchor.constraint(equalTo: horizontalLineSecond.bottomAnchor),
            pressureView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pressureView.leadingAnchor.constraint(equalTo: verticalLine.trailingAnchor),
            pressureView.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            verticalLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalLine.topAnchor.constraint(equalTo: horizontalLineFirst.bottomAnchor),
            verticalLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalLine.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        bottomAnchor.constraint(equalTo: pressureView.bottomAnchor).isActive = true
    }
}
