//
//  InventoryItem.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-25.
//

import Foundation
import SwiftUI

struct InventoryItem: Identifiable, Codable {
    var id = UUID()
    var image: UIImage {
        get {
            UIImage(data: self.imageAsData) ?? UIImage (systemName: "questionmark")!
        }
        set {
            self.imageAsData = newValue.pngData() ?? UIImage(systemName: "questionmark")!.pngData()!
        }
    }
    var imageAsData: Data
    var description: String
    var fave: Bool
    init(image: String, description: String, fave: Bool = false) {
        self.imageAsData = (UIImage(systemName: image) ?? UIImage(systemName: "questionmark")!).pngData()!
        self.description = description
        self.fave = fave
    }
    init(image: UIImage, description: String, fave: Bool = false){
        self.imageAsData = image.pngData()!
        self.description = description
        self.fave = fave
    }
}
