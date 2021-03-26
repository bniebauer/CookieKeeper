//
//  OrderDetails.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderDetails: View {
    @EnvironmentObject var dataController: DataController
    @Binding var order: Order
    @State var isPaid = false
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
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
                Text("Total: $\( order.total)")
                Text("Number of boxes: \(order.totalBoxes)")
                HStack {
                    HStack {
                        Text("Paid:")
                        Button(action: {
                            print("clicked")
                            isPaid = !order.paid
                            order.paid = isPaid
                        }, label: {
                            Image(systemName: (order.paid ? "checkmark.circle.fill": "checkmark.circle"))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                    HStack {
                        Text("Delivered:")
                        Button(action: {}, label: {
                            Image(systemName: (order.delivered ? "checkmark.circle.fill": "checkmark.circle"))
                        }).buttonStyle(PlainButtonStyle())
                        
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
            .environmentObject(DataController())
    }
}
