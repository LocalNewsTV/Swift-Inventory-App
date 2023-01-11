//
//  ContentView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct DetailView: View {
    @State private var description = "Hello Friend"
    @State private var favourite = false
    var colour: Color
    var body: some View {
        VStack {
            Image(systemName: "light.recessed")
                .resizable(resizingMode: .stretch)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .background(favourite ? colour : Color.white)
            Toggle(isOn: $favourite) {
                Text("Favourite")
            }
            TextEditor(text: Binding(
                get: {
                    description
                },
                set: {
                    newValue in
                    if newValue.count <= 150 {
                        description = newValue
                    }
                }
                )
            )
            Text(String(description.count))
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(colour: Color.yellow)
    }
}
