//
//  RMLoactionViewModel.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import Foundation

protocol RMLoactionViewModelDelegate: AnyObject {
    func didFetchIntialLocations()
}

final class RMLoactionViewModel {
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(locations: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    public private(set) var cellViewModels = [RMLocationTableViewCellViewModel]()
    
    public func location(at index: Int) -> RMLocation? {
        if index >= locations.count {
            return nil
        }
        return self.locations[index]
    }
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    public weak var rmLoactionViewModelDelegate: RMLoactionViewModelDelegate?
    
    public func fetchLocations() {
        let request = RMRequest(endPoint: .location)
        RMService.shared.excute(request: request,
                                expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.rmLoactionViewModelDelegate?.didFetchIntialLocations()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
