//
//  InventoryItem.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-25.
//

import Foundation
import SwiftUI

struct InventoryItem: Identifiable {
    let id = UUID()
    var image: String
    var description: String
    var fave: Bool
    init(image: String, description: String, fave: Bool) {
        self.image = image
        self.description = description
        self.fave = fave
    }
}
