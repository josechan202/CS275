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
    
    
    @IBAction func toSignUp(_ sender: Any) {
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "SignUpVC") as! SignUpVC
        self.navigationController?.setNavigationBarHidden(false, animated:    true)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func changeScreen(_ sender: Any) {
        let username = userNameTextBox.text
        let password = passwordTextBox.text
        
        
        loginButton.isEnabled = false
        
        HTTPRequestHandler.login(username: username!, password: password!) {
            ( clubList, success ) in
            if (success){
                DispatchQueue.main.async {
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
                        //print(club_name!)
                        user.addToSubscriptions(club)
                    }
                
                    UserSingleton.sharedInstance.setUser(userIn: user)
                
                    //only after login can we associate this app on this phone with this user
                    Notifications.updateDBwithAppleToken()
                
                    self.toHome()
                    
                    //self.loginButton.isEnabled = true
                    do {
                        try managedContext.save()
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.loginButton.isEnabled = true
                    self.messageTextLabel.text = "Invalid username or password";
                }
                
            }
        }
    }
    
    func toHome(){
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "CustomTabBarController")
        
        
        appDelegate.window?.rootViewController = nextVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.setHidesBackButton(true, animated: false)
        
        userNameTextBox.autocorrectionType = UITextAutocorrectionType.no
        passwordTextBox.autocorrectionType = UITextAutocorrectionType.no
        
        
        //to move window up when keyboard comes up
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:    animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

