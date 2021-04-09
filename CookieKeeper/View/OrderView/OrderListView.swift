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
                ForEach(orders.indices, id: \.self) { index in
                    NavigationLink(destination: OrderDetails(order: $orders[index])) {
                        OrderRowView(order: $orders[index])
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
    
    private func deleteOrder(at offset: IndexSet) {
        orders.remove(atOffsets: offset)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: .constant([Order]()))
    }
}
