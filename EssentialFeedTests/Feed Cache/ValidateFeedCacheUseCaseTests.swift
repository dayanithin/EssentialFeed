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
    
    func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
        let (sut, store) = makeSUT()
        sut.validateCache()
        store.completeRetrivalWithEmptyCache()
        
        XCTAssertEqual(store.recievedMessages, [.retreive])
    }
    
    func test_validateCache_doesNotDeleteCacheLessThanSevenDaysOld() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let lessThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(days: 1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.load { _ in }
        store.completeRetrival(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
        
        XCTAssertEqual(store.recievedMessages, [.retreive])
    }

    func test_validateCache_deletesSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let sevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.validateCache()
        store.completeRetrival(with: feed.local, timestamp: sevenDaysOldTimestamp)
        XCTAssertEqual(store.recievedMessages, [.retreive, .deleteCacheFeed])
    }

    func test_validateCache_deletesMoreThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let moreThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(days: -1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.validateCache()
        store.completeRetrival(with: feed.local, timestamp: moreThanSevenDaysOldTimestamp)
        XCTAssertEqual(store.recievedMessages, [.retreive, .deleteCacheFeed])
    }

    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
}
