//
//  ContentView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

enum ContentRoute: String, CaseIterable {
    case list = "List",
         grid = "Grid",
         settings = "Settings"
}

struct ContentView: View {
    // MARK: @Environment
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    // MARK: @ObservedObject
    @ObservedObject var vm: ContentViewModel
    // MARK: @AppStorage
    @AppStorage("tabBarColor") var tabBarColor: Color = .orange
    // MARK: @State
    @State var selectedRoute: ContentRoute? = .list
    @State var selectedTabBarColor: Color = .orange

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                navigationStack()
            } else {
                navigationSplitView()
            }
        }
        .environmentObject(BackgroundColorClass())
    }
}

extension ContentView {
    @ViewBuilder
    func navigationStack() -> some View {
        TabView {
            NavigationStack {
                PokemonListView()
            }
                .tabItem {
                    tabItemLabel("List", "list.dash")
                }

            NavigationStack {
                PokemonGridView(vm: PokemonListViewModel())

            }
                .tabItem {
                    tabItemLabel("Grid", "square.grid.3x3")
                }

            NavigationStack {
                SettingView()
            }
                .tabItem {
                    tabItemLabel("Settings", "gear")
                }
        }
        .onAppear {
            UIApplication.shared.setUpTabBarAppearance()
            selectedTabBarColor = tabBarColor
        }
        .onChange(of: tabBarColor) { oldValue, newValue in
            UIApplication.shared.setUpTabBarAppearance()
            selectedTabBarColor = newValue
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(selectedTabBarColor, for: .tabBar)
    }
    
    @ViewBuilder
    func navigationSplitView() -> some View {
        NavigationSplitView {
            List(ContentRoute.allCases, id: \.self, selection: $selectedRoute) { route in
                Text(route.rawValue)
            }
        } detail: {
            switch selectedRoute {
            case .list:
                NavigationStack {
                    PokemonListView()
                }
            case .grid:
                NavigationStack {
                    PokemonGridView(vm: PokemonListViewModel())
                }
            case .settings:
                NavigationStack {
                    SettingView()
                }
            default:
                PokemonListView()
            }
        }
    }
}

extension ContentView {
    @ViewBuilder
    func tabItemLabel(_ label: String, _ systemImageName: String) -> some View {
        VStack {
            Image(systemName: systemImageName)
            Text(label)
        }
    }
}

#Preview {
    ContentView(vm: ContentViewModel())
}
