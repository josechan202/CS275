//
//  UserSingleton.swift
//  Clubster
//
//  Created by Adam Barson on 10/20/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation

/**
 Represents a user's information during a given session.
 */
class UserSingleton {
    static let sharedInstance = UserSingleton()
    
    var user : User?
    
    private init(){
    
    }
    
    func setUser(userIn : User){
        user = userIn
    }
}
