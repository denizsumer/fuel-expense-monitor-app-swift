//
//  EditExpenseViewController.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 14/4/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class EditExpenseViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var litreField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    let vehicles = CoreDataHandler.instance.getVehicles()
    
    public var expense: Expense!
    public var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFields()
        vehiclePicker.delegate = self
        vehiclePicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFields() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy HH:mm"
        dateLabel.text = formatter.string(from: expense.expDate!)
        locationField.text = expense.location!
        litreField.text = String(expense.expLitre)
        amountField.text = String(expense.expAmount)
        vehiclePicker.selectedRow(inComponent: index)
    }
    
    func initExpense(expense: Expense, index: Int) {
        self.expense = expense
        self.index = index
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard validateFields() else {return}
        let result = CoreDataHandler.instance.editExpense(index: index, location: locationField.text!, litre: litreField.text!, amount: amountField.text!, vehicle: "TODO")
        if(result)
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateFields() -> Bool {
        if(locationField.text == "" || litreField.text == "" || amountField.text == "") {
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

extension EditExpenseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(vehicles[row].year) + " " + vehicles[row].brand!
    }
}
