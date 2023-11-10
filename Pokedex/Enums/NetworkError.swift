//
//  NetworkError.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

enum NetworkError: String, Error {
    case badUrl,
         noData,
         parsing
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            NSLocalizedString("Bad URL for an http request.", comment: self.rawValue)
        case .noData:
            NSLocalizedString("No data found for the request.", comment: self.rawValue)
        case .parsing:
            NSLocalizedString("Parsing the raw data into json failed.", comment: self.rawValue)
        }
    }
}
