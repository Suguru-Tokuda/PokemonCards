//
//  PokemonGridCellView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonGridCellView: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.5)
            AsyncImage(url: URL(string: pokemon.images.small)) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    PokemonGridCellView(pokemon: Constants.previewPokemons[0])
}
