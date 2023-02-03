//
//  RowView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-25.
//

import SwiftUI

struct RowView: View {
    var inventoryItem: InventoryItem
    var colour: Color
    var body: some View {
        HStack {
            Image(uiImage: inventoryItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .leading)
                .border(inventoryItem.fave ? colour : Color.white)
                .scaledToFit()
            Text(inventoryItem.description)
                .frame(width: 200, height: 100, alignment: .leading)
                .padding(.trailing, -15)
        }
        .padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var inventoryItems = InventoryItems(previewMode: true)
    static let defCol = Color.yellow
    static var previews: some View {
        RowView(inventoryItem: inventoryItems.entries[0], colour: defCol)
    }
}
