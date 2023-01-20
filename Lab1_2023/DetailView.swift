//
//  ContentView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct DetailView: View {
    @State private var description = ""
    @State private var favourite = false
    var colour: Color
    var charLimit: Int
    var body: some View {
        let defaultColor = Color.white
        VStack {
            Image(systemName: "light.recessed")
                .resizable(resizingMode: .stretch)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .background(favourite ? colour : Color.white)
                .accessibilityIdentifier("DetailImage")
            Toggle(isOn: $favourite) {
                Text("Favourite")
            }
            .accessibilityIdentifier("FavouriteToggle")
            TextEditor(text: Binding(
                get: {
                    description
                },
                set: {
                    newValue in
                    if newValue.count <= charLimit {
                        description = newValue
                    }
                }
                )
            )
            .accessibilityIdentifier("DetailTextEditor")
            Text(String("\(description.count)/\(charLimit)"))
            .accessibilityIdentifier("DetailText")
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let defaultColor = Color.yellow
    static var previews: some View {
        DetailView(colour: defaultColor, charLimit: 150)
    }
}
