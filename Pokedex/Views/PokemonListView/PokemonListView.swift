//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var vm = PokemonListViewModel()
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            }
            List {
                ForEach(vm.pokemons ?? []) { pokemon in
                    ZStack {
                        PokemonListCellView(pokemon: pokemon)
                        NavigationLink {
                            PokemonDetailsView(pokemon: pokemon)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowInsets(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    await vm.getPokemons()
                }
            }
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    PokemonListView()
}
