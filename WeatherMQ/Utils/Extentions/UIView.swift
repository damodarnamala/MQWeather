//
//  UIView.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import UIKit

class RoundedView: UIView {
    
    convenience override init(frame: CGRect) {
        self.init();
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        layer.masksToBounds = false
        layer.cornerRadius = 4
    }
}


