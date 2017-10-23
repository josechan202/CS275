//
//  ViewController.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var apiCallTest: UILabel!
    
    @objc var users = [User]()
    
    @IBAction func changeScreen(_ sender: Any) {
        let username = userNameTextBox.text
        let password = passwordTextBox.text
        
        var userOk : Bool
        if let user = username{
            userOk = checkUserName(username: user)
        } else {
            userOk = false
        }
        
        var passOk : Bool
        if let password = password{
            passOk = checkPassword(password: password)
        } else {
            passOk = false
        }
        
        if (passOk && userOk){
            saveName(username!)
            print("Saving " + username!)
            messageTextLabel.text = username! + password!
            let nextVC =
                storyboard?.instantiateViewController(withIdentifier:
                    "HomeVC") as! HomeVC
            //nextVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)";
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            messageTextLabel.text = "Invalid username or password"
        }
        
        // ! vs ? in the context:
        // ! will immediately assume the cast is valid, and will attempt
        // to downcast, throwing an exception if the cast is invalid
        // ? will try to cast, but will simply evaluate the variable to nil if the cast is invalid
    }
    
    func checkUserName(username : String) -> Bool{
        return username == "Adam"
    }
    
    func checkPassword(password : String) -> Bool{
        return password == "password"
    }
    
    @objc func saveName(_ user_code: String)
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User", in:managedContext)
        let user = User(entity: entity!, insertInto: managedContext)
        
        user.user_code = user_code
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getUserData(){
        let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            
            users = results
            
            if (true)
            {
                for u in users
                {
                    for c in u.subscriptions!
                    {
                        managedContext.delete(c as! Club)
                    }
                    managedContext.delete(u)
                }
                try managedContext.save()
            }
            else
            {
                for u in users
                {
                    users.append(u)
                    for c in u.subscriptions!
                    {
                        
                    }
                    print(u.user_code!)
                }
                
            }
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
        
        print(users.count)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUserData()
        HTTPRequestHandler.makeGetRequest(successHandler: {
            (response) in
            self.apiCallTest.text = response;
        })
        userNameTextBox.placeholder = "username"
        passwordTextBox.placeholder = "password"
        userNameTextBox.autocorrectionType = UITextAutocorrectionType.no
        passwordTextBox.autocorrectionType = UITextAutocorrectionType.no
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

