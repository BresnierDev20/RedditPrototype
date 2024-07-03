//
//  Helper.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 3/7/24.
//

import UIKit

struct Helper {
    static func getUserToken() -> String {
        let defaults = RPSettings.current.defaults
        
        return defaults.string(forKey: "token") ?? ""
    }
    
    static func setUserToken(_ model: String?) {
        let defaults = RPSettings.current.defaults
        
        defaults.set(model, forKey: "token")
    }
}
