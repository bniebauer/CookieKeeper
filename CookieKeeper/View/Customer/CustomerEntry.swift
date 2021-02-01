//
//  CustomerEntry.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct CustomerEntry: View {
    @Binding var customer: Customer
    var body: some View {
        VStack {
            List {
                Text("First Name")
                TextField("First Name", text: $customer.firstName)
                Text("Last Name")
                TextField("Last Name", text: $customer.lastName)
                Text("Phone Number")
                TextField("Phone Number", text: $customer.phoneNumber)
                Text("Email")
                TextField("Email", text: $customer.email)
            }
        }
    }
}

struct CustomerEntry_Previews: PreviewProvider {
    static var testCustomerNew: Customer = Customer()
    static var previews: some View {
        CustomerEntry(customer: .constant(testCustomerNew))
    }
}
