//
//  GeneralRoute.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case home
    case detail
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .home:
            return HomeViewController()
        case .detail:
            return DetailViewController()
        }
    }
}
