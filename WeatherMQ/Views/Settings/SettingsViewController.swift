//
//  SettingsViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 02/02/21.
//

import UIKit

class SettingsViewController: UITableViewController {
    let settings = SettingsDB.shared
    @IBOutlet weak var segmentController: UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selected_unit_type =  settings.getUnits()
        switch selected_unit_type {
        case UnitsType.metric:
            segmentController?.selectedSegmentIndex = 0
        case UnitsType.imperial:
            segmentController?.selectedSegmentIndex = 1
        case UnitsType.standurd:
            segmentController?.selectedSegmentIndex = 2
        default:
            segmentController?.selectedSegmentIndex = 0
        }
    }
   @IBAction func backButtonAction() {
        self.navigationController?.dismiss(animated: true,
                                           completion: nil)
    }
    
    @IBAction func unitSettings(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 { // selected celsius
            settings.setUnit(for: UnitsType.metric)
        } else if index == 1 { // selected fahrenheit
            settings.setUnit(for: UnitsType.imperial)
        } else { // selected kelvin
            settings.setUnit(for: UnitsType.standurd)
        }
    }
 
    @IBAction func deleteAllBookmarks(sender: UIButton) {
        let alert = UIAlertController(title: AlertConstant.DBDelete.title,
                                      message: AlertConstant.DBDelete.message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default, handler: { (_) in
            CoreDataHelper.shared.deleteAllBookmarks()
        }))
        alert.addAction(UIAlertAction(title: "No",
                                      style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

