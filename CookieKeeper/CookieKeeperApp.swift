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
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .onAppear() {
                    dataController.customers = customerController.customers
                }
                .onChange(of: scenePhase) { newScenePhase in
                    if newScenePhase == .background || newScenePhase == .inactive {
                        customerController.customers = dataController.customers
                        customerController.SaveCustomerList()
                    }
                }
                .onDisappear() {
                    print("App Closed.")
                }
        }
    }
}
