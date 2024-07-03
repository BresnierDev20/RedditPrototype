//
//  HomeViewModel.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Factory
import Combine
import Alamofire

class HomeViewModel {
    var getHomeUseCase = Container.getHomeeUseCase
    var getAccessUseCase = Container.getAccessTokenUseCase
    
    var disposables : Set<AnyCancellable> = Set()
    
    @Published var cellNibName = "HomeTableViewCell"
    @Published var redditDt: [RedditChild] = []
    @Published var currentPage: Int = 1

    func getRedditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
         return getHomeUseCase.invoke(query: query)
    }
    
    func accessToken() -> AnyPublisher<Token, RemoteError> {
        return getAccessUseCase.invoke()
    }
}

