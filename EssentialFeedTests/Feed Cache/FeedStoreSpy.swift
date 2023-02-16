//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 16/02/23.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {
   
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    
    enum RecievedMessage: Equatable {
        case deleteCacheFeed
        case insert([LocalFeedImage], Date)
        case retreive
    }
    
    private(set) var recievedMessages = [RecievedMessage]()
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        recievedMessages.append(.deleteCacheFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        
        insertionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](nil)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        recievedMessages.append(.insert(feed, timestamp))
    }
    
    func retrieve() {
        recievedMessages.append(.retreive)
    }
}
