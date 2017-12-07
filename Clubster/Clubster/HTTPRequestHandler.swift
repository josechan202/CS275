//
//  HTTPRequestHandler.swift
//  Clubster
//
//  Created by Adam Barson on 10/22/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation

public class HTTPRequestHandler {
    
    public class func getClubs(successHandler: @escaping (_ response: NSArray) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~abarson/rest/clubexample.php")
        
        var end = ""
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let explanation = json["clubs"] as? NSArray {
                        //print(explanation)
                        //end = explanation as! String
                        successHandler(explanation)
                    } else {
                        end = "Failed to load"
                        print("not serialized")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public class func searchClubs(startIndex: Int, groupSize: Int, rawQuery: String, successHandler: @escaping (_ lastGroup: Bool,_ response: NSArray) -> Void)->Void {
        let query: String = rawQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/search_clubs.py?startIndex=\(startIndex)&groupSize=\(groupSize)&query=\(query)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let results = json["clubs"] as? NSArray {
                        let lastGroup = json["lastGroup"] as! Bool
                        print(results)
                        //end = explanation as! String
                        successHandler(lastGroup, results)
                    } else {
                        print("not serialized")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public class func searchAdminClubs(username: String, startIndex: Int, groupSize: Int, rawQuery: String, successHandler: @escaping (_ lastGroup: Bool,_ response: NSArray) -> Void)->Void {
        let query: String = rawQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/admin_clubs.py?username=\(username)&startIndex=\(startIndex)&groupSize=\(groupSize)&query=\(query)")
        
        print("searchAdminClubs: requested url = https://\(Constants.ZOO_NAME).w3.uvm.edu/admin_clubs.py?username=\(username)&startIndex=\(startIndex)&groupSize=\(groupSize)&query=\(query)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let results = json["clubs"] as? NSArray {
                        let lastGroup = json["lastGroup"] as! Bool
                        print(results)
                        //end = explanation as! String
                        successHandler(lastGroup, results)
                    } else {
                        print("not serialized")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public class func getPosts(username: String, startIndex: Int, groupSize: Int, subsOnly: Bool, currentTime: String, successHandler: @escaping (_ lastGroup: Bool,_ response: NSArray) -> Void)->Void {

        let timestamp: String = currentTime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/fetch_notifications.py?time=\(timestamp)&startIndex=\(startIndex)&groupSize=\(groupSize)&username=\(username)&subsOnly=\(subsOnly)")
        
        print("getPosts: requested url = https://\(Constants.ZOO_NAME).w3.uvm.edu/fetch_notifications.py?time=\(timestamp)&startIndex=\(startIndex)&groupSize=\(groupSize)&username=\(username)&subsOnly=\(subsOnly)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let results = json["notifications"] as? NSArray {
                        let lastGroup = json["lastGroup"] as! Bool
                        print(results)
                        //end = explanation as! String
                        successHandler(lastGroup, results)
                    } else {
                        print("not serialized")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    public class func addPost(username : String, clubname: String, messageString: String,
                                successHandler: @escaping (_ success: Bool, _ message: String?) -> Void)->Void {
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/add_post.py")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["username" : username, "clubname" : clubname, "message" : messageString]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        print("request = \(parameterDictionary)")
        
        request.httpBody = httpBody
        //print("request = \(request.httpBody)\n")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("json response     = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                print ("the json     = \(String(describing: jsonSerialized))")
                if let json = jsonSerialized, json["success"] as! Bool{
                    print("Successfully Changed \(username)'s post for status to club \(clubname) ")
                    
                    successHandler(true, json["message"] as! String)
                } else {
                    successHandler(false, "not serialized")
                    
                }
            }  catch let error as NSError {
                successHandler(false, error as! String)
            }
            
            
            
        }
        
        task.resume()
    }
    
    public class func makeGetRequest(successHandler: @escaping (_ response: String) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~abarson/rest/example.php?net_id=abarson")
        
        var end = ""
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let explanation = json["student"] {
                        print(explanation)
                        end = explanation as! String
                    } else {
                        end = "Failed to load"
                        print("not serialized")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            successHandler(end)
        }
        task.resume()
    }
    
    public class func login(username : String?, password : String?,
                            successHandler: @escaping (_ clubList : [String]?, _ success: Bool) -> Void)->Void {
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/login.py")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["username" : username, "password" : password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("json response     = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, json["success"] as! Bool{
                    print("Successfully logged in " + username!)
                    
                    successHandler(json["clubs"] as! [String], true)
                } else {
                    print("not serialized")
                    successHandler(nil, false)
                    
                }
            }  catch let error as NSError {
                print(response)
                successHandler(nil, false)
            }
            
            
            
        }
        
        task.resume()
    }
    
    
    public class func getSingleClub(clubID : String, successHandler: @escaping (_ clubname : String?, _ clubDescription: String?, _ clubInfo: String?, _ bannerURL: URL?, _ success: Bool) -> Void)->Void {
        let url = URL(string: "https://\(Constants.ZOO_NAME).w3.uvm.edu/get_club_info.py?club_id=\(clubID)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, json["success"] as! Bool{
                    print("Successfully retrieved club page data for clubID = \(clubID)")
                    
                    successHandler(json["clubname"] as! String, json["clubDescription"] as! String, json["clubInfo"] as! String, json["bannerURL"] as? URL, true)
                } else {
                    print("not serialized")
                    successHandler(nil, nil, nil, nil, false)
                    
                }
            }  catch let error as NSError {
                print(response)
                successHandler(nil, nil, nil, nil, false)
            }
            
            
            
        }
        
        task.resume()
    }
    
    public class func subscribe(username : String, clubID : String,
                                successHandler: @escaping (_ success: Bool, _ message: String?) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~abarson/rest/subscribe.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["username" : username, "clubID" : clubID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        print("request = \(request.httpBody)\n")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("json response     = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, json["success"] as! Bool{
                    print("Successfully Changed \(username)'s subscription status to clubID = \(clubID) ")
                    
                    successHandler(true, json["message"] as! String)
                } else {
                    successHandler(false, "not serialized")
                    
                }
            }  catch let error as NSError {
                successHandler(false, error as! String)
            }
            
            
            
        }
        
        task.resume()
    }

    
    public class func signUp(username: String?, password : String?,
                             successHandler : @escaping (_ success : Bool, _ message : String?) -> Void) -> Void {
        let url = URL(string: "https://www.uvm.edu/~abarson/rest/signup.php")!
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["username" : username, "password" : password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let success = json["success"] as? Bool {
                    if (success){
                        print("Successfully signed up " + username!)
                        successHandler(true, nil)
                    } else {
                        let message = json["message"] as! String
                        print("Problem signing up " + username! + ": " + message)
                        successHandler(false, message)
                    }
                } else {
                    print("not serialized")
                    successHandler(false, nil)
                    
                }
            }  catch let error as NSError {
                print(response)
                successHandler(false, nil)
            }
            
            
            
        }
        
        task.resume()
    }
    
    public class func appleToken(appleTokenIn: String, username: String,
                             successHandler : @escaping (_ success : Bool, _ message : String?) -> Void) -> Void {
        let url = URL(string: "https://rkoudsi.w3.uvm.edu/apple_token.py")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["appleToken": appleTokenIn, "username": username]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        print("inside HTTPReq... appleToken(...)")
        
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString!)")
            
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let success = json["success"] as? Bool {
                    if (success){
                        print("Token added")
                        successHandler(true, nil)
                    } else {
                        let message = json["message"] as! String
                        print("Token not added.")
                        successHandler(false, message)
                    }
                } else {
                    print("not serialized")
                    successHandler(false, nil)
                    
                }
            }  catch let error as NSError {
                print(response)
                successHandler(false, nil)
            }
            
            
            
        }
        
        task.resume()
    }
    
    private init(){}
}
