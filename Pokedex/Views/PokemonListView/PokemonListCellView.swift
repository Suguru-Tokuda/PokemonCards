//
//  PokemonListCellView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonListCellView: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
            HStack {
                AsyncImage(url: URL(string: pokemon.images.small)) { img in
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(pokemon.name)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                    getTypes()
                }
                Spacer()
            }
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .frame(height: 100)
    }
}

extension PokemonListCellView {
    @ViewBuilder
    func getTypes() -> some View {
        HStack {
            ForEach(pokemon.types, id: \.self) { type in
                Text(type)
                    .padding(5)
                    .background(.gray)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

#Preview {
    PokemonListCellView(pokemon: Constants.previewPokemons[0])
}
