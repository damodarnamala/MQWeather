//
//  WeatherService.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreLocation

enum APIService: StringConvertable {
    case weather(CLLocationCoordinate2D)
    
    private var  baseUrl: String {
        return "https://api.openweathermap.org/data/2.5/onecall?"
    }
    
    private var  apppID: String {
        return "fae7190d7e6433ec3a45285ffcf55c86"
    }
    
    private var  units: String {
        return SettingsDB.shared.getUnits()
    }
    
    var url: String {
        switch self {
        case .weather(let coord):
            let string = baseUrl + "lat=\(coord.latitude)&lon=\(coord.longitude)&units=\(units)&appid=\(apppID)"
            print(string)
            return string
        }
        
    }
}


