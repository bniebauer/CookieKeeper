//
//  Customer.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import Foundation
import SQLite3

struct Customer: Codable, Identifiable, Equatable {
    var id: Int = 1
    var firstName: String = ""
    var lastName: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var phoneNumber: String = ""
    var email: String = ""
}

extension Customer {
    static let dbController = DbController()
    static let testCustomer1: Customer = Customer(id: 1, firstName: "Brenton", lastName: "Niebauer", street: "123 Test Way", city: "Testville", state: "PA", zip: "12345", phoneNumber: "123-456-7890", email: "test@test.com")
    static let testCustomer2: Customer = Customer(id: 2, firstName: "Joy", lastName: "Travis", phoneNumber: "890-567-1234", email: "test2@test.com")
    static let testCustomer3: Customer = Customer(id: 3, firstName: "Theresa", lastName: "Greiner", phoneNumber: "456-321-9780", email: "test3@test.com")
    
    static let testCollection: [Customer] = [
        testCustomer1,
        testCustomer2,
        testCustomer3
    ]
}
