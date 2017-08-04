//
//  ForecastManager.swift
//  WeatherApp
//
//  Created by Tom Seymour on 8/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case serializeJSONError
}

class ForecastManager {
    
    static let shared = ForecastManager()
    private init() {}
    
    private let weatherEndpoint = "http://api.aerisapi.com/forecasts/11101?client_id=pVZPflfHJYXveEtoMJmh0&client_secret=9bBMHLDN5cHGwtsrG4aDjqs6jQhqGbfUm7TRdoSB"
    
    func getWeather(completion: @escaping ([Forecast]?) -> Void) {
        APIManager.shared.getData(endpoint: weatherEndpoint) { (data) in
            if let data = data {
                completion(self.buildWeatherArray(data: data))
            }
        }
    }
    
    private func buildWeatherArray(data: Data) -> [Forecast] {
        var forecastArray: [Forecast] = []
        do {
            guard
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let responseArray = json["response"] as? [[String: Any]],
                let periodsDict = responseArray.first,
                let periodsArray = periodsDict["periods"] as? [[String: Any]]
            else {
                throw ParseError.serializeJSONError
            }
            for dict in periodsArray {
                if let forecast = Forecast(from: dict) {
                    forecastArray.append(forecast)
                }
            }
        }
        catch ParseError.serializeJSONError {
            print("problem serializing json")
        }
        catch {
            print("unknown error: \(error)")
        }
        
        return forecastArray
    }
}
