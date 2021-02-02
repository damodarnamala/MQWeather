//
//  Loader.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 02/02/21.
//

import Foundation
import UIKit


class LoaderView: UIView {
    static let shared = LoaderView()
    
    lazy var spinner : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()

    lazy var centerView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
        self.addSubview(centerView)
        self.centerView.addSubview(spinner)
        
        self.centerView.centerXAnchor(equalTo: view.centerXAnchor)
        self.centerView.centerYAnchor(equalTo: view.centerYAnchor)
        self.centerView.heightAnchor(equalTo: 84)
        self.centerView.widthAnchor(equalTo: 84)
        
        centerView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.65)
        centerView.layer.cornerRadius = 8
        self.spinner.centerXAnchor(equalTo: view.centerXAnchor)
        self.spinner.centerYAnchor(equalTo: view.centerYAnchor)
        self.spinner.heightAnchor(equalTo: 64)
        self.spinner.widthAnchor(equalTo: 64)

    }
    
    func dismiss() {
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        self.centerView.removeFromSuperview()
        self.removeFromSuperview()
    }
}
