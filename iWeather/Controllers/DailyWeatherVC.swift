//
//  DailyWeatherVC.swift
//  iWeather
//
//  Created by Андрей Шкундалёв on 6.12.21.
//

import UIKit

class DailyWeatherVC: UIViewController {
    
    private var tableView: UITableView!
    
    var dailyWeather = [DailyWeatherModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationItem()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(DailyWeatherTVC.self, forCellReuseIdentifier: DailyWeatherTVC.reuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundColor()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Минск"
    }
}

// MARK: - UITableView datasource and delegate
extension DailyWeatherVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTVC.reuseId, for: indexPath) as! DailyWeatherTVC
        cell.configureCell(model: dailyWeather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}
