//
//  FavouriteViewModel.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreLocation

class FavouriteViewModel {
    func getPlacemark(for coordinate: CLLocationCoordinate2D,
                      completion: @escaping(_ location: FavouriteLocations?) -> Void) {
        GeoCoderService.shared.geocode(latitude: coordinate.latitude,
                                longitude: coordinate.longitude) { (pm) in
            if let placeMark = pm {
                let coordinates = placeMark.location?.coordinate
                let name = placeMark.name
                let subLocality = placeMark.subLocality
                let locality = placeMark.locality
                let administration = placeMark.administrativeArea
                
                let favLocation = FavouriteLocations(name: name,
                                                     locality: locality,
                                                     sublocality: subLocality,
                                                     administrativeArea: administration,
                                                     latitude: coordinates?.latitude,
                                                     longitude: coordinates?.longitude)
                
                completion(favLocation)
            }
        }
    }
}

struct FavouriteLocations {
    var name: String?
    var locality: String?
    var sublocality: String?
    var administrativeArea: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
}
