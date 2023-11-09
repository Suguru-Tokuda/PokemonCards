//
//  PokemonGridView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonGridView: View {
    @ObservedObject var vm: PokemonListViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var columns = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .ignoresSafeArea()
            if vm.isLoading {
                ProgressView()
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.displayedPokemons) { pokemon in
                        NavigationLink {
                            PokemonDetailsView(pokemon: pokemon)
                        } label: {
                            PokemonGridCellView(pokemon: pokemon)
                                .frame(height: horizontalSizeClass == .compact ? 180 : 400)
                        }
                    }
                }
            }
            .refreshable {
                Task {
                    await vm.getPokemons()
                }
            }
        }
        .task {
            print(".task")
            await vm.getPokemons()
        }
        .searchable(text: $vm.searchText)
        .onAppear {
            print("onAppear")
        }
    }
}

#Preview {
    PokemonGridView(vm: PokemonListViewModel())
}
