//
//  Constants.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation

struct Constants {
    static var savedHeaderTitle = "Your bookmarks"
    static var emptyHeaderTitle = "No bookmarks saved yet, add by clicking on pin on top bar"
    static var settins = "You can set you preferences by changing the settings."
}



struct AlertConstant {
    struct DBDelete {
        static let title = "Warning !!"
        static let message = "Are you sure? would you like to delete all saved bookmarks."

    }
}

struct Image {
    static let settings = "icon_settings"
    static let pin = "icon_location"
    static let back = "icon_back"
}


struct DBKeys {
    static let firstLaunch = "first_launch"
    static let units = "units"
}


struct UnitsType {
    static let standurd = "standard"
    static let imperial = "imperial"
    static let metric = "metric"
}
