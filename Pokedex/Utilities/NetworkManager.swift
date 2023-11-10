//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation

protocol Networking {
    func getDataFromNetworkLayer<T: Decodable>(url: URL, type: T.Type) async throws -> T
}

class NetworkManager: Networking {
    func getDataFromNetworkLayer<T>(url: URL, type: T.Type) async throws -> T where T : Decodable {
        var rawData: Data

        do {
            (rawData, _) = try await URLSession.shared.data(from: url)
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
