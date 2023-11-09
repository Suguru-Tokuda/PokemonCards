//
//  SettingView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("tabBarColor") var tabBarColor: Color = .orange
    @State var selectedColor: Color = .black
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.4)
                .ignoresSafeArea(edges: .top)
            VStack {
                Text("Settings")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink {
                    TabBarColorPicker(selectedColor: selectedColor)
                } label: {
                    Text("Tab Bar Color")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
        .onAppear {
            selectedColor = tabBarColor
        }
    }
}

#Preview {
    SettingView()
}
