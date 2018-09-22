//
//  AddVehicleViewController.swift
//  Fuel Mate
//
//  Created by swin on 5/7/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {
    
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var tankCapacityField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard validateFields() else {return}
        let result = CoreDataHandler.instance.addVehicle(brand: brandField.text!, model: modelField.text!, tankCapacity: tankCapacityField.text!, year: yearField.text!)
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
        print(msg)
        errorLabel.text = msg
        errorLabel.isHidden = false;
    }
}
