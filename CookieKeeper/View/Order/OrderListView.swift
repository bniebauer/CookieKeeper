//
//  OrderListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderListView: View {
    @Binding var orders: [Order]
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink(destination: OrderDetails(order: binding(for: order))) {
                        OrderRowView(order: order)
                    }
                }
            }
            .navigationTitle("Order List")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "plus")
            })
        }
    }
    
    private func binding(for order: Order) -> Binding<Order> {
        guard let orderIndex = orders.firstIndex(where: {$0.id == order.id }) else {
            fatalError("Could not find order in collection")
        }
        return $orders[orderIndex]
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: .constant(Order.testOrderCollection))
    }
}
