//
//  ContentView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct DetailView: View {
    var colour: Color
    var charLimit: Int
    @Binding var inventoryItem: InventoryItem
    var body: some View {
//        let defaultColor = Color.white
        VStack {
            Image(systemName: inventoryItem.image)
                .resizable(resizingMode: .stretch)
                .imageScale(.large)
                .foregroundColor(.purple) //originally .accentColor
                .background(inventoryItem.fave ? colour : Color.white)
                .accessibilityIdentifier("DetailImage")
            Toggle(isOn: $inventoryItem.fave) {
                Text("Favourite")
            }
            .accessibilityIdentifier("FavouriteToggle")
            TextEditor(text: Binding(
                get: {
                    inventoryItem.description
                },
                set: {
                    newValue in
                    if newValue.count <= charLimit {
                        inventoryItem.description = newValue
                    }
                }
                )
            )
            .accessibilityIdentifier("DetailTextEditor")
            Text(String("\(inventoryItem.description.count)/\(charLimit)"))
            .accessibilityIdentifier("DetailText")
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    @State var inventoryItems: InventoryItems
    static let defaultColor = Color.yellow
//    @State static var inventoryItem: InventoryItem
    @State static var inventoryItem = InventoryItem(image: "hare", description: "Hare", fave: false)
    @State static var favourite: Bool = false
    static var previews: some View {
        DetailView(colour: defaultColor, charLimit: 150, inventoryItem: $inventoryItem)
    }
}
