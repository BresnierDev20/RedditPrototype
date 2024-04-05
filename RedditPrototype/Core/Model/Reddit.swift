//
//  Reddit.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Foundation

struct RedditResponse: Codable {
    let kind: String
    let data: RedditData
}

struct RedditData: Codable {
    let after: String?
    let dist: Int
    let geoFilter: String
    let children: [RedditChild]
    let before: String?
    
    enum CodingKeys: String, CodingKey {
        case after, dist
        case geoFilter = "geo_filter"
        case children, before
    }
}

struct RedditChild: Codable {
    let kind: String
    let data: RedditPostData
}

struct RedditPostData: Codable {
    let subreddit: String
    let selfText: String
    let author: String
    let title: String
    let subredditNamePrefixed: String
    let name: String
    let quarantine: Bool
    let ups: Int
    let numComments: Int
    let media: Media?
 
    enum CodingKeys: String, CodingKey {
        case subreddit
        case selfText = "selftext"
        case title
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case name
        case quarantine
        case ups
        case numComments = "num_comments"
        case media = "media"
        case author
    }
}
struct Media: Codable {
    let oembed: Oembed?
    enum CodingKeys: String, CodingKey {
        case oembed
    }
}

struct Oembed: Codable {
    let thumbnail_url: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail_url = "thumbnail_url"
    }
}
