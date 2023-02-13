//
//  RMGetAllEpisodesResponse.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    
    let info: Info
    let results: [RMEpisode]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
