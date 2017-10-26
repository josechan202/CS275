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
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var apiCallTest: UILabel!
    
    @objc var users = [User]()
    @IBOutlet var loginImg: UIImageView!
    
    
    
    
    @IBAction func changeScreen(_ sender: Any) {
        let username = userNameTextBox.text
        let password = passwordTextBox.text
        
        loginButton.isEnabled = false
        
        HTTPRequestHandler.login(username: username!, password: password!) {
            ( clubList, success ) in
            if (success){
                let appDelegate =
                    UIApplication.shared.delegate as! AppDelegate
                
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity =  NSEntityDescription.entity(forEntityName: "User", in:managedContext)
                let user = User(entity: entity!, insertInto: managedContext)
                user.username = username
                
                for club_id in clubList!{
                    let club_name = Configuration.CLUB_MAP[club_id]
                    let entity =  NSEntityDescription.entity(forEntityName: "Club", in:managedContext)
                    let club = Club(entity: entity!, insertInto: managedContext)
                    club.club_code = club_id
                    club.name = club_name
                    print(club_name!)
                    user.addToSubscriptions(club)
                }
                
                UserSingleton.sharedInstance.setUser(userIn: user)
                
                DispatchQueue.main.async {
                    self.toHome()
                    self.loginButton.isEnabled = true
                }
            } else {
                DispatchQueue.main.async {
                    self.loginButton.isEnabled = true
                    self.messageTextLabel.text = "Invalid username or password";
                }
                
            }
        }
        /*
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
        */
        // ! vs ? in the context:
        // ! will immediately assume the cast is valid, and will attempt
        // to downcast, throwing an exception if the cast is invalid
        // ? will try to cast, but will simply evaluate the variable to nil if the cast is invalid
    }
    
    func toHome(){
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //Not doing anything
    @objc func saveName(_ username: String)
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User", in:managedContext)
        let user = User(entity: entity!, insertInto: managedContext)
        
        user.username = username
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    //Not doing anything at the moment
    /**
     Load the user's data from core data, if it exists.
    */
    func getUserData(){
        let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
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
                    print(u.username!)
                }
                
            }
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
        
        print(users.count)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //getUserData()
        HTTPRequestHandler.makeGetRequest(successHandler: {
            (response) in
            self.apiCallTest.text = response;
        })
        */
        userNameTextBox.placeholder = "username"
        passwordTextBox.placeholder = "password"
        userNameTextBox.autocorrectionType = UITextAutocorrectionType.no
        passwordTextBox.autocorrectionType = UITextAutocorrectionType.no
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

