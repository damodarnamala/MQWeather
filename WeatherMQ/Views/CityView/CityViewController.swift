//
//  CityViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController {
    @IBOutlet weak var placeLable: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var windLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    @IBOutlet weak var pressureLabel: UILabel?
    
    
    var favouriteLocation:  FavouriteLocations?
    
    lazy var cityViewModel : CityViewModel = {
        let viewModel = CityViewModel()
        return viewModel
    }()
    
    lazy var loadingView : LoaderView = {
        let viewModel = LoaderView()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityViewModel.delegate = self
        let barButtutton = UIBarButtonItem.create(image: Image.back,
                                                  target: self,
                                                  action: #selector(backButtonAction))
        self.navigationItem.leftBarButtonItem = barButtutton
        loadingView.show(in: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let latitude = self.favouriteLocation?.latitude,
              let longitude = self.favouriteLocation?.longitude else { return  }
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.cityViewModel.fetchLocation(with: location)
        self.cityViewModel.fecthWeather(for: location)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loadingView.dismiss()
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension CityViewController: LocationResponseDelegate {
    
    func didRecieved(location: Location) {
        Queue.main { [weak self] in
            self?.dateLabel?.text = location.date
            self?.placeLable?.text = location.locality
        }
    }
    
    func didFailed(with error: String) {
        loadingView.dismiss()
    }
    
    func didRecieved(weather: WeatherMesures) {
        Queue.main { [weak self] in
            self?.loadingView.dismiss()
            self?.temperatureLabel?.text = weather.temp
            self?.humidityLabel?.text = weather.humidity
            self?.pressureLabel?.text = weather.pressure
            self?.windLabel?.text = weather.wind_speed
        }
    }
}
