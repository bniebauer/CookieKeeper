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
    @Binding var isPaid: Bool
    @Binding var isDelivered: Bool
    
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
    var body: some View {
        List {
            Section {
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
                            Image(systemName: (isPaid ? "checkmark.circle.fill": "checkmark.circle")).buttonStyle(PlainButtonStyle())
                                .onTapGesture {
                                    self.isPaid.toggle()
                                }
                        }
                        Spacer()
                        HStack {
                            Text("Delivered:")
                            Image(systemName: (isDelivered ? "checkmark.circle.fill": "checkmark.circle"))
                            .buttonStyle(PlainButtonStyle())
                                .onTapGesture {
                                    isDelivered.toggle()
                                }
                            
                        }
                    }
                }
                .padding()
            }
            Section {
                ForEach(order.selection.sorted(by: >), id: \.key) { key, value in
                    let cookie = cookies.first(where: { $0.name == key})!
                    let numOfBoxes = Binding(get: {
                        return self.order.selection[key] ?? 0
                    }, set: {
                        self.order.selection[key] = $0
                    })
                
                    CookieRowView(cookie: cookie, numOfBoxes: numOfBoxes)
                }
            }
                NavigationLink(
                    destination: PDFViewer(order: order),
                    label: {
                        Text("Preview")
                    })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Order: \(order.customer.lastName)")
        .navigationBarItems(trailing: Button("Edit"){
            
        })

    }
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderDetails(order: .constant(Order.testOrder), isPaid: .constant(Order.testOrder.paid), isDelivered: .constant(Order.testOrder.delivered))
                .environmentObject(DataController())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
                .previewDisplayName("iPhone 12 Pro")
        }
        
        NavigationView {
            OrderDetails(order: .constant(Order.testOrder), isPaid: .constant(Order.testOrder.paid), isDelivered: .constant(Order.testOrder.delivered))
                .environmentObject(DataController())
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
                .previewDisplayName("iPad Air")
        }
    }
}
