//
//  EditVehicleViewController.swift
//  Fuel Mate
//
//  Created by swin on 5/7/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class EditVehicleViewController: UIViewController {
    
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var tankCapacityField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    public var vehicle: Vehicle!
    public var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFields() {
        brandField.text = vehicle.brand!
        modelField.text = vehicle.model
        yearField.text = String(vehicle.year)
        tankCapacityField.text = String(vehicle.tankCapacity)
    }
    
    func initVehicle(vehicle: Vehicle, index: Int) {
        self.vehicle = vehicle
        self.index = index
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard validateFields() else {return}
        let result = CoreDataHandler.instance.editVehicle(index: index, brand: brandField.text!, model: modelField.text!, tankCapacity: tankCapacityField.text!, year: yearField.text!)
        if(result)
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateFields() -> Bool {
        if(brandField.text == "" || modelField.text == "" || yearField.text == "" || tankCapacityField.text == "") {
            displayErrorMessage(msg: "All fields must be filled!")
            return false
        }
        return true
    }
    
    func displayErrorMessage(msg: String) {
        errorLabel.text = msg
        errorLabel.isHidden = false;
    }
    
}
