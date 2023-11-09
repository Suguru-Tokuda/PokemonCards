//
//  ButtonModifier.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundStyle(.white)
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 50)
                .frame(maxHeight: 50)
                .zIndex(1.0)
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.blue)
                .zIndex(0.9)
                .frame(maxHeight: 50)
        }
    }
}
