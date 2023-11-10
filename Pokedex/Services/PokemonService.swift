//
//  PokemonService.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

protocol PokemonListService {
    func getPokemons(urlString: String) async throws -> PokemonResponse
}

class PokemonService: PokemonListService {
    var manager: Networking
    
    init(manager: Networking = NetworkManager()) {
        self.manager = manager
    }
    
    func getPokemons(urlString: String) async throws -> PokemonResponse {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }

        do {
            let res = try await manager.getDataFromNetworkLayer(url: url, type: PokemonResponse.self)
            return res
        } catch {
            throw error
        }
    }
}
