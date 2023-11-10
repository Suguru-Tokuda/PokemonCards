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
                ForEach(vm.displayedPokemons) { pokemon in
                    PokemonListCellView(pokemon: pokemon)
                        .background(
                            NavigationLink("", destination: PokemonDetailsView(pokemon: pokemon))
                                .opacity(0)
                        )
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                        .listRowSeparator(.hidden)
                }
            }
            .refreshable {
                Task {
                    await vm.getPokemons()
                }
            }
            .listStyle(.plain)
            .searchable(text: $vm.searchText)
            .task {
                await vm.getPokemons()
            }
            .padding(.horizontal, 5)
            .alert("Something went wrong", isPresented: $vm.isAlertPresented) {
                Button {
                    Task {
                        await vm.getPokemons()
                    }
                } label: {
                    Text("Try again.")
                }
                
                Button {
                    vm.supressAlert()
                } label: {
                    Text("Close")
                }
            } message: {
                Text(vm.customError?.errorDescription ?? "")
            }
        }
    }
}

#Preview {
    PokemonListView()
}
