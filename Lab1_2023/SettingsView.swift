//
//  SettingsView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colour: Color
    @State var value = 0
    func incrementStep() {
        value += 10
        if value >= 150{
            value = 150
        }
    }

    func decrementStep() {
        value -= 10
        if value < 0 { value = 0 }
    }
    var body: some View {
        ColorPicker("Background", selection: $colour).padding()
        Stepper(value: $value, in: 0...150) {
            Text("\(value)")
        }
    }
}

struct SettingsView_Previews:
PreviewProvider {
    @State static var colour = Color.yellow
    static var previews: some View {
        SettingsView(colour: $colour)
    }
}
