//
//  Date.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import UIKit

extension Date {
    static var today: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: today)
    }
    
    func date(with formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: self)
    }
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: self)
    }

    static func after(days: Int) -> TimeInterval {
        var dayComponent    = DateComponents()
        dayComponent.day    = days // For removing one day (yesterday): -1
        let theCalendar     = Calendar.current
        guard let date = theCalendar.date(byAdding: dayComponent,
                                          to: Date())
        else { return Date().timeIntervalSince1970}
        return date.timeIntervalSince1970
    }
}
