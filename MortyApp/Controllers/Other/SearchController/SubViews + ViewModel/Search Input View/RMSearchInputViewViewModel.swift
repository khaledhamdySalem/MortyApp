//
//  RMSearchInputViewViewModel.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import UIKit

final class RMSearchInputViewViewModel {
    
    private let type: RMSearchViewController.Config.`Type`
    
    // MARK: - Init
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }

    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case location = "Location Type"
        
        var choices: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unKnown"]
            case .gender:
                return ["male", "female", "genderLess" , "unKnown"]
            case .location:
                return ["cluster", "planet", "microvest"]
            }
        }
    }
    
    public var hasDynamicOption: Bool {
        switch type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.location]
        }
    }
    
    public var searchPlaceHolder: String {
        switch type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name"
        }
    }
    
}
