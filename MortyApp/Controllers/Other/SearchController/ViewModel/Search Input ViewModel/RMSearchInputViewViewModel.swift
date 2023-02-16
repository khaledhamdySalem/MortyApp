//
//  RMSearchInputViewViewModel.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import Foundation

struct RMSearchInputViewViewModel {
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
            case .status:
                return ["Alive", "Dead", "unKnown"]
            case .gender:
                return ["Male", "Female", "unKnown"]
            case .locationType:
                return ["cluster", "planet", "microface"]
            }
        }
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    public var hasDynamicOptions: Bool {
        switch type {
        case .character:
            return true
        case .episode:
            return false
        case .location:
            return true
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
            
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name"
        }
    }
}
