//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 23/02/23.
//

import XCTest
import EssentialFeed

class ValidateFeedCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.recievedMessages, [])
    }
    
    func test_validateCache_deletesCahceOnRetrivalError() {
        let (sut, store) = makeSUT()
        sut.validateCache()
        store.completeRetrival(with: anyNSError())
        
        XCTAssertEqual(store.recievedMessages, [.retreive, .deleteCacheFeed])
    }

    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

