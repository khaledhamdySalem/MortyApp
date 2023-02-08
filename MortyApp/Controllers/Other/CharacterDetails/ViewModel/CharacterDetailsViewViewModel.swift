//
//  CharacterDetailsViewViewModel.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import Foundation

final class CharacterDetailsViewViewModel {
    
    private let character: RMCharacter
    
    var title: String {
        return character.name
    }
    
    init(character: RMCharacter) {
        self.character = character
    }
}
