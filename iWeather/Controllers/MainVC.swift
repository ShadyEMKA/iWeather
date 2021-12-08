//
//  MainVC.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 4.12.21.
//

import UIKit
import MapKit
import CoreLocation

class MainVC: UIViewController {
    
    enum Section: Int {
        case city
        case daysForCity
    }
    
    private var collectionView: UICollectionView!
    private let locationManager = CLLocationManager()
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refresh
    }()
    private var currentWeather = [CurrentWeatherModel]()
    private var hourlyWeather = [HourlyWeatherModel]()
    private var dailyWeather = [DailyWeatherModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = "Назад"
        setupCollectionView()
        setupNavigationItem()
        setupLocationManager()
        loadingFromUserDefaults()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds
    }

    private func setupCollectionView() {
        let layout = compositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 20
        collectionView.register(CurrentWeatherCVC.self, forCellWithReuseIdentifier: CurrentWeatherCVC.reuseId)
        collectionView.register(DayWeatherCVC.self, forCellWithReuseIdentifier: DayWeatherCVC.reuseId)
        collectionView.register(CurrentWeatherHeaderCRV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrentWeatherHeaderCRV.reuseId)
        collectionView.register(DayWeatherHeaderCRV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DayWeatherHeaderCRV.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "iWeather"
    }
    
    @objc private func refreshAction() {
        loadingWeatherFromNetwork()
    }
}

// MARK: - Setup compositional layout
extension MainVC {
    
    private func compositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let section = Section.init(rawValue: sectionIndex) else { return nil }
            switch section {
            case .city:
                return self.layoutForCity()
            case .daysForCity:
                return self.layoutForDaysCity()
            }
        }
        return layout
    }
    
    private func layoutForCity() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 40),
                                          heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 20
        let header = layoutHeaderCity()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func layoutForDaysCity() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                          heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 15
        let header = layoutHeaderDay()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func layoutHeaderCity() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
    
    private func layoutHeaderDay() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }

}

// MARK: - UICollectionView delegate and datasource
extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        switch section {
        case .city:
            return currentWeather.count
        case .daysForCity:
            return hourlyWeather.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section.init(rawValue: indexPath.section) else { fatalError("Error configure cell") }
        switch section {
        case .city:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCVC.reuseId, for: indexPath) as! CurrentWeatherCVC
            cell.configureCell(model: currentWeather[indexPath.row])
            return cell
        case .daysForCity:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherCVC.reuseId, for: indexPath) as! DayWeatherCVC
            cell.configureCell(model: hourlyWeather[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = Section.init(rawValue: indexPath.section) else { fatalError("Error configure header")}
        switch section {
        case .city:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentWeatherHeaderCRV.reuseId, for: indexPath) as! CurrentWeatherHeaderCRV
            if currentWeather.isEmpty {
                return header
            } else {
                header.configureHeader(name: currentWeather[indexPath.section].nameCity)
            }
            return header
        case .daysForCity:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DayWeatherHeaderCRV.reuseId, for: indexPath) as! DayWeatherHeaderCRV
            if currentWeather.isEmpty {
                header.isHidden = true
                return header
            } else {
                header.isHidden = false
                header.delegate = self
            }
            return header
        }
        
    }
}

// MARK: - Loading weather
extension MainVC {
    
    private func loadingFromUserDefaults() {
        DataFetcher.shared.getWeatherFromStorage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.createModels(model: model)
            case .failure(_):
                // TO DO
                break
            }
        }
    }
    
    private func loadingWeatherFromNetwork() {
        guard let location = locationManager.location else {
            showAlert(title: "Ошибка", message: NetworkError.locationError.localizedDescription) { [unowned self] in
                self.refreshControl.endRefreshing()
            }
            return
        }
        DataFetcher.shared.getWeatherFromNetwork(forLocation: location) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка", message: error.localizedDescription) {
                        self.refreshControl.endRefreshing()
                    }
                }
                return
            }
            self.loadingFromUserDefaults()
        }
    }
    
    private func createModels(model: WeatherResponse) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "Create models", qos: .utility, attributes: .concurrent)
        queue.async(group: group) {
            self.currentWeather = model.current.weather.map { weather in
                return CurrentWeatherModel(nameCity: model.namyCity,
                                           image: self.setupIconForWeather(weather.id),
                                           nameWeather: weather.description.firstCapitalized,
                                           date: model.current.dt.dateFormat(),
                                           temperature: model.current.temp.kelvinInCelsius(),
                                           wind: model.current.windSpeed.roundToOne(),
                                           feelsLike: model.current.feelsLike.kelvinInCelsius(),
                                           visibility: model.current.visibility.description,
                                           pressure: model.current.pressure.description)
            }
        }
        queue.async(group: group) {
            self.hourlyWeather = model.hourly.map { weather in
                let itemId = weather.weather.first?.id ?? 0
                return HourlyWeatherModel(time: weather.dt.dateFormat(forHour: true),
                                          icon: self.setupIconForWeather(itemId),
                                          temperature: weather.temp.kelvinInCelsius())
            }
        }
        queue.async(group: group) {
            self.dailyWeather = model.daily.map { weather in
                let itemId = weather.weather.first?.id ?? 0
                return DailyWeatherModel(icon: self.setupIconForWeather(itemId),
                                         date: weather.dt.dateFormat(),
                                         tempDay: weather.temp.day.kelvinInCelsius(forDaily: true),
                                         tempNight: weather.temp.night.kelvinInCelsius(forDaily: true))
            }
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupIconForWeather(_ id: Int) -> String {
        switch id {
        case 200...232:
            return "11d"
        case 300...321:
            return "09d"
        case 500...504:
            return "10d"
        case 511:
            return "13d"
        case 520...531:
            return "09d"
        case 600...622:
            return "13d"
        case 701...781:
            return "50d"
        case 800:
            return "01d"
        case 801:
            return "09d"
        case 802:
            return "03d"
        case 803...804:
            return "04d"
        default:
            return "01d"
        }
    }
}

// MARK: - DayWeatherHeader delegate
extension MainVC: DayWeatherHeaderCRVDelegate {
    
    func daysButtonAction() {
        let nextVC = DailyWeatherVC()
        nextVC.dailyWeather = self.dailyWeather
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - MapKit
extension MainVC: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            loadingWeatherFromNetwork()
        } else {
            showAlert(title: "Ошибка", message: NetworkError.locationError.localizedDescription)
        }
    }
}
