//
//  Barbutton.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func create(image name: String,
                       target: AnyObject,
                       action: Selector) -> UIBarButtonItem {
        let image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        let barButton = UIBarButtonItem(image: image,
                               style: .plain ,
                               target: target,
                               action: action)
        return barButton
        
    }
}

