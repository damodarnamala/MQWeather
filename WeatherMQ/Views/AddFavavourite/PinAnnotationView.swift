//
//  PinAnnotationView.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import MapKit

class PinAnnotationView: MKPinAnnotationView {
    
    static let identifier = "PinAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    convenience init(frame: CGRect) {
        self.init(annotation: nil, reuseIdentifier: nil);
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 24, height: 32)
        btn.setImage(UIImage(named: "icons_delete"), for: .normal)
        self.rightCalloutAccessoryView = btn
    }
}
