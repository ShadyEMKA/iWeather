//
//  DayWeatherHeaderCRV.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 5.12.21.
//

import UIKit

protocol DayWeatherHeaderCRVDelegate: AnyObject {
    
    func daysButtonAction()
}

class DayWeatherHeaderCRV: UICollectionReusableView {
        
    static let reuseId = "DayWeatherCRV"
    
    weak var delegate: DayWeatherHeaderCRVDelegate?
    private let dayLabel: UILabel = {
        let dayLabel = UILabel(font: .customBold(size: 19), textColor: .black)
        dayLabel.textAlignment = .left
        dayLabel.text = "Сегодня"
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    private let daysButton: UIButton = {
        let daysButton = UIButton(type: .system)
        daysButton.tintColor = .customGrayColor()
        daysButton.setTitle("Следующие 7 дней", for: .normal)
        daysButton.titleLabel?.font = UIFont.customBold(size: 17)
        daysButton.addTarget(self, action: #selector(pressedDaysButton), for: .touchUpInside)
        daysButton.translatesAutoresizingMaskIntoConstraints = false
        return daysButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressedDaysButton() {
        delegate?.daysButtonAction()
    }
}

// MARK: - Setup subviews and constraints
extension DayWeatherHeaderCRV {
    
    private func setupSubviews() {
        addSubview(dayLabel)
        addSubview(daysButton)
        
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            daysButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            daysButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
