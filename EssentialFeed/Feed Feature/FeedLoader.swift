//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/12/22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
