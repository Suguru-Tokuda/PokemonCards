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
            Color.green.opacity(0.5)
                .ignoresSafeArea()
            if vm.isLoading {
                ProgressView()
            }
            List {
                ForEach(vm.pokemons ?? []) { pokemon in
                    PokemonListCellView(pokemon: pokemon)
                        .background(
                            NavigationLink("", destination: PokemonDetailsView(pokemon: pokemon))
                                .opacity(0)
                        )
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                }
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    await vm.getPokemons()
                }
            }
            .padding(.horizontal, 5)
        }
        
    }
}

#Preview {
    PokemonListView()
}
