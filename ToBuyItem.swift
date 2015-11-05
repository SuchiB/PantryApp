//
//  ToBuyItem.swift
//  Pantry

import Foundation



var toByItm: ToBuyItem = ToBuyItem()

struct buyingItem {
    
    // var  itemID: Int
    // var detailItemID: Int = 0
    var itemName: String = ""
    var detailItemName: String = ""
    var detailItemCompleted: Bool
    
    
    
}

class ToBuyItem: NSObject{
    
    var buyingItems = [buyingItem]()
    
    func addDetailItem(itemName: String, detailItemName: String, detailItemCompleted: Bool){
        
        buyingItems.append(buyingItem(itemName: itemName, detailItemName: detailItemName, detailItemCompleted: detailItemCompleted))
        
    }
    
}
