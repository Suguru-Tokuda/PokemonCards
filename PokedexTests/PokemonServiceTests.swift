//
//  PokemonServiceTests.swift
//  PokedexTests
//
//  Created by Suguru Tokuda on 11/10/23.
//

import XCTest
@testable import Pokedex

final class PokemonServiceTests: XCTestCase {
    var service: PokemonService!

    override func setUpWithError() throws {
        service = PokemonService(manager: TestNetworkManager())
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testGetPokemonCards_whereWeAreExpecting_GoodResults() async throws {
        let res = try await service.getPokemons(urlString: "PokemonCardResponse")
        let pokemonCard: Pokemon? = res.data.first
        
        XCTAssertEqual(pokemonCard?.name, "Aggron")
    }
    
    func testGetPokemonCards_whereWeAreExpecting_BadUrlError_whenNoURLPassed() async throws {
        var networkError: NetworkError?
        
        do {
            _ = try await service.getPokemons(urlString: "")
        } catch {
            networkError = error as? NetworkError
        }
        
        XCTAssertEqual(networkError, .badUrl)
    }
    
    func testGetPokemonCards_whereWeAreExpecting_ParsingError_whenIncorrectJsonIsParsed() async throws {
        var networkError: NetworkError?
        
        do {
            _ = try await service.getPokemons(urlString: "BadPokemonResponse")
        } catch {
            networkError = error as? NetworkError
        }
        
        XCTAssertEqual(networkError, .parsing)
    }
    
    func testGetPokemonCards_whereWeAreExpecting_NoDataError_whenParsingEmptyJsonFile() async throws {
        var networkError: NetworkError?
        
        do {
            _ = try await service.getPokemons(urlString: "NoData")
        } catch {
            networkError = error as? NetworkError
        }
        
        XCTAssertEqual(networkError, .noData)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
