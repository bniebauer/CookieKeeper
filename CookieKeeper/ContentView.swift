//
//  ContentView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    var body: some View {
        TabView {
            CustomerListView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Customers")
                }
            OrderListView(orders: $dataController.orders)
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Orders")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let customer = Customer.testCollection
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(DataController())
            
            ContentView()
                .environmentObject(DataController())
                .environment(\.colorScheme, .dark)
        }
    }
}
