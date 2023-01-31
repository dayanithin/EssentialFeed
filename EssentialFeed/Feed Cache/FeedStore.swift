//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/01/23.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func insert(_ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
}
