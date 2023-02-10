//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by KH on 02/02/2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private init() {}
    
    private let imageCache = NSCache<NSString, NSData>()
    
    public func downloadImage(url: URL?, complition: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = url else {
            complition(.failure(URLError(.badURL)))
            return
        }
        
        let key = url.absoluteString as NSString
        if let data = imageCache.object(forKey: key) {
            complition(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                complition(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            
            self?.imageCache.setObject(value, forKey: key)
            
            complition(.success(data))
        }
        task.resume()
    }
}
