//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 31/12/22.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}

