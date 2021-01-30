//
//  UIViewController+extention.swift
//  MQTest
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//


import Foundation
import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIViewController {
    static func instance<T: UIViewController>() -> T {
        let name = String(describing: self)
        
        guard let controller = UIStoryboard.main.instantiateViewController(withIdentifier: name) as? T else {
            fatalError("ViewController '\(name)' is not of the expected class \(T.self).")
        }
        return controller
        
    }
}


