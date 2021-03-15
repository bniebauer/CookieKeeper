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
    @Binding var newOrder: Order
    @Binding var isShowing: Bool
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
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
                        destination: CookieListView(),
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
                    Text("$\(String(format: "%.2f",newOrder.getTotal(cookies: cookies)))")
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
        OrderEditView(newOrder: .constant(testOrder), isShowing: .constant(true))
            .environmentObject(DataController())
    }
}
