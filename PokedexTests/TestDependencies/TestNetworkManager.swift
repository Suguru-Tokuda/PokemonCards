//
//  TestNetworkManager.swift
//  PokedexTests
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation
@testable import Pokedex

class TestNetworkManager: Networking {
    func getDataFromNetworkLayer<T>(url: URL, type: T.Type) async throws -> T where T : Decodable {
        let bundle = Bundle(for: TestNetworkManager.self)
        let url = bundle.url(forResource: url.absoluteString, withExtension: "json")
        
        guard let url = url else { throw NetworkError.badUrl }
        
        var rawData: Data
        
        do {
            rawData = try Data(contentsOf: url)
        } catch {
            throw NetworkError.noData
        }
        
        if rawData.isEmpty {
            throw NetworkError.noData
        }
        
        do {
            return try JSONDecoder().decode(type, from: rawData)
        } catch {
            throw NetworkError.parsing
        }
    }
}
