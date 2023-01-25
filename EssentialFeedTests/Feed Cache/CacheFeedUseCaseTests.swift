//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 25/01/23.
//

import XCTest

class LocalFeedLoader {
    
    var store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
}

class FeedStore {
    var deleteCachedFeedCallCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
}
