//
//  CustomerController.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/1/21.
//

import Foundation

class CustomerController: ObservableObject {
    @Published var customers: [Customer]
    
    init() {
        customers = []
        loadCustomerData()
    }
    
    func SaveCustomerList() {
        CustomerDataManager.SaveToFile(DataList: customers)
    }
    
    private func loadCustomerData() {
        let dataReturn = CustomerDataManager.LoadFromFile()
        if dataReturn.count > 0 {
            self.customers = dataReturn.map { $0 as! Customer }
        } else {
            self.customers = []
        }
    }
}
