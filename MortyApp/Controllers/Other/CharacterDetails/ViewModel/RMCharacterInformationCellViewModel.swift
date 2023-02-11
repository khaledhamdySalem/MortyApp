//
//  RMCharacterInformationCellViewModel.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

final class RMCharacterInformationCellViewModel {
    
    private var type: `Type`
    private let value: String
    
    public var displayValue: String {
        if value.isEmpty {
            return "Not Found"
        }
        return value
    }
    
    public var displayTitle: String {
        return type.displayTitle
    }
    
    public var displayIcon: UIImage? {
        return type.displayIcon
    }
    
    var tintColor: UIColor? {
        return type.color
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var displayTitle: String {
            switch self {
            case .status, .gender, .type, .species, .origin, .created, .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "Episode Count"
            }
        }
        
        var displayIcon: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "gear.badge.checkmark")
            case .gender:
                return UIImage(systemName: "gear.badge.checkmark")
            case .type:
                return UIImage(systemName: "gear.badge.checkmark")
            case .species:
                return UIImage(systemName: "gear.badge.checkmark")
            case .origin:
                return UIImage(systemName: "gear.badge.checkmark")
            case .created:
                return UIImage(systemName: "gear.badge.checkmark")
            case .location:
                return UIImage(systemName: "gear.badge.checkmark")
            case .episodeCount:
                return UIImage(systemName: "gear.badge.checkmark")
            }
        }
        
        var color: UIColor? {
            switch self {
            case .status:
                return UIColor.systemBlue
            case .gender:
                return UIColor.systemRed
            case .type:
                return UIColor.systemBrown
            case .species:
                return UIColor.systemBlue
            case .origin:
                return UIColor.systemGray
            case .created:
                return UIColor.systemPink
            case .location:
                return UIColor.systemOrange
            case .episodeCount:
                return UIColor.systemGreen
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
}
