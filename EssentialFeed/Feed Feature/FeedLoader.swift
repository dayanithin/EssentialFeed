//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/12/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
