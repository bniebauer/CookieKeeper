//
//  OrderDetails.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderDetails: View {
    @Binding var order: Order
    var body: some View {
        List {
            VStack  (alignment: .leading){
                HStack {
                    Text(order.customer.firstName)
                        .font(.title)
                    Text(order.customer.lastName)
                        .font(.title)
                }
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(order.customer.street)
                        HStack {
                            Text(order.customer.city)
                            Text(order.customer.state)
                            Text(order.customer.zip)
                        }
                    }
                }
                Text("Total: $\(String(format: "%.2f", order.total))")
                Text("Number of boxes: \(order.selection.count)")
                HStack {
                    HStack {
                        Text("Paid:")
                        Button(action: {}, label: {
                            Image(systemName: (order.paid ? "checkmark.circle.fill": "checkmark.circle"))
                        })
                    }
                    Spacer()
                    HStack {
                        Text("Delivered:")
                        Button(action: {}, label: {
                            Image(systemName: (order.delivered ? "checkmark.circle.fill": "checkmark.circle"))
                        })
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Order #\(order.id)")
        .navigationBarItems(trailing: Button("Edit"){
            
        })

    }
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetails(order: .constant(Order.testOrder))
    }
}
