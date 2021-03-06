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
    
    public func hasClub(club_code : String) -> Bool {
        for i in subscriptions! {
            if (club_code == (i as! Club).club_code!) {
                return true
            }
        }
        return false
    }
    
    public func getClub(club_code: String) -> Club? {
        for i in subscriptions! {
            if (club_code == (i as! Club).club_code!) {
                return i as! Club
            }
        }
        return nil
    }
    
    public func printClubs() {
        for i in subscriptions! {
            print((i as! Club).name!)
        }
    }
}
