//
//  RMSearchViewViewModel.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import Foundation

// Show Search Results
// show no Results
// Kick off Api Request

final class RMSearchViewViewModel {
    
    public let config: RMSearchViewController.Config
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var block: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchText = ""
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        self.block?((option, value))
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.block = block
    }
    
    public func excuteSearch() {
        
    }
}
