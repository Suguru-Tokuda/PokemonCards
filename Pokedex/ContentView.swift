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
    @State var selectedRoute: ContentRoute? = .list

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

#Preview {
    ContentView(vm: ContentViewModel())
}
