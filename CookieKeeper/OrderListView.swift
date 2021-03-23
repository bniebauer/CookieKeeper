//
//  OrderListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderListView: View {
    @State var isPresented = false
    @Binding var orders: [Order]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink(destination: OrderDetails(order: binding(for: order))) {
                        OrderRowView(order: binding(for: order))
                    }
                }.onDelete(perform: deleteOrder)
            }
            .navigationTitle("Order List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }, label:{
                        Image(systemName: "plus")
                    }).padding()
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                OrderEditView(isShowing: $isPresented)
            }
        }
    }
    
    private func binding(for order: Order) -> Binding<Order> {
        guard let orderIndex = orders.firstIndex(where: {$0.id == order.id }) else {
            fatalError("Could not find order in collection")
        }
        return $orders[orderIndex]
    }
    
    private func deleteOrder(at offset: IndexSet) {
        orders.remove(atOffsets: offset)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: .constant([Order]()))
    }
}
