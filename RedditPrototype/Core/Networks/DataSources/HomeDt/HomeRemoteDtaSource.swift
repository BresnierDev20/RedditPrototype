//
//  HoemDtRemoteDataSource.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Combine
import Alamofire

protocol HomeRemoteDtaSource {
    func redditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError>
}
