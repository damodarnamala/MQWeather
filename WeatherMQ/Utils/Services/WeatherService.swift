//
//  WeatherService.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreLocation

class WeatherService {
    static let shared = WeatherService()
    func fetch(for coords: CLLocationCoordinate2D,
               completion:@escaping (Result<WeatherResponse, Error>) ->  Void) {
        if Reach().isNetworkReachable() {
            let http = Http.shared
            http.request(with: APIService.weather(coords).url) { (response) in
                switch response {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let weather = try decoder.decode(WeatherResponse.self, from: data)
                        completion(.success(weather))
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


