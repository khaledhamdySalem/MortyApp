//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive:
            return "\(rawValue)"
        case .dead:
            return "\(rawValue)"
        case .unknown:
            return "UnKnown"
        }
    }
}
