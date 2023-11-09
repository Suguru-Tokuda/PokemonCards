//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var backgroundColor: BackgroundColorClass

    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            backgroundColor.color.opacity(0.5)
                .ignoresSafeArea()
            GeometryReader { reader in
                ScrollView {
                    header(frameWidth: reader.size.width)
                }
            }
        }
    }
}

extension PokemonDetailsView {
    @ViewBuilder
    func header(frameWidth: CGFloat) -> some View {
        VStack(alignment: .center) {
            Text(pokemon.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            AsyncImage(url: URL(string: pokemon.images.large)) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: frameWidth * 0.7)
            } placeholder: {
                ProgressView()
            }
        }
        .frame(width: frameWidth)
    }
}

#Preview {
    PokemonDetailsView(pokemon: Constants.previewPokemons[0])
        .environmentObject(BackgroundColorClass())
}
