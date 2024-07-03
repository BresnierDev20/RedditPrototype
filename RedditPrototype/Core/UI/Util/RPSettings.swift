//
//  RDSettings.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 3/7/24.
//

import UIKit

struct RPSettings {
    static var current: RPSettings = .init()
    
    let defaults = UserDefaults.standard
    let baseUrl = URLDomains.BASE
    
}
