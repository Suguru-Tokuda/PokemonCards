//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    init() {
        UIApplication.shared.setUpTabBarAppearance()
        UIApplication.shared.setUpTAbleViewAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ContentViewModel())
        }
    }
}
