//
//  CookieKeeperApp.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

@main
struct CookieKeeperApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var dataController = DataController()
    
    let customerController: CustomerController = CustomerController()
    let orderController: OrderController = OrderController()
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .onAppear() {
                    dataController.customers = customerController.customers
                    dataController.orders = orderController.orders
                }
                .onChange(of: scenePhase) { newScenePhase in
                    if newScenePhase == .background || newScenePhase == .inactive {
                        customerController.customers = dataController.customers
                        customerController.SaveCustomerList()
                        orderController.orders = dataController.orders
                        orderController.saveOrderList()
                    }
                }
                .onDisappear() {
                    print("App Closed.")
                }
        }
    }
}
