//
//  HomeViewModel.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreLocation

protocol LocationResponseDelegate {
    func didFailed(with error: String)
    func didRecieved(location: Location)
    func didRecieved(weather: WeatherMesures)
}

protocol HomeViewDlegate {
    func viewWillAppreare()
    func fetchLocation(with coordinate: CLLocationCoordinate2D)
}

class HomeViewModel: HomeViewDlegate {
    
    var delegate: LocationResponseDelegate?
    private var geocoder: GeoCoderService?
    private var locationManager: LocationService?
    
    let weaterService = WeatherService.shared
    
    init(_ geoCoder: GeoCoderService = GeoCoderService.shared,
         _ locationManager: LocationService = LocationService.shared ) {
        self.geocoder = geoCoder
        self.locationManager = locationManager
    }
    
    func viewWillAppreare() {
        self.locationManager?.delegate = self
        self.locationManager?.startUpdatingLocation()
    }
    
    func fetchLocation(with coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let long = coordinate.longitude
        
        geocoder?.geocode(latitude: lat,
                          longitude: long) { placeMark in
            
            let location = Location(date: Date.today,
                                    name: placeMark?.name,
                                    locality: placeMark?.locality,
                                    subLocality: placeMark?.subLocality,
                                    administration: placeMark?.administrativeArea)
            
            self.delegate?.didRecieved(location: location)
        }
    }
}



extension HomeViewModel: LocationServiceDelegate {
    
    func tracingLocation(_ currentLocation: CLLocation) {
        let coordinates = currentLocation.coordinate
        self.locationManager?.stopUpdatingLocation()
        self.fetchLocation(with: coordinates)
        weaterService.fetch(for: coordinates) { (result) in
            switch result {
            case .success(let weather):
                
                guard let temp = weather.current?.temp,
                      let hummidity_val = weather.current?.humidity,
                      let pressure_val = weather.current?.pressure,
                      let wind_val = weather.current?.wind_speed
                else { return }
               
                let temperature = temp.rounded().clean + "° C"
                let humidity = hummidity_val.rounded().clean + " rh"
                let pressure = pressure_val.rounded().clean + " kPa"
                let wind = wind_val.rounded().clean + " mph"
                let weatherMeasure = WeatherMesures(temp: temperature,
                                             wind_speed: wind,
                                             humidity: humidity,
                                             pressure: pressure)
                self.delegate?.didRecieved(weather: weatherMeasure)
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailed(with: error.localizedDescription)
            }
        }
        
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        self.locationManager?.stopUpdatingLocation()
    }
}
