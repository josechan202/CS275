//
//  Notifications.swift
//  Clubster
//
//  Created by  on 12/7/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit
import UserNotifications

public class Notifications {
    
    public static var appleToken: String?
    
    public static func updateDBwithAppleToken()
    {
        
        //sanity check. runs if user didnt allow notifications
        if((appleToken ?? "").isEmpty){
            return
        }
        
        let username = UserSingleton.sharedInstance.user!.getUsername()
        
        HTTPRequestHandler.appleToken(appleTokenIn: "testID", username: username) {
            (success, message) in
            if (success) {
                print (message)
                
            } else { //not success
                print (message)
            }
        }
    }
}
