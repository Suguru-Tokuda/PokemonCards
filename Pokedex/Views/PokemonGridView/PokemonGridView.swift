//
//  PokemonGridView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonGridView: View {
    @ObservedObject var vm: PokemonListViewModel
    var columns = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.pokemons ?? []) { pokemon in
                        NavigationLink {
                            PokemonDetailsView(pokemon: pokemon)
                        } label: {
                            PokemonGridCellView(pokemon: pokemon)
                                .frame(height: 180)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await vm.getPokemons()
            }
        }
    }
}

#Preview {
    PokemonGridView(vm: PokemonListViewModel())
}
