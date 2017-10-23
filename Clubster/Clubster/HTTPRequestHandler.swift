//
//  HTTPRequestHandler.swift
//  Clubster
//
//  Created by Adam Barson on 10/22/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation

public class HTTPRequestHandler {
    
    
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
    
    public class func login(username : String, password : String,
                                      successHandler: @escaping (_ response: String) -> Void)->Void {
        let url = URL(string: "https://www.uvm.edu/~abarson/rest/login.php")!
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
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let explanation = json["clubs"] {
                    print(explanation)
                } else {
                    print("not serialized")
                }
            }  catch let error as NSError {
                print(error.localizedDescription)
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString!)")
        }
        
        task.resume()
    }
    
    private init(){}
}
