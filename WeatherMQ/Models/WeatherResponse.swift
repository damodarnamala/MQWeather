//
//  WeatherResponse.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 02/02/21.
//

import Foundation

struct WeatherResponse: Decodable {
    var lat: Double?
    var lon: Double?
    var current: Current?
}

struct Current: Decodable {
    var temp: Double?
    var wind_speed: Double?
    var humidity: Double?
    var pressure: Double?
}
