//
//  User+CoreDataClass.swift
//  Clubster
//
//  Created by Adam Barson on 10/22/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    public func setUsername(usernameIn : String){
        username = usernameIn
    }
    
    public func getUsername() -> String{
        return username!
    }
}
