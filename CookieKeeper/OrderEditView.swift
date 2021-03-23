//
//  OrderEditView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/1/21.
//

import SwiftUI

struct OrderEditView: View {
    @EnvironmentObject var dataController: DataController
    @State var selectedPayment = Order.PaymentType.Cash
    @State var selectedCustomer: Customer = Customer()
    @State var newOrder = Order()
    @Binding var isShowing: Bool
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Customer")) {
                    Picker("Customer", selection: $selectedCustomer) {
                        ForEach(0..<dataController.customers.count) {
                            Text("\(dataController.customers[$0].description)").tag(dataController.customers[$0])
                        }
                    }
                }
                Section(header: Text("Cookie")) {
                    NavigationLink(
                        destination: CookieListView(CookieSelection: $newOrder.selection),
                        label: {
                            Text("Cookie Selection")
                    })
                }
                
                HStack {
                    Text("Number of boxes:")
                    Spacer()
                    Text("\(newOrder.totalBoxes)")
                }
                HStack {
                    Text("Amount Due:")
                    Spacer()
                    Text("$\(String(format: "%.2f",newOrder.total))")
                }
                Picker("Payment Method", selection: $selectedPayment) {
                    Text("Cash").tag(Order.PaymentType.Cash)
                    Text("Check").tag(Order.PaymentType.Check)
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("New Order")
            .navigationBarItems(leading: Button("Cancel") {
                isShowing = false
            }, trailing: Button("Done") {
                // create new order object
                newOrder.customer = selectedCustomer
                newOrder.payment = selectedPayment
                
                dataController.orders.append(newOrder)
                // append to order array
                isShowing = false
            })
        }
        
    }
}

struct OrderEditView_Previews: PreviewProvider {
    static var testOrder = Order.testOrder
    static var previews: some View {
        OrderEditView(isShowing: .constant(true))
            .environmentObject(DataController())
    }
}
