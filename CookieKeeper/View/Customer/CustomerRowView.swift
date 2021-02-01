//
//  CustomerRowView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct CustomerRowView: View {
    let customer: Customer
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text(customer.firstName)
                    Text(customer.lastName)
                }
                Text(customer.phoneNumber)
                Text(customer.email)
            }
        }
    }
}

struct CustomerRowView_Previews: PreviewProvider {
    static var testCustomerCurrent: Customer = Customer(id: 2, firstName: "Brenton", lastName: "Niebauer", phoneNumber: "724-316-5569", email: "b.niebauer@me.com")
    static var previews: some View {
        CustomerRowView(customer: testCustomerCurrent)
            .previewLayout(.fixed(width: 320, height: 60))
    }
}
