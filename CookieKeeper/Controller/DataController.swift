//
//  DataController.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 3/7/21.
//

import Foundation

class DataController: ObservableObject {
    @Published var orders: [Order]
    @Published var customers: [Customer]
    
    init() {
        self.orders = [Order]()
        self.customers = [Customer]()
    }
    
}
