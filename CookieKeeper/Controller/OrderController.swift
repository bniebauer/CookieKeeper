//
//  OrderController.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 3/16/21.
//

import Foundation

class OrderController: ObservableObject {
    @Published var orders: [Order]
    
    init() {
        orders = []
        loadOrderData()
    }
    
    func saveOrderList() {
        OrderDataManager.SaveToFile(DataList: orders)
    }
    
    private func loadOrderData() {
        let dataReturn = OrderDataManager.LoadFromFile()
        if dataReturn.count > 0 {
            self.orders = dataReturn.map { $0 as! Order }
        } else {
            self.orders = []
        }
    }
}
