//
//  InventoryItems.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-25.
//

import Foundation
import SwiftUI

class InventoryItems: ObservableObject {
    @Published var entries: [InventoryItem]
    
    init() {
        entries = [InventoryItem]()
        entries.append(InventoryItem(image: "hare", description: "Hare"))
        entries.append(InventoryItem(image: "tortoise", description: "Tortoise"))
        entries.append(InventoryItem(image: "cup.and.saucer", description: "Latte"))
    }
}
