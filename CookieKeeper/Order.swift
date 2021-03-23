//
//  Order.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import Foundation
import SQLite3

class Order: Identifiable, Codable {
    var id: UUID
    var customer: Customer
    var selection: [String:Int] = [String:Int]()
    var payment: PaymentType = .Cash
    var paid: Bool = false
    var delivered: Bool = false
    var total: Int = 0
    
    init() {
        self.id = UUID()
        self.customer = Customer()
    }
    
    var totalBoxes: Int {
        var tally: Int = 0
        for numBoxes in selection.values {
            tally += numBoxes
        }
        return tally
    }
    
    enum PaymentType: String, CaseIterable, Codable {
        case Cash = "Cash"
        case Check = "Check"
    }
}

class NewOrder: Order, ObservableObject {
    @Published var newCustomer: Customer = Customer()
}

extension Order {
    
    static let testOrder: Order = Order()
    static let testOrderCollection: [Order] = [
        Order(),
        Order(),
        Order()
    ]
}
