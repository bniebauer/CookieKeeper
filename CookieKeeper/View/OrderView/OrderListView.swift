//
//  OrderListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderListView: View {
    @State var isPresented = false
    @State var orders: [Order]
    
    init() {
        // Get Order Data
        self.orders = Order.testOrderCollection
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders.indices, id: \.self) { index in
                    let order = $orders[index]
                    
                    NavigationLink(destination: OrderDetails(order: order, isPaid: order.paid, isDelivered: order.delivered)) {
                        OrderRowView(order: $orders[index])
                    }
                }.onDelete(perform: deleteOrder)
            }
            .navigationTitle("Orders")
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
    
    private func deleteOrder(at offset: IndexSet) {
        orders.remove(atOffsets: offset)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
