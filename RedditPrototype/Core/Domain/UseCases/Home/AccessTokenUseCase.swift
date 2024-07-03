//
//  AccessTokenUseCase.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 2/7/24.
//

import Factory
import Combine

class AccessTokenUseCase {
    var repo = Container.homeRepository

  func invoke() -> AnyPublisher<Token, RemoteError> {
      return repo.accessToken()
  }
}
