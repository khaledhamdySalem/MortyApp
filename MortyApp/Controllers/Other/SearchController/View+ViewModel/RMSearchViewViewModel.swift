//
//  RMSearchViewViewModel.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import Foundation

// Render Search Results
// Render No Results
// Kick off API Request

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchText = ""
    
    private var optionMap = [RMSearchInputViewViewModel.DynamicOption: String]()
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangingBlock(_ block: @escaping((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func excuteSearch() {
        
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
}
