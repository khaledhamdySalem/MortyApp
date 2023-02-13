//
//  RMService.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import Foundation

enum RMServiceError: Error {
    case failedToCreatRequest
    case filedToGetData
}

final class RMService {
    static let shared = RMService()
    
//    private var cacheManager = RMAPICacheManager()
    
    private init() {}
    
    public func excute<T: Codable>(request: RMRequest,
                                   expecting type: T.Type,
                                   complition: @escaping (Result<T,
                                                          Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            complition(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                complition(.failure(error ?? RMServiceError.filedToGetData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(type.self, from: data)
                complition(.success(json))
            } catch {
                complition(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Make Request
    private func request(from request: RMRequest) -> URLRequest?{
        guard let url = request.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
