//
//  Forecast.swift
//  WeatherApp
//
//  Created by Tom Seymour on 8/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation

enum ForecastField: String {
    case date = "dateTimeISO"
    case weatherDescription = "weather"
    case maxTempC, maxTempF, minTempC, minTempF, icon
}

class Forecast {
    let date: Date
    let maxTempC: Int
    let maxTempF: Int
    let minTempC: Int
    let minTempF: Int
    let weatherDescription: String
    let icon: String
    
    init(date: Date, maxTempC: Int, maxTempF: Int, minTempC: Int, minTempF: Int, weatherDescription: String, icon: String) {
        self.date = date
        self.maxTempC = maxTempC
        self.maxTempF = maxTempF
        self.minTempC = minTempC
        self.minTempF = minTempF
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
    
    convenience init?(from dict: [String: Any]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        guard
            let dateTimeISO = dict[ForecastField.date.rawValue] as? String,
            let date = dateFormatter.date(from: dateTimeISO),
            let maxTempF = dict[ForecastField.maxTempF.rawValue] as? Int,
            let maxTempC = dict[ForecastField.maxTempC.rawValue] as? Int,
            let minTempF = dict[ForecastField.minTempF.rawValue] as? Int,
            let minTempC = dict[ForecastField.minTempC.rawValue] as? Int,
            let weatherDescription = dict[ForecastField.weatherDescription.rawValue] as? String,
            let icon = dict[ForecastField.icon.rawValue] as? String
            else {
                return nil
        }
        self.init(date: date, maxTempC: maxTempC, maxTempF: maxTempF, minTempC: minTempC, minTempF: minTempF, weatherDescription: weatherDescription, icon: icon)
    }
}




