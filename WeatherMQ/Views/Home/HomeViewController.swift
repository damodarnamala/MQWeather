//
//  ViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var placeLable: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?

        
    lazy var homeViewModel : HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.delegate = self
        homeViewModel.viewWillAppreare()
    }
    
}


extension HomeViewController: LocationResponseDelegate {
    
    func didRecieved(location: Location) {
        Queue.main {
            self.dateLabel?.text = location.date
            self.placeLable?.text = location.locality
        }
    }
    
    func didFailed(with error: String) {
        
    }
    
    func didRecieved(weather: WeatherResponse) {
        guard let temperature = weather.current?.temp else { return }
        
        Queue.main {
            self.temperatureLabel?.text = "\(temperature.rounded().clean)° C"
        }
    }
}

