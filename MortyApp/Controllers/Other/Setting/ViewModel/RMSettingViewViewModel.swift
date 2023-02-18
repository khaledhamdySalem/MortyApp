//
//  RMSettingViewViewModel.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import UIKit

class RMSettingViewViewModel {
   
    let cellViewModels: [SettingTableViewCellViewModel]
    
    init(cellViewModels: [SettingTableViewCellViewModel]) {
        self.cellViewModels = cellViewModels
    }
    
}
