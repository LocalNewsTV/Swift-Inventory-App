//
//  MainView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI

struct MainView: View {
    @State private var showSettings = false
    @State var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State var charLimit = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 100
    var body: some View {
        NavigationStack() {
            VStack {
                if showSettings {
                    SettingsView(colour: $colour, charLimit: $charLimit)
                } else {
                    DetailView(colour: colour, charLimit: charLimit)
                }
            }
            .navigationBarItems(
                trailing:
            Button(
                action: {
                    showSettings.toggle()
                },
                label: {
                    Image(systemName: showSettings ? "house" : "gear")
                }
                )
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
