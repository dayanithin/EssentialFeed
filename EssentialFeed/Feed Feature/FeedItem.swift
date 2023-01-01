//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Dayanithi on 31/12/22.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: String
}
