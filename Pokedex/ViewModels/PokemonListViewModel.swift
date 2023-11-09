//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon]?
    @Published var displayedPokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscriptions()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func addSubscriptions() {
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.filterPokemons()
            }
            .store(in: &cancellables)
    }
    
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
                self.filterPokemons()
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print(error.localizedDescription)
        }
    }
    
    func filterPokemons() {
        self.displayedPokemons = !self.searchText.isEmpty ? (self.pokemons ?? []).filter { self.searchText.lowercased().contains($0.name.lowercased())} : (self.pokemons ?? [])
    }
}
