//
//  ContentView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var customers: [Customer]
    var body: some View {
        TabView {
            CustomerTab(customers: $customers)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Customers")
                }
            OrdersTab(customers: $customers)
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Orders")
                }
        }
    }
}

struct CustomerTab: View {
    @Binding var customers: [Customer]
    var body: some View {
        CustomerListView(customers: $customers)
    }
}

struct OrdersTab: View {
    @Binding var customers: [Customer]
    @State var orders: [Order] = Order.testOrderCollection
    var body: some View {
        OrderListView(orders: $orders, customers: $customers)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let customer = Customer.testCollection
    static var previews: some View {
        ContentView(customers: .constant(customer))
    }
}
