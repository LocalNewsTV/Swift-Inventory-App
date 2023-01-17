//
//  SettingsView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colour: Color
    @Binding var charLimit: Int
    let maxCharRange = 300
    let minCharRange = 0
    var body: some View {
        let range = minCharRange...maxCharRange
        VStack {
            ColorPicker("Background", selection: $colour).padding(.leading, 45).padding(.trailing, 45)
            Stepper(value: $charLimit, in: range, step: 10) {
                Text("Value: \(charLimit)")
            }
            .padding(.leading, 45).padding(.trailing, 45)
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        @State static var colour = Color.yellow
        @State static var charLimit = 150
        //@State static var value =
        static var previews: some View {
            SettingsView(colour: $colour, charLimit: $charLimit)
        }
    }
    
}
