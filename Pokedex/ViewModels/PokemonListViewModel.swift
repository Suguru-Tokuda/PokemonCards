//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation
import Combine

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon]?
    @Published var displayedPokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var isAlertPresented: Bool = false
    
    var customError: NetworkError?
    var cancellables: Set<AnyCancellable> = []
    
    // Dependency
    var service: PokemonListService
    
    init(service: PokemonListService = PokemonService()) {
        self.service = service
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
    
    func getPokemons(urlString: String = "\(Constants.apiEndpoint)cards?page=1&pageSize=100") async {
        do {
            self.isLoading = true
            let res = try await service.getPokemons(urlString: urlString)
            self.pokemons = res.data
            self.filterPokemons()
            self.isLoading = false
        } catch {
            switch error {
            case NetworkError.badUrl:
                customError = NetworkError.badUrl
            case NetworkError.noData:
                customError = NetworkError.noData
            case NetworkError.parsing:
                customError = NetworkError.parsing
            default:
                customError = NetworkError.noData
            }
            self.isLoading = false
            self.isAlertPresented = true
        }
    }
    
    func filterPokemons() {
        self.displayedPokemons = !self.searchText.isEmpty ? (self.pokemons ?? []).filter { self.searchText.lowercased().contains($0.name.lowercased())} : (self.pokemons ?? [])
    }
    
    func supressAlert() {
        self.isAlertPresented = false
        self.customError = nil
    }
}
