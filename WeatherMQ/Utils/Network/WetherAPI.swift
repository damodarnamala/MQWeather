//
//  URLBuilder.swift
//  Mobiquity-Test
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//


import Foundation

enum WetherAPI: StringConvertable {
    case bookmarked(String,String)
    
    private var  baseUrl: String {
        return "https://api.openweathermap.org/data/2.5/onecall?"
    }
    
    private var  apppID: String {
        return "fae7190d7e6433ec3a45285ffcf55c86"
    }
    
    var url: String {
        switch self {
        case .bookmarked(let lat, let long):
            let string = baseUrl + "lat=\(lat)&lon=\(long)&units=metric&appid=\(apppID)"
            print(string)
            return string
        }
        
    }
    
    enum Units {
        case metric, imperial, standard
        var type: String {
            switch self {
            case .imperial:
                return "standard"
            case .standard:
                return "standard"
            case .metric:
                return "metric"
            }
        }
    }
}
