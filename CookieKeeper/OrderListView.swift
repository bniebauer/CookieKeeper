//
//  OrderListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var dataController: DataController
    @State var isPresented = false
    @State var newOrder = Order()
    
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    var body: some View {
        NavigationView {
            List {
                ForEach(dataController.orders) { order in
                    NavigationLink(destination: OrderDetails(order: binding(for: order))) {
                        OrderRowView(order: order, cookies: cookies)
                    }
                }
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
                OrderEditView(newOrder: $newOrder, isShowing: $isPresented)
            }
        }
    }
    
    private func binding(for order: Order) -> Binding<Order> {
        guard let orderIndex = dataController.orders.firstIndex(where: {$0.id == order.id }) else {
            fatalError("Could not find order in collection")
        }
        return $dataController.orders[orderIndex]
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
            .environmentObject(DataController())
    }
}
