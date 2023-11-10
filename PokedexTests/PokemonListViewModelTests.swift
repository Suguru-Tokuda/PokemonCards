//
//  PokemonListViewModelTests.swift
//  PokedexTests
//
//  Created by Suguru Tokuda on 11/10/23.
//

import XCTest
@testable import Pokedex

final class PokemonListViewModelTests: XCTestCase {
    var vm: PokemonListViewModel!

    @MainActor override func setUpWithError() throws {
        vm = PokemonListViewModel(service: TestPokemonService())
    }

    override func tearDownWithError() throws {
        vm = nil
    }
    
    func testGetPokemonCards_whereWeAreExpecting_GoodResults() async throws {
        await vm.getPokemons(urlString: "PokemonCardResponse")
        let pokemonCard: Pokemon? = await vm.pokemons?.first
        
        XCTAssertEqual(pokemonCard?.name, "Aggron")
    }
    
    func testGetPokemonCards_whereWeAreExpecting_BadUrlError_whenNoURLPassed() async throws {
        await vm.getPokemons(urlString: "")
        let error = await vm.customError
        XCTAssertEqual(error, .badUrl)
    }
    
    func testGetPokemonCards_whereWeAreExpecting_ParsingError_whenIncorrectJsonIsParsed() async throws {
        await vm.getPokemons(urlString: "BadPokemonResponse")
        let error = await vm.customError
        XCTAssertEqual(error, .parsing)
    }
    
    func testGetPokemonCards_whereWeAreExpecting_NoDataError_whenParsingEmptyJsonFile() async throws {
        await vm.getPokemons(urlString: "NoData")
        let error = await vm.customError
        XCTAssertEqual(error, .noData)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
