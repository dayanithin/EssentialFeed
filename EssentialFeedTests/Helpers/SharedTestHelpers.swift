//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Dayanithi on 23/02/23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

