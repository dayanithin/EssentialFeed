//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 31/12/22.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://www.google.com")!
        _ = RemoteFeedLoader(url: url, client: client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        let url = URL(string: "https://www.google.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        sut.load()
        XCTAssertEqual(client.requestedURL, url)
    }
}

