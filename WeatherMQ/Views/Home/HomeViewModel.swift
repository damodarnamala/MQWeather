//
//  HomeViewModel.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import CoreLocation

protocol HomeViewDlegate {
    func viewWillAppreare()
}

class HomeViewModel: HomeViewDlegate {

    var databaseManager: CoreDataHelper?
    var tableHeadeader: String?
    
    var savedLocations = ObservableObject<[FavouriteLocations]>([])
       
    init(databaseManager: CoreDataHelper = CoreDataHelper.shared) {
        self.databaseManager = databaseManager
    }
    
    func viewWillAppreare() {
        guard let saved = self.databaseManager?.fetch() else { return }
        Queue.main { [weak self] in
            self?.savedLocations.value = saved
        }
    }
    
    func headerTitle() ->  String {
       return self.savedLocations.value.count >  0
        ? Constants.savedHeaderTitle
        : Constants.emptyHeaderTitle
    }
}

