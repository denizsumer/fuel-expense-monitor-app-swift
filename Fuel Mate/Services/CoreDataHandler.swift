//
//  CoreDataHandler.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 7/5/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import UIKit
import CoreData
import CoreSpotlight
import MobileCoreServices

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class CoreDataHandler {
    static let instance = CoreDataHandler()
    var expenses = [Expense]()
    var vehicles = [Vehicle]()
    
    func getExpenses() -> [Expense] {
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        do {
            expenses = try managedContext!.fetch(fetchRequest)
            print("Expenses data successfully fetched")
        } catch {
            debugPrint("Expenses data could not fetched: \(error.localizedDescription)")
        }
        return expenses
    }
    
    func addExpense(date: Date, location: String, litre: String, amount: String, vehicleIndex: Int) -> Bool {
        print("test1")
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        print("test2")
        let expense = Expense(context: managedContext)
        print("test3")
        expense.expDate = date
        expense.location = location
        expense.expLitre = Double(litre)!
        expense.expAmount = Double(amount)!
        print("test4")
        vehicles[vehicleIndex].addToExpenses(expense)
        do {
            print("test5")
            try
            managedContext.save()
            print("test6")
            print("Expense added successfully")
            return true
        } catch {
            print("test7")
            debugPrint("Expense could not added: \(error.localizedDescription)")
            return false
        }
    }
    
    func editExpense(index: Int, location: String, litre: String, amount: String, vehicle: String) -> Bool {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        let request: NSFetchRequest<Expense> = NSFetchRequest(entityName: "Expense")
        do {
            let expenses = try managedContext.fetch(request)
            expenses[index].setValue(location, forKey: "location")
            expenses[index].setValue(Double(litre)!, forKey: "expLitre")
            expenses[index].setValue(Double(amount)!, forKey: "expAmount")
            try managedContext.save()
            print("Expense edited successfully")
            return true
        } catch {
            debugPrint("Expense could not edited: \(error.localizedDescription)")
            return false
        }
    }
    
    func removeExpense(atIndexPath indexPath: IndexPath) -> Bool {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        managedContext.delete(expenses[indexPath.row])
        do {
            try managedContext.save()
            print("Expense removed successfully")
            return true
        } catch {
            debugPrint("Expense could not removed: \(error.localizedDescription)")
            return false
        }
    }
    
    func getVehicles() -> [Vehicle] {
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        do {
            vehicles = try managedContext!.fetch(fetchRequest)
            print("Vehicles data successfully fetched")
        } catch {
            debugPrint("Vehicles data could not fetched: \(error.localizedDescription)")
        }
        return vehicles
    }
    
    func addVehicle(brand: String, model: String, tankCapacity: String, year: String) -> Bool{
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        let vehicle = Vehicle(context: managedContext)
        vehicle.brand = brand
        vehicle.model = model
        vehicle.tankCapacity = Double(tankCapacity)!
        vehicle.year = Int16(year)!
        do {
            try
                managedContext.save()
            print("Vehicle added successfully")
            return true
        } catch {
            debugPrint("Vehicle could not added: \(error.localizedDescription)")
            return false
        }
    }
    
    func editVehicle(index: Int, brand: String, model: String, tankCapacity: String, year: String) -> Bool {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        let request: NSFetchRequest<Vehicle> = NSFetchRequest(entityName: "Vehicle")
        do {
            let vehicles = try managedContext.fetch(request)
            vehicles[index].setValue(brand, forKey: "brand")
            vehicles[index].setValue(model, forKey: "model")
            vehicles[index].setValue(Int16(year)!, forKey: "year")
            vehicles[index].setValue(Double(tankCapacity)!, forKey: "tankCapacity")
            try managedContext.save()
            print("Vehicle edited successfully")
            return true
        } catch {
            debugPrint("Vehicle could not edited: \(error.localizedDescription)")
            return false
        }
    }
    
    func removeVehicle(atIndexPath indexPath: IndexPath) -> Bool {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return false}
        managedContext.delete(vehicles[indexPath.row])
        do {
            try managedContext.save()
            print("Vehicle removed successfully")
            return true
        } catch {
            debugPrint("Vehicle could not removed: \(error.localizedDescription)")
            return false
        }
    }
}
