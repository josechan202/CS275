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
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/clubexample.php")
        
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
    
    public class func makeGetRequest(successHandler: @escaping (_ response: String) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/example.php?net_id=abarson")
        
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
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/login.php")!
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
    
    
    public class func getSingleClub(clubID : Int, successHandler: @escaping (_ clubname : String?, _ clubDescription: String?, _ clubInfo: String?, _ bannerURL: URL?, _ success: Bool) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/club.php?club_id=\(clubID)")!
        
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
    
    public class func subscribe(username : String, clubID : Int, isSubbing: Bool,
                                successHandler: @escaping (_ mode: Bool?, _ success: Bool) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/subscribe.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let parameterDictionary = ["username" : username, "clubID" : String(clubID), "isSubbing" : String(isSubbing)]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        print(request)
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
                    
                    successHandler(isSubbing, true)
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

    
    public class func signUp(username: String?, password : String?,
                             successHandler : @escaping (_ success : Bool, _ message : String?) -> Void) -> Void {
        let url = URL(string: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/signup.php")!
        
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
    
    private init(){}
}
