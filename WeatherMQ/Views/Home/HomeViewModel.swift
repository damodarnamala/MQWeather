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
}

protocol HomeViewDlegate {
    func viewWillAppreare()
    func fetchLocation(with coordinate: CLLocationCoordinate2D)
}

class HomeViewModel: HomeViewDlegate {
    
    var delegate: LocationResponseDelegate?
    private var geocoder: GeoCoderService?
    private var locationManager: LocationService?
    
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
        self.locationManager?.stopUpdatingLocation()
        self.fetchLocation(with: currentLocation.coordinate)
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        self.locationManager?.stopUpdatingLocation()
    }
}



struct Weather {
    var temperature: String?
}
