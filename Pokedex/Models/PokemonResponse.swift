//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation

struct PokemonResponse: Codable {
    let data: [Pokemon]
    let page, pageSize, count, totalCount: Int
}

struct Pokemon: Codable, Identifiable {
    let id, name: String
    let supertype: String?
    let subtypes: [String]?
    let hp: String?
    let types: [String]
    let evolvesFrom: String?
    let attacks: [Attack]?
    let weaknesses: [Resistance]?
    let resistances: [Resistance]?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let datumSet: Set?
    let number, artist: String?
    let rarity: String?
    let flavorText: String?
    let nationalPokedexNumbers: [Int]?
    let legalities: Legalities?
    let images: DatumImages
    let tcgplayer: Tcgplayer?
    let cardmarket: Cardmarket?
    let evolvesTo: [String]?
    let level: String?
    let abilities: [Ability]?
    let rules: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, hp, types, evolvesFrom, attacks, weaknesses, resistances, retreatCost, convertedRetreatCost
        case datumSet = "set"
        case number, artist, rarity, flavorText, nationalPokedexNumbers, legalities, images, tcgplayer, cardmarket, evolvesTo, level, abilities, rules
    }
}

struct Ability: Codable {
    let name, text, type: String
}

struct Attack: Codable {
    let name: String
    let cost: [String]
    let convertedEnergyCost: Int
    let damage, text: String
}

struct Cardmarket: Codable {
    let url: String
    let updatedAt: String
    let prices: [String: Double]
}

struct Set: Codable {
    let id, name, series: String
    let printedTotal, total: Int
    let legalities: Legalities
    let ptcgoCode: String?
    let releaseDate, updatedAt: String
    let images: SetImages
}

struct SetImages: Codable {
    let symbol, logo: String
}

struct Legalities: Codable {
    let unlimited: String?
    let expanded: String?
}

struct DatumImages: Codable {
    let small, large: String
}

struct Resistance: Codable {
    let type, value: String
}

struct Tcgplayer: Codable {
    let url: String
    let updatedAt: String
    let prices: Prices
}

struct Prices: Codable {
    let holofoil, reverseHolofoil, normal: Holofoil?
}

struct Holofoil: Codable {
    let low, mid, high, market: Double
    let directLow: Double?
}
