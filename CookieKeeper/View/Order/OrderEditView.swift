//
//  OrderEditView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/1/21.
//

import SwiftUI

struct OrderEditView: View {
    @Binding var order: Order
    @Binding var customers: [Customer]
    @State var selectedPayment = Order.PaymentType.Cash
    @State var selectedCustomer: Customer = Customer()
    var body: some View {
        List{
            Section(header: Text("Customer")) {
                Picker("Customer", selection: $order.customer) {
                    ForEach(0..<customers.count) {
                        Text("\(self.customers[$0].description)").tag(self.customers[$0])
                    }
                }
                if selectedCustomer.id != 0 {
                    CustomerRowView(customer: selectedCustomer)
                }
            }
            Section(header: Text("Cookies")) {
                
            }
            HStack {
                Text("Number of boxes:")
                Spacer()
                Text("\(order.selection.count)")
            }
            HStack {
                Text("Amount Due:")
                Spacer()
                Text("$\(String(format: "%.2f",order.total))")
            }
            Picker("Payment Method", selection: $selectedPayment) {
                Text("Cash").tag(Order.PaymentType.Cash)
                Text("Check").tag(Order.PaymentType.Check)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct OrderEditView_Previews: PreviewProvider {
    static var testOrder = Order.testOrder
    static var previews: some View {
        OrderEditView(order: .constant(testOrder),
                      customers: .constant(Customer.testCollection))
    }
}
