//
//  Order.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import Foundation

struct Order: Codable, Identifiable {
    var id: Int = 0
    var customer: Customer = Customer()
    var selection: [Cookie] = []
    var payment: PaymentType = .Cash
    var paid: Bool = false
    var delivered: Bool = false
    
    var total: Double {
        var tally: Double = 0
        selection.forEach { cookie in
            tally += cookie.price
        }
        return tally
    }
    
    enum PaymentType: String, CaseIterable, Codable {
        case Cash = "Cash"
        case Check = "Check"
    }
}

extension Order {
    static let testOrder: Order = Order(id: 1,
                                        customer: Customer.testCustomer1,
                                        selection: Cookie.cookieCollectionTest,
                                        payment: .Check,
                                        paid: true,
                                        delivered: false)
    static let testOrderCollection: [Order] = [
        Order(id: 1, customer: Customer.testCustomer1, selection: Cookie.cookieCollectionTest, payment: .Cash, paid: true, delivered: false),
        Order(id: 2, customer: Customer.testCustomer2, selection: Cookie.cookieCollectionTest, payment: .Check, paid: false, delivered: false),
        Order(id: 3, customer: Customer.testCustomer3, selection: Cookie.cookieCollectionTest, payment: .Check, paid: false, delivered: false)
    ]
}
