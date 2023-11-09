//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon]?
    @Published var isLoading: Bool = false
    
    func getPokemons() async {
        let urlStr = "\(Constants.apiEndpoint)cards?page=1&pageSize=100"
        
        let networkMgr = NetworkManager()
        DispatchQueue.main.async {
            self.isLoading = true
        }
        do {
            let res = try await networkMgr.getDataFromNetworkLayer(url: URL(string: urlStr)!, type: PokemonResponse.self)
            DispatchQueue.main.async {
                self.pokemons = res.data
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print(error.localizedDescription)
        }
    }
}
