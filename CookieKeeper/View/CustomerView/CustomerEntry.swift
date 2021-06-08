//
//  CustomerEntry.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct CustomerEntry: View {
    @Binding var customer: Customer
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            List {
                TextField("First Name", text: $customer.firstName)
                TextField("Last Name", text: $customer.lastName)
                TextField("Phone Number", text: $customer.phoneNumber)
                TextField("Email", text: $customer.email)
            }
        }
    }
}

struct CustomerEntry_Previews: PreviewProvider {
    static var testCustomerNew: Customer = Customer()
    static var previews: some View {
        CustomerEntry(customer: .constant(testCustomerNew), isShowing: .constant(true))
    }
}
