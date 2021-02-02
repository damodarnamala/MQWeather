//
//  Database.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreData
import UIKit

struct CoreDataHelper {
    static let shared = CoreDataHelper()
    let context = CoreDataHelper.context

    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()
    
    func insert(favourite: FavouriteLocations) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Favourite", into: context) as? Favourite
        item?.name = favourite.name
        item?.locality = favourite.locality
        item?.subLocality = favourite.sublocality
        item?.administrativeArea = favourite.administrativeArea
        item?.lat = favourite.latitude?.clean
        item?.long = favourite.longitude?.clean
       
        do {
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetch() -> [FavouriteLocations]{
        var favLocations = [FavouriteLocations]()
        

        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        let fetchedItems = try! context.fetch(fetchRequest)
        for item in fetchedItems {
            
            let fav = FavouriteLocations(name: item.name,
                                         locality: item.locality,
                                         sublocality: item.subLocality,
                                         administrativeArea: item.administrativeArea,
                                         latitude: item.lat?.toDouble(),
                                         longitude: item.long?.toDouble())
            favLocations.append(fav)
        }
        return favLocations
    }
    
    func delete(where location: FavouriteLocations) {
        guard let name = location.name, let locality = location.locality else { return }
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name==%@", name, locality)
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        do {
            try context.save() // <- remember to put this :)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllBookmarks() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
            NotificationCenter.default.post(name: .NSManagedObjectContextObjectsDidChange, object: nil)
        }
        catch {
            print ("There was an error")
        }
    }
}

extension String {
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
       if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
     }
}
