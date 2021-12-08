//
//  DailyWeatherTVC.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 6.12.21.
//

import UIKit

protocol DailyWeatherTVCViewModel {
    
    var icon: String { get }
    var date: String { get }
    var tempDay: String { get }
    var tempNight: String { get }
}

class DailyWeatherTVC: UITableViewCell {

    static let reuseId = "DailyWeatherTVC"
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel(font: .customBold(size: 17), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel(font: .customBold(size: 17), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel(font: .customRegular(size: 17), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .cityBackgroundColor()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconView.image = nil
        dateLabel.text = nil
        dayTempLabel.text = nil
        nightTempLabel.text = nil
    }
    
    func configureCell(model: DailyWeatherTVCViewModel) {
        self.iconView.image = UIImage(named: model.icon)
        self.dateLabel.text = model.date
        self.dayTempLabel.text = model.tempDay
        self.nightTempLabel.text = "/ \(model.tempNight)℃"
    }
}

// MARK: - Setup subviews and constraints
extension DailyWeatherTVC {
    
    private func setupSubviews() {
        addSubview(iconView)
        addSubview(dateLabel)
        addSubview(dayTempLabel)
        addSubview(nightTempLabel)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            iconView.heightAnchor.constraint(equalToConstant: 50),
            iconView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nightTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nightTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            dayTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayTempLabel.trailingAnchor.constraint(equalTo: nightTempLabel.leadingAnchor, constant: -5)
        ])
    }
}
