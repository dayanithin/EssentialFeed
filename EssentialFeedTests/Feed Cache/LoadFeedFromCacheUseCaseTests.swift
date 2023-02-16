//
//  LoadFeedFromCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 16/02/23.
//

import XCTest
import EssentialFeed

class LoadFeedFromCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.recievedMessages, [])
    }
    
    func test_load_requestsCacheRetrival() {
        let (sut, store) = makeSUT()
        sut.load { _ in }
        
        XCTAssertEqual(store.recievedMessages, [.retreive])
    }
    
    func test_load_failsOnRetrivalError() {
        let (sut, store) = makeSUT()
        let retrivalError = anyNSError()
        let exp = expectation(description: "wait for load completion")
        var recievedError: Error?
        sut.load { result in
            switch result {
            case let .failure(error):
                recievedError = error
            default:
                XCTFail("Expected Failure, got \(result) instead.")
            }
            exp.fulfill()
        }
        store.completeRetrival(with: retrivalError)
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(recievedError as NSError?, retrivalError)
    }
    
    func test_load_deliversNoImagesOnEmptyCache() {
        let (sut, store) = makeSUT()
        let exp = expectation(description: "wait for load completion")
        
        var recievedImages: [FeedImage]?
        sut.load { result in
            switch result {
            case let .success(images):
                recievedImages  = images
            default:
                XCTFail("Expected success, got \(result) instead")
            }
            exp.fulfill()
        }
        store.completeRetrivalWithEmptyCache()
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(recievedImages, [])
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
