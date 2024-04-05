//
//  NetworkContainer.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Factory

extension Container {
    static var homeRepository: HomeRepository { HomeRepositoryImpl() }
}
