//
//  TestPokemonService.swift
//  PokedexTests
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation
@testable import Pokedex

class TestPokemonService: PokemonListService {
    var manager: Networking
    
    init(manager: Networking = TestNetworkManager()) {
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
