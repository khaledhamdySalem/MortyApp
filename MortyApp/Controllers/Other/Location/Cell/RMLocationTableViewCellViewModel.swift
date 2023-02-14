//
//  RMLocationTableViewCellViewModel.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import Foundation

final class RMLocationTableViewCellViewModel: Hashable {
    
    private let location: RMLocation
    
    init(locations: RMLocation) {
        self.location = locations
    }
    
    public var name: String {
        return location.name
    }
    
    public var type: String {
        return "Type: " + location.type
    }
    
    public var dimension: String {
        return location.dimension
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(dimension)
        hasher.combine(location.id)
    }
}
