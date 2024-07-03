//
//  Token.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 2/7/24.
//

import Foundation

struct Token: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    
    enum CodingKeys: String, CodingKey {
        case expires_in
        case access_token
        case token_type
    }
}
