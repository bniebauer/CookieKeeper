//
//  ContentView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CustomerTab()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Customers")
                }
            OrdersTab()
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Orders")
                }
        }
    }
}

struct CustomerTab: View {
    @State var customers: [Customer] = Customer.testCollection
    var body: some View {
        CustomerListView(customers: $customers)
    }
}

struct OrdersTab: View {
    @State var orders: [Order] = Order.testOrderCollection
    var body: some View {
        OrderListView(orders: $orders)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
