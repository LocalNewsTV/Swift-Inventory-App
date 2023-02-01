//
//  Lab1_2023App.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

@main
struct Lab1_2023App: App {
    @StateObject var inventoryItems = InventoryItems()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(inventoryItems)
        }
        .onChange(of: scenePhase, perform: {
            phase in
            switch phase {
            case .background:
                inventoryItems.saveObjects()
            default:
                break
            }
        })
    }
}
