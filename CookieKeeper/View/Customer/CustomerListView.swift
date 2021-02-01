//
//  CustomerListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct CustomerListView: View {
    @Binding var customers: [Customer]
    @State private var isPresented = false
    @State private var data: Customer = Customer()
    var body: some View {
        NavigationView {
            List {
                ForEach(customers) { customer in
                    NavigationLink(
                        destination: CustomerEntry(customer: binding(for: customer)),
                        label: {
                            CustomerRowView(customer: customer)
                        })
                    
                }
            }
            .navigationBarTitle("List of Customers")
            .navigationBarItems(trailing: Button(action: {
                isPresented = true
                data = Customer()
            }, label: {
                Image(systemName: "plus")
            }))
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    CustomerEntry(customer: $data)
                        .navigationTitle("New Customer")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            let newCustomer = Customer(id: customers.count+1, firstName: data.firstName, lastName: data.lastName, street: "", city: "", state: "", zip: "", phoneNumber: data.phoneNumber, email: data.email)
                            customers.append(newCustomer)
                            isPresented = false
                        })
                }
            }
        }
    }
    
    private func binding(for customer: Customer) -> Binding<Customer> {
        guard let customerIndex = customers.firstIndex(where: {$0.id == customer.id}) else {
            fatalError("Can not find customer in collection")
        }
        return $customers[customerIndex]
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var customers: [Customer] = [
        Customer(id: 1, firstName: "Brenton", lastName: "Niebauer", phoneNumber: "724-316-5569", email: "b.niebauer@me.com"),
        Customer(id: 2, firstName: "Kelsey", lastName: "Niebauer", phoneNumber: "724-713-7570", email: "niebauer.kelseyj@me.com") ]
    static var previews: some View {
        CustomerListView(customers: .constant(customers))
    }
}
