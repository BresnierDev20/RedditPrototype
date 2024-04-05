//
//  HomeRepositoryImpl.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Combine
import Alamofire
import Factory

class HomeRepositoryImpl: HomeRepository {
    var remote = Container.HomeRemoteDataSource
    
    func redditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
        return remote.redditTop(query: query)
    }

}
