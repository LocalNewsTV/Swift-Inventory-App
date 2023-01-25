//
//  MainView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var inventoryItems: InventoryItems
    @State private var showSettings = false
    @State var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State var charLimit = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 150
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        NavigationStack() {
            VStack {
                if showSettings {
                    SettingsView(colour: $colour, charLimit: $charLimit)
                } else {
                    List($inventoryItems.entries) {
                        $inventoryItem in
                        NavigationLink(
                            destination: DetailView(colour: colour, charLimit: charLimit)){
                                RowView(inventoryItem: inventoryItem)
                            }
                    }
                }
            }
            .navigationBarItems(
                trailing:
            Button(
                action: { showSettings.toggle() },
                label: { Image(systemName: showSettings ? "house" : "gear") }
            )
            .accessibilityIdentifier("NavigationButton")
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
//        MainView()
        ForEach(["iPad (10th generation)", "iPhone 14 Pro"], id: \.self) {
            deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName)).environmentObject(InventoryItems())
        }
    }
}
