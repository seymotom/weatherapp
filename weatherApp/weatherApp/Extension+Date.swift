//
//  Extension+Date.swift
//  WeatherApp
//
//  Created by Tom Seymour on 8/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation

extension Date {
    
    func displayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: self)
    }
}
