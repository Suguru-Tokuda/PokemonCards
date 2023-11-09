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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var vm: ContentViewModel
    @AppStorage("tabBarColor") var tabBarColor: Color = .orange
    @State var selectedRoute: String? = "List"
    private let routes = ["List", "Grid", "Settings"]

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
        NavigationStack {
            TabView {
                Group {
                    PokemonListView()
                        .tabItem {
                            Label("List", systemImage: "list.dash")
                        }
                    PokemonGridView(vm: PokemonListViewModel())
                        .tabItem {
                            Label("Grid", systemImage: "square.grid.3x3")
                        }
                    SettingView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .toolbarBackground(tabBarColor, for: .tabBar)

            }
            .onAppear {
                UIApplication.shared.setUpTabBarAppearance()
                vm.updateView()
            }
        }
    }
    
    @ViewBuilder
    func navigationSplitView() -> some View {
        NavigationSplitView {
            List(routes, id: \.self, selection: $selectedRoute) { route in
                Text(route)
            }
        } detail: {
            switch selectedRoute {
            case ContentRoute.list.rawValue:
                NavigationStack {
                    PokemonListView()
                }
            case ContentRoute.grid.rawValue:
                NavigationStack {
                    PokemonGridView(vm: PokemonListViewModel())
                }
            case ContentRoute.settings.rawValue:
                NavigationStack {
                    SettingView()
                }
            default:
                PokemonListView()
            }
        }
    }
}

#Preview {
    ContentView(vm: ContentViewModel())
}
