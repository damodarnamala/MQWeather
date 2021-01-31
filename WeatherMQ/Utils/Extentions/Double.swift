//
//  Double.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(self)
    }
}
