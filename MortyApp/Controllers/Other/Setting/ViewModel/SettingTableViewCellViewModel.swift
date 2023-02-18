//
//  SettingTableViewCellViewModel.swift
//  MortyApp
//
//  Created by KH on 17/02/2023.
//

import UIKit

struct SettingTableViewCellViewModel {
    
    public let type: RMSettingOptions
    
    init(type: RMSettingOptions) {
        self.type = type
    }
    
    var displayTitle: String {
        return type.displayTitle
    }
    
    var displayImage: UIImage? {
        return type.displayImage
    }
    
    var showContainerColor: UIColor {
        return type.iconContainerColor
    }
}
