//
//  VehiclesViewController.swift
//  Fuel Mate
//
//  Created by swin on 5/7/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController {
    @IBOutlet weak var vehicleTable: UITableView!
    var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleTable.delegate = self
        vehicleTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vehicles = CoreDataHandler.instance.getVehicles()
        vehicleTable.reloadData()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let addVehicleViewController = storyboard?.instantiateViewController(withIdentifier: "AddVehicleViewController") as? AddVehicleViewController else {return}
        present(addVehicleViewController, animated: true, completion: nil)
    }
    
    func editVehicle(atIndexPath: IndexPath) {
        guard let editVehicleViewController = storyboard?.instantiateViewController(withIdentifier: "EditVehicleViewController") as? EditVehicleViewController else {return}
        editVehicleViewController.initVehicle(vehicle: vehicles[atIndexPath.row], index: atIndexPath.row)
        present(editVehicleViewController, animated: true, completion: nil)
    }
}

extension VehiclesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell") as? VehicleCell else {
            return UITableViewCell()
        }
        let vehicle = vehicles[indexPath.row]
        cell.configureCell(vehicle: vehicle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.displayAlertController(tableView, indexPath: indexPath)
        }
        deleteAction.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        let editAction = UITableViewRowAction(style: .normal, title: "EDIT") { (rowAction, indexPath) in        self.editVehicle(atIndexPath: indexPath)
            tableView.reloadData()
        }
        editAction.backgroundColor = UIColor(red: 0, green: 0.25020, blue: 0.25098, alpha: 1)
        return [deleteAction, editAction]
    }
    
    func displayAlertController(_ tableView: UITableView, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete Vehicle", message: "Please confirm the delete this vehicle - All expenses of this vehicle will be deleted too!", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let result = CoreDataHandler.instance.removeVehicle(atIndexPath: indexPath)
            if(result) {
                self.vehicles = CoreDataHandler.instance.getVehicles()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}




