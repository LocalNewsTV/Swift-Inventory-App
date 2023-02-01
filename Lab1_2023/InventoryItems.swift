//
//  InventoryItems.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-25.
//

import Foundation
import SwiftUI
import os

class InventoryItems: ObservableObject {
    @Published var entries = [InventoryItem]()
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let entriesURL = documentsDirectory.appendingPathComponent("entries")
    
    init(previewMode: Bool) {
        if previewMode {
            entries.append(InventoryItem(image: "hare", description: "Hare"))
            entries.append(InventoryItem(image: "tortoise", description: "Tortoise"))
            entries.append(InventoryItem(image: "cup.and.saucer", description: "Latte"))
        }
    }
    init(){
        loadObjects()
    }
    func loadObjects() {
        do {
            let data = try Data(contentsOf: InventoryItems.entriesURL)
            let decoder = JSONDecoder()
            entries = try decoder.decode([InventoryItem].self, from: data)
        } catch {
            os_log("Cannot load due to %0", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
    func saveObjects() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(entries)
            try data.write(to: InventoryItems.entriesURL)
        } catch {
            os_log("Cannot save due to %0", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
}
