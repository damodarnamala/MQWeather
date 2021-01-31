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
    @IBOutlet weak var windLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    @IBOutlet weak var pressureLabel: UILabel?
    @IBOutlet weak var tableFavourites: UITableView?
    @IBOutlet weak var fbButton: UIBarButtonItem!
    
    var favourites = ["Home", "Favourite"]
    
    lazy var homeViewModel : HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableFavourites?.tableFooterView = UIView()
        
        
        // Set Image for bar button
        let buttonSetting: UIButton = UIButton(type: .custom)
        buttonSetting.setImage(UIImage(named: "icon_settings"), for: .normal)
        buttonSetting.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let barButtonSetting = UIBarButtonItem(customView: buttonSetting)
        
        let buttonLocation: UIButton = UIButton(type: .custom)
        buttonLocation.addTarget(self, action: #selector(showMapView), for: .touchUpInside)
        buttonLocation.setImage(UIImage(named: "icon_location"), for: .normal)
        buttonLocation.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let barButtonLocation = UIBarButtonItem(customView: buttonLocation)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItems = [barButtonSetting, barButtonLocation]
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//        imageView.contentMode = .scaleAspectFit
//        
//        let image = UIImage(named: "nav_icon")
//        imageView.image = image
//        navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.delegate = self
        homeViewModel.viewWillAppreare()
    }
    
    @objc func showMapView() {
        let favourites = FavouriteViewController.instance()
        let navController = UINavigationController(rootViewController: favourites)
        self.navigationController?.present(navController, animated: true, completion: nil)
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
    
    func didRecieved(weather: WeatherMesures) {
        Queue.main {
            self.temperatureLabel?.text = weather.temp
            self.humidityLabel?.text = weather.humidity
            self.pressureLabel?.text = weather.pressure
            self.windLabel?.text = weather.wind_speed
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FavouriteCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = "Bangalore"
        cell.detailTextLabel?.text = "Koramangala"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved locations"
    }
}


class FavouriteCell: UITableViewCell, Reusable {
    
    
}


class AddFavouriteCell: UITableViewCell, Reusable {
    @IBOutlet weak var lbl: UILabel?
    
}

