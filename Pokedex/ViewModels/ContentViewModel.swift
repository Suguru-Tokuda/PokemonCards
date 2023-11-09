//
//  ContentViewModel.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    func updateView() {
        self.objectWillChange.send()
    }
}
