//
//  HomeUseCase.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Factory
import Combine

class HomeUseCase {
    var repo = Container.homeRepository

  func invoke(query: String) -> AnyPublisher<RedditResponse, RemoteError> {
      return repo.redditTop(query: query)
  }
}
