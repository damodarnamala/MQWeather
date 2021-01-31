//
//  GeoCoderService.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//


import Foundation
import CoreLocation

final class GeoCoderService {
    static let shared = GeoCoderService()
    
    func geocode(latitude: CLLocationDegrees,
                        longitude: CLLocationDegrees,
                        completion: @escaping(_ placemark: CLPlacemark?) -> Void)   {
        
        let location = CLLocation(latitude: latitude,
                                  longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (pm, error) in
            if error != nil {
                print("something went horribly wrong")
                completion(nil)
            }
            if let pmark = pm?.first {
                completion(pmark)
            }
        }
    }
}
