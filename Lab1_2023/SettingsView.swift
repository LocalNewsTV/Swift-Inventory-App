//
//  SettingsView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

func color2array(colour: Color) -> [CGFloat] {
    let uiColor = UIColor(colour)
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return [red, green, blue, alpha]
}

func array2color(array: [CGFloat]) -> Color {
    return Color(Color.RGBColorSpace.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
}
struct SettingsView: View {
    @Binding var colour: Color
    @Binding var charLimit: Int
    let maxCharRange = 300
    let minCharRange = 10
    let stepSize = 10
    var body: some View {
        let range = minCharRange...maxCharRange
        VStack {
            ColorPicker("Background", selection: Binding(
                get: {
                    colour
                },
                set: { newValue in
                    colour = newValue
                    UserDefaults.standard.set(color2array(colour: colour), forKey: "BackgroundColour")
                }
            ))
            .padding(.leading, 45)
            .padding(.trailing, 45)
            .accessibilityIdentifier("BackgroundColorPicker")
            Stepper(value: Binding(
                    get: {
                        charLimit
                    },
                    set: { newValue in
                        charLimit = newValue
                        UserDefaults.standard.set(charLimit, forKey: "MaxCharacterCount")
                    })
                        , in: range, step: stepSize) {
                Text("Value: \(charLimit)")
                
            }
            .padding(.leading, 45).padding(.trailing, 45)
            .accessibilityIdentifier("MaxCountStepper")
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
