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
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let parsedData = try JSONDecoder().decode(type, from: data)
            return parsedData
        } catch {
            throw error
        }
    }
}
