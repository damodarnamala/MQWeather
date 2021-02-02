//
//  SettingsDB.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 02/02/21.
//

import Foundation

class SettingsDB {
    static let shared = SettingsDB()
    let db = UserDefaults.standard
    func initialDBSettings() {
        guard let _ = db.value(forKey: DBKeys.firstLaunch) else {
            db.set(false, forKey: DBKeys.firstLaunch)
            db.set(UnitsType.metric, forKey: DBKeys.units)
            return
        }
    }
    
    func setUnit(for key: String) {
        db.set(key, forKey: DBKeys.units)
    }
    
    func getUnitsSymbol() -> String  {
        guard let unit = db.value(forKey: DBKeys.units) as? String else { return "°C"}
        switch unit {
        case UnitsType.standurd:
            return "°K"
        case UnitsType.imperial:
            return "°F"
        case UnitsType.metric:
            return "°C"
        default:
            return "°C"
        }
    }
    
    func getUnits() -> String  {
        guard let unit = db.value(forKey: DBKeys.units) as? String else { return "metric"}
        return unit
    }

    
}
