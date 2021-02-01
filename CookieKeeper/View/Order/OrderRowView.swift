//
//  OrderRowView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct OrderRowView: View {
    let order: Order
    var body: some View {
        HStack {
            Text(order.customer.lastName)
            Spacer()
            Text("Total: $\(String(format: "%.2f",order.total))")
            Spacer()
            Text("Paid: \(Image(systemName: (order.paid ? "checkmark.circle.fill" : "checkmark.circle")))")
        }.background(order.delivered ? Color.orange : Color.white)
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(order: Order.testOrder)
    }
}
