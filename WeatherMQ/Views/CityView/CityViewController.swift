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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityViewModel.delegate = self
        //homeViewModel.fetchLocation(with: )
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let latitude = self.favouriteLocation?.latitude,
              let longitude = self.favouriteLocation?.longitude else { return  }
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.cityViewModel.fetchLocation(with: location)
        self.cityViewModel.fecthWeather(for: location)
    }
    
    
   @IBAction func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CityViewController: LocationResponseDelegate {
    
    func didRecieved(location: Location) {
        Queue.main {
            self.dateLabel?.text = location.date
            self.placeLable?.text = location.locality
        }
    }
    
    func didFailed(with error: String) {
        
    }
    
    func didRecieved(weather: WeatherMesures) {
        Queue.main {
            self.temperatureLabel?.text = weather.temp
            self.humidityLabel?.text = weather.humidity
            self.pressureLabel?.text = weather.pressure
            self.windLabel?.text = weather.wind_speed
        }
    }
}



class CityViewModel {
    var delegate: LocationResponseDelegate?
    
    func fetchLocation(with coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let long = coordinate.longitude
        let geocoder = GeoCoderService.shared
        geocoder.geocode(latitude: lat,
                          longitude: long) { placeMark in
            
            let location = Location(date: Date.today,
                                    name: placeMark?.name,
                                    locality: placeMark?.locality,
                                    subLocality: placeMark?.subLocality,
                                    administration: placeMark?.administrativeArea)
            
            self.delegate?.didRecieved(location: location)
        }
    }
    
    
    func fecthWeather(for coordinates: CLLocationCoordinate2D) {
        let weaterService = WeatherService.shared
        
        weaterService.fetch(for: coordinates) { (result) in
            switch result {
            case .success(let weather):
                
                guard let temp = weather.current?.temp,
                      let hummidity_val = weather.current?.humidity,
                      let pressure_val = weather.current?.pressure,
                      let wind_val = weather.current?.wind_speed
                else { return }
               
                let temperature = temp.rounded().clean + "° C"
                let humidity = hummidity_val.rounded().clean + " rh"
                let pressure = pressure_val.rounded().clean + " kPa"
                let wind = wind_val.rounded().clean + " mph"
                let weatherMeasure = WeatherMesures(temp: temperature,
                                             wind_speed: wind,
                                             humidity: humidity,
                                             pressure: pressure)
                self.delegate?.didRecieved(weather: weatherMeasure)
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailed(with: error.localizedDescription)
            }
        }
    }
}
