//
//  RMLoactionViewModel.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import Foundation

final class RMLoactionViewModel {
    
    private let locations = [RMLoaction]()
    
    private var cellViewModels = [String]()
    
    
    init() {
        
    }
    
    public func fetchLocations() {
        let request = RMRequest(endPoint: .location)
        RMService.shared.excute(request: request,
                                expecting: String.self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}

struct RMLoaction: Codable {
    
}
