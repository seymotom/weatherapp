//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by Tom Seymour on 8/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import UIKit

enum TemperatueUnit {
    case celsius
    case fahrenheit
}

class ForecastTableViewController: UITableViewController {
    
    @IBOutlet weak var tempUnitControl: UISegmentedControl!

    var forecasts: [Forecast] = []
    
    var temperatureUnit: TemperatueUnit = .fahrenheit

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension

        ForecastManager.shared.getWeather { (forecasts) in
            if let forecasts = forecasts {
                self.forecasts = forecasts
                dump(self.forecasts)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        let forecast = forecasts[indexPath.row]
        
        return configure(cell: cell, for: forecast)
    }
    
    func configure(cell: ForecastTableViewCell, for forecast: Forecast) -> ForecastTableViewCell {
        let icon = String(forecast.icon.characters)
        cell.iconImageView.image = UIImage(named: icon)
        cell.dateLabel.text = forecast.date.displayString()
        cell.weatherDescriptionLabel.text = forecast.weatherDescription
        
        let high = temperatureUnit == .fahrenheit ? "\(String(forecast.maxTempF))°F" : "\(String(forecast.maxTempC))°C"
        let low = temperatureUnit == .fahrenheit ? "\(String(forecast.minTempF))°F" : "\(String(forecast.minTempC))°C"
        cell.highTempLabel.text = "High: \(high)"
        cell.lowTempLabel.text = "Low: \(low)"
        return cell
    }


    @IBAction func tempUnitDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            temperatureUnit = .fahrenheit
        case 1:
            temperatureUnit = .celsius
        default:
            break
        }
        tableView.reloadData()
    }
    
}

