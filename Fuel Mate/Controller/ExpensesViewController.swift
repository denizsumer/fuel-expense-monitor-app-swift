//
//  ExpensesViewController.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 14/4/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {
    @IBOutlet weak var expTable: UITableView!
    var expenses: [Expense] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expTable.delegate = self
        expTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expenses = CoreDataHandler.instance.getExpenses()
        expTable.reloadData()
        SearchableContentHandler.instance.setupSearchableContent()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        if(CoreDataHandler.instance.getVehicles().count < 1) {
            displayNoVehicleAlertController()
            return
            
        }
        guard let addExpenseViewController = storyboard?.instantiateViewController(withIdentifier: "AddExpenseViewController") else {return}
        present(addExpenseViewController, animated: true, completion: nil)
    }
    
    func editExpense(atIndexPath: IndexPath) {
        guard let editExpenseViewController = storyboard?.instantiateViewController(withIdentifier: "EditExpenseViewController") as? EditExpenseViewController else {return}
        editExpenseViewController.initExpense(expense: expenses[atIndexPath.row], index: atIndexPath.row)
        present(editExpenseViewController, animated: true, completion: nil)
    }
}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as? ExpenseCell else {
            return UITableViewCell()
        }
        let expense = expenses[indexPath.row]
        cell.configureCell(expense: expense)
        
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
            self.displayDeleteExpenseAlertController(tableView, indexPath: indexPath)
        }
        deleteAction.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        let editAction = UITableViewRowAction(style: .normal, title: "EDIT") { (rowAction, indexPath) in        self.editExpense(atIndexPath: indexPath)
            tableView.reloadData()
        }
        editAction.backgroundColor = UIColor(red: 0, green: 0.25020, blue: 0.25098, alpha: 1)
        return [deleteAction, editAction]
    }
    
    func displayDeleteExpenseAlertController(_ tableView: UITableView, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete Expense", message: "Please confirm the delete this expense", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let result = CoreDataHandler.instance.removeExpense(atIndexPath: indexPath)
            if(result) {
                self.expenses = CoreDataHandler.instance.getExpenses()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayNoVehicleAlertController() {
        let alertController = UIAlertController(title: "Cannot Add Expense", message: "Please add a vehicle first to add an expense", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
