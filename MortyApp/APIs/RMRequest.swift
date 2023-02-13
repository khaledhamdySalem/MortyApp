//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import Foundation

final class RMRequest {
    //- https://rickandmortyapi.com/api/character/?name=rick&status=alive
    // Base URL -> https://rickandmortyapi.com/api
    // EndPoint -> /character
    // Path Components -> /1
    // Query Parameters -> ?name=rick&status=alive
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endPoint: RMEndPoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    private func addEndPoint(_ string: inout String) {
        string += "/"
        string += endPoint.rawValue
    }
    
    private func addPathComponentIfFound(_ string: inout String) {
        if !pathComponents.isEmpty {
            pathComponents.forEach { string += "/\($0)" }
        }
    }
    
    private func addQueryParameterIfFound(_ string: inout String) {
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }
    }
    
    private var urlString: String {
        var string = Constants.baseUrl
        addEndPoint(&string)
        addPathComponentIfFound(&string)
        addQueryParameterIfFound(&string)
        return string
    }
    
    public var url: URL?{
        return URL(string: urlString)
    }
    
    public var httpMethod: String {
        return "GET"
    }
    
    init(endPoint: RMEndPoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndPoint = RMEndPoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndPoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap { st in
                    guard st.contains("=") else { return nil}
                    let parts = st.components(separatedBy: "=")
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1])
                }
                
                if let rmEndPoint = RMEndPoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndPoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endPoint: .character)
    static let listEpisdoesRequests = RMRequest(endPoint: .episode)
}

