//
//  ViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableFavourites: UITableView?
    
    var favourites = [FavouriteLocations]()
    var searchResults = [FavouriteLocations]()

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.dimsBackgroundDuringPresentation = false
        definesPresentationContext = false
        sc.searchBar.placeholder = "Search"
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        
        // Make sure the that the search bar is visible within the navigation bar.
        sc.searchBar.sizeToFit()
        
        // Include the search controller's search bar within the table's header view.
        
        definesPresentationContext = true
        
        return sc
    }()
    
    
    lazy var homeViewModel : HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableFavourites?.tableHeaderView = searchController.searchBar
        self.tableFavourites?.tableFooterView = UIView()
        navigationBarSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDBUpdates()
    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        getDBUpdates()
    }
    
    func getDBUpdates() {
        self.homeViewModel.viewWillAppreare()
        self.homeViewModel.savedLocations.observe(on: self, observerBlock: { (locations) in
            self.favourites = locations
            self.tableFavourites?.reloadData()
        })
    }
    
    func navigationBarSetUp() {
        // Set Image for bar button
        
        let barbuttonSetting = UIBarButtonItem.create(image: Image.settings,
                                                      target: self,
                                                      action: #selector(showSettings))
        
        let showMapButton = UIBarButtonItem.create(image: Image.pin,
                                                   target: self,
                                                   action: #selector(showMapView))
        
        self.navigationItem.rightBarButtonItems = [barbuttonSetting, showMapButton]
        
    }
    
    @objc func showMapView() {
        let favourites = FavouriteViewController.instance()
        let navController = UINavigationController(rootViewController: favourites)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @objc func showSettings() {
        let settings = SettingsViewController.instance()
        let navController = UINavigationController(rootViewController: settings)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavouriteCell = tableView.dequeueReusableCell(for: indexPath)
        let favourite  = searchController.isActive ? searchResults[indexPath.row] : self.favourites[indexPath.row]
        cell.configure(with: favourite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.homeViewModel.headerTitle().capitalized
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityView: CityViewController = CityViewController.instance()
        cityView.favouriteLocation = self.favourites[indexPath.row]
        self.navigationController?.pushViewController(cityView, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            tableFavourites?.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        self.searchResults = self.favourites.filter({ fav -> Bool in
            let match = fav.name?.range(of: searchText, options: .caseInsensitive)
            // Return the tuple if the range contains a match.
            return match != nil
        })
    }
}
