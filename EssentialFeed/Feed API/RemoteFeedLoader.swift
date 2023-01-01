//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/12/22.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success(let data, let response):
                completion(FeedItemMapper.map(data, response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
