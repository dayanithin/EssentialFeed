//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/12/22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
