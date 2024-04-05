//
//  HomeViewModel.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Factory
import Combine
import Alamofire

protocol HomeService {
    func getRedditTop(query: String)
}

class HomeViewModel {
    var getHomeUseCase = Container.getHomeeUseCase
    var disposables : Set<AnyCancellable> = Set()
    
    @Published var cellNibName = "HomeTableViewCell"
    @Published var redditDt: [RedditChild] = []
    @Published var currentPage: Int = 1
    
    init(getHomeUseCase: HomeUseCase = Container.getHomeeUseCase) {
        self.getHomeUseCase = getHomeUseCase
    }

    func getRedditTop(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
         return  getHomeUseCase.invoke(query: query)
           
    }
    
}

