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
    @ObservedObject var customerController = CustomerController()
    var body: some Scene {
        WindowGroup {
            ContentView(customers: $customerController.customers)
                .onChange(of: scenePhase) { newScenePhase in
                    if newScenePhase == .background || newScenePhase == .inactive {
                        customerController.SaveCustomerList()
                    }
                }
                .onDisappear() {
                    print("App Closed.")
                }
        }
    }
}
