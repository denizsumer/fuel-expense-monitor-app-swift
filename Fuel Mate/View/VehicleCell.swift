//
//  VehicleCell.swift
//  Fuel Mate
//
//  Created by swin on 5/7/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class VehicleCell: UITableViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tankCapacityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(vehicle: Vehicle) {
        //assign labels
        self.brandLabel.text = vehicle.brand
        self.modelLabel.text = vehicle.model
        self.yearLabel.text = String(vehicle.year)
        self.tankCapacityLabel.text = String(vehicle.tankCapacity)
    }
    
}
