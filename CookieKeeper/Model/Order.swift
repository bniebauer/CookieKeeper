//
//  Order.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import Foundation
import SQLite3

class Order: Identifiable, Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case id, customer, selection, payment, paid, delivered, total
    }
    
    var id: UUID
    @Published var customer: Customer
    @Published var selection: [String:Int] = [String:Int]()
    @Published var payment: PaymentType = .Cash
    @Published var paid: Bool = false
    @Published var delivered: Bool = false
    @Published var total: Int
    
    init() {
        self.id = UUID()
        self.customer = Customer()
        self.total = 0
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        customer = try container.decode(Customer.self, forKey: .customer)
        selection = try container.decode([String: Int].self, forKey: .selection)
        payment = try container.decode(PaymentType.self, forKey: .payment)
        paid = try container.decode(Bool.self, forKey: .paid)
        delivered = try container.decode(Bool.self, forKey: .delivered)
        total = try container.decode(Int.self, forKey: .total)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(customer, forKey: .customer)
        try container.encode(selection, forKey: .selection)
        try container.encode(payment, forKey: .payment)
        try container.encode(delivered, forKey: .delivered)
        try container.encode(paid, forKey: .paid)
        try container.encode(total, forKey: .total)
        
    }
    
    func getTotal(_ cookies: [Cookie]) -> Int {
        var newTotal = 0
        self.selection.forEach { (cookieName, numOfBoxes) in
            if let cookie = cookies.first(where: { $0.name == cookieName}) {
                newTotal += cookie.price * numOfBoxes
            }
        }
        
        return newTotal
    }
}

extension Order {
    
    static let testOrder: Order = Order()
    static let testOrderCollection: [Order] = [
        Order(),
        Order(),
        Order()
    ]
}
