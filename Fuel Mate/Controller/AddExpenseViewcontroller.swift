//
//  AddExpenseViewcontroller.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 14/4/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class AddExpenseViewcontroller: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var litreField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    let vehicles = CoreDataHandler.instance.getVehicles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateTime()
        vehiclePicker.delegate = self
        vehiclePicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy HH:mm"
        dateField.text = formatter.string(from: Date())
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard validateFields() else {return}
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy HH:mm"
        let date = formatter.date(from: dateField.text!)
        let result = CoreDataHandler.instance.addExpense(date: date!, location: locationField.text!, litre: litreField.text!, amount: amountField.text!, vehicleIndex: vehiclePicker.selectedRow(inComponent: 0))
        if(result)
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateFields() -> Bool {
        if(dateField.text == "" || locationField.text == "" || litreField.text == "" || amountField.text == "") {
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

extension AddExpenseViewcontroller: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(vehicles[row].year) + " " + vehicles[row].brand! + " " + vehicles[row].model!
    }
}

