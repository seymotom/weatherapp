//
//  APIManager.swift
//  WeatherApp
//
//  Created by Tom Seymour on 8/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation


class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func getData(endpoint: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            }
            if let data = data {
                completion(data)
            }
            }.resume()
    }

}
