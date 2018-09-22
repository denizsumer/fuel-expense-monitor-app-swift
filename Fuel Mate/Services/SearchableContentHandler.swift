//
//  SearchableContentHandler.swift
//  Fuel Mate
//
//  Created by DENIZ SUMER on 13/5/18.
//  Copyright © 2018 Deniz Sumer. All rights reserved.
//

import CoreSpotlight
import MobileCoreServices

class SearchableContentHandler {
    static let instance = SearchableContentHandler()
    
    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        var expenses = CoreDataHandler.instance.getExpenses()
        print("Total Expense : " + String(expenses.count))
        if(expenses.count == 0) {
            return
        }
        for i in 0...(expenses.count - 1) {
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            // Set the thumbnail
            
            // Set the expense location and date as title
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            let expDate = formatter.string(from: expenses[i].expDate!)
            let expenseInfo = expenses[i].location! + " on " + expDate
            searchableItemAttributeSet.title = expenseInfo
            
            // Set the vehicle brand, model and year as desc
            let vehicleInfo = "$" + String(expenses[i].expAmount) + " for " + String(expenses[i].vehicle!.year) + " " + expenses[i].vehicle!.brand! + " " + expenses[i].vehicle!.model!
            searchableItemAttributeSet.contentDescription = vehicleInfo
        
            // Set the keywords
            var keywords = [String]()
            keywords.append(expenseInfo)
            keywords.append(vehicleInfo)
            searchableItemAttributeSet.keywords = keywords
        
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "au.edu.swinburne.\(i)", domainIdentifier: "expenses", attributeSet: searchableItemAttributeSet)
        
            searchableItems.append(searchableItem)
        
            CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
                if error != nil {
                    print(error?.localizedDescription ?? "Error in SearchableContentHandler")
                }
            }
            print("Added in SpotLight : " + expenseInfo)
        }
    }
}
