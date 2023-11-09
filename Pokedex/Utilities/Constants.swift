//
//  Constants.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation

struct Constants {
    static let apiEndpoint = "https://api.pokemontcg.io/v2/"
    static let previewPokemons: [Pokemon] = [
        Pokemon(id: "1", name: "Aggron", supertype: "Pokemon", subtypes: ["Stage 2"], hp: "140", types: ["Metal"], evolvesFrom: "Lairon", attacks: [Attack(name: "Second Strike", cost: ["Metal", "Colorless"], convertedEnergyCost: 3, damage: "40", text: "If the Defending Pokémon already has any damage counters on it, this attack does 40 damage plus 40 more damage.")], weaknesses: [Resistance(type: "Fire", value: "x2")], resistances: [Resistance(type: "Psychic", value: "-20")], retreatCost: ["Colorless"], convertedRetreatCost: 4, datumSet: Set(id: "1", name: "HS—Triumphant", series: "HeartGold & SoulSilver", printedTotal: 102, total: 103, legalities: Legalities(unlimited: "Legal", expanded: nil), ptcgoCode: "TM", releaseDate: "2010/11/03", updatedAt: "2018/03/04 10:35:00", images: SetImages(symbol: "https://images.pokemontcg.io/hgss4/symbol.png", logo: "https://images.pokemontcg.io/hgss4/logo.png")), number: "1", artist: "Kagemaru Himeno", rarity: "Rare Holo", flavorText: "You can tell its age by the length of its iron horns. It claims an entire mountain as its territory.", nationalPokedexNumbers: [306], legalities: Legalities(unlimited: "Legal", expanded: nil), images: DatumImages(small: "https://images.pokemontcg.io/hgss4/1.png", large: "https://images.pokemontcg.io/hgss4/1_hires.png"), tcgplayer: nil, cardmarket: nil, evolvesTo: ["Kakuna"], level: "57", abilities: [Ability(name: "Damage Bind", text: "", type: "Each Pokémon that has any damage counters on it (both yours and your opponent's) can't use any Poké-Powers.")], rules: ["This Pokémon is both Grass Metal type."])
    ]
}
