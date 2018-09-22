//
//  TableViewCell.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 14/4/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var ppLitreLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
/*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    */
    func configureCell(expense: Expense) {
        //prepare date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let dateStr = formatter.string(from: expense.expDate!)
        //prepate ppl
        let ppLitre = ((expense.expAmount / expense.expLitre) * 100).rounded() / 100
        //prepare vehicleinfo
        let vehicleInfo = String(expense.vehicle!.year) + " " + expense.vehicle!.brand! + " " + expense.vehicle!.model!
        
        //assign labels
        self.dateLabel.text = dateStr
        self.locationLabel.text = expense.location
        self.litreLabel.text = String(expense.expLitre) + " l"
        self.vehicleLabel.text = vehicleInfo
        self.ppLitreLabel.text = String(ppLitre) + "$/l"
        self.amountLabel.text = "$" + String(expense.expAmount)
    }
}
