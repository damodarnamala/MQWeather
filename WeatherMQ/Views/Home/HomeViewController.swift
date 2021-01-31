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
    
    var favourites = [FavouriteLocations]()
    var tableHeaderNamae = "Saved Locations"
    
    lazy var homeViewModel : HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableFavourites?.tableFooterView = UIView()

        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)

        
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
        self.navigationItem.rightBarButtonItems = [barButtonSetting, barButtonLocation]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.delegate = self
        homeViewModel.viewWillAppreare()
        fetchLocationsFromDB()

    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        fetchLocationsFromDB()
    }
    
    func fetchLocationsFromDB () {
        self.favourites = CoreDataHelper.shared.fetch()
        
        Queue.main {
            if self.favourites.isEmpty   {
                self.tableHeaderNamae = "You have not saved any locations yet."
            }
            self.tableFavourites?.reloadData()
        }
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
        let fav: FavouriteLocations = self.favourites[indexPath.row]
        
        if let name = fav.name,
              let locality = fav.locality,
              let administrativeArea = fav.administrativeArea {
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = locality +  ", " + administrativeArea

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeaderNamae
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let databse = CoreDataHelper.shared
            databse.delete(where: self.favourites[indexPath.row])
        }
    }

}


class FavouriteCell: UITableViewCell, Reusable {
    
    
}


class AddFavouriteCell: UITableViewCell, Reusable {
    @IBOutlet weak var lbl: UILabel?
    
}

