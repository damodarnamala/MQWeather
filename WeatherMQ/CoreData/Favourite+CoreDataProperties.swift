//
//  Favourite+CoreDataProperties.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }


    @NSManaged public var administrativeArea: String?
    @NSManaged public var lat: String?
    @NSManaged public var locality: String?
    @NSManaged public var long: String?
    @NSManaged public var name: String?
    @NSManaged public var subLocality: String?

}
