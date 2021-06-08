//
//  OrderEditView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/1/21.
//

import SwiftUI

struct OrderEditView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var newOrder = Order()
    @Binding var isShowing: Bool
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Customer")) {
                    Picker("Customer", selection: $newOrder.customer) {
                        ForEach(0..<dataController.customers.count) {
                            Text("\(dataController.customers[$0].description)").tag(dataController.customers[$0])
                        }
                    }
                }
               Section(header: Text("Cookie")) {
                    NavigationLink(
                        destination: CookieListView(cookies: cookies, CookieSelection: $newOrder.selection ),
                        label: {
                            Text("Cookie Selection")
                        }
                    )
                    // Add a button to test the value of total
                }
                
                HStack {
                    Text("Number of boxes:")
                    Spacer()
                    Text("\(newOrder.totalBoxes)")
                }
                HStack {
                    Text("Amount Due:")
                    Spacer()
                    Text("$\(newOrder.getTotal(cookies))")
                }
                Picker("Payment Method", selection: $newOrder.payment) {
                    Text("Cash").tag(Order.PaymentType.Cash)
                    Text("Check").tag(Order.PaymentType.Check)
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("New Order")
            .navigationBarItems(leading: Button("Cancel") {
                isShowing = false
            }, trailing: Button("Done") {
                newOrder.total = newOrder.getTotal(cookies)
                dataController.orders.append(newOrder)
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
