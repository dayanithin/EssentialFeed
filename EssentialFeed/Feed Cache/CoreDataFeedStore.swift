//
//  CoreDataFeedStore.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 27/03/23.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    public init() {}
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func retrieve(completion: @escaping RetrivalCompletion) {
        completion(.empty)
    }
}
