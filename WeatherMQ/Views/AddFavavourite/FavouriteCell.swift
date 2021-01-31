//
//  FavouriteCell.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import UIKit

class FavouriteCell: UITableViewCell, Reusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with location: FavouriteLocations) {
        if let name = location.name,
           let locality = location.locality,
           let administrativeArea = location.administrativeArea {
            self.textLabel?.text = name
            self.detailTextLabel?.text = locality +  ", " + administrativeArea
        }
    }
}
