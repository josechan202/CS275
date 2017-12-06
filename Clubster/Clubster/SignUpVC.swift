//
//  SignUpVC.swift
//  Clubster
//
//  Created by Adam T. Barson on 10/30/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit
import CoreData
class SignUpVC: UIViewController {

    let USERNAME_WRONG : String = "Invalid username"
    let USERNAME_TAKEN : String = "Username taken"
    let PASSWORD_INV   : String = "Password invalid"
    let CON_PASS_INV   : String = "Passwords different"
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var usernameFeedback: UILabel!
    @IBOutlet weak var passwordFeedback: UILabel!
    @IBOutlet weak var confirmPasswordFeedback: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUp(_ sender: Any) {
        usernameFeedback.text = ""
        passwordFeedback.text = ""
        confirmPasswordFeedback.text = ""
        
        let username = usernameField.text
        let password = passwordField.text
        let confpass = confirmPasswordField.text
        
        if (checkUsernameAndPassword(username: username, password: password, confirmPass: confpass)){
            var success : Bool?
            var message : String?
            
            
            signUpButton.isEnabled = false
            HTTPRequestHandler.signUp(username: username, password: password, successHandler:
                { (success, message) in
                    if (success){
                        let appDelegate =
                            UIApplication.shared.delegate as! AppDelegate
                        
                        let managedContext = appDelegate.persistentContainer.viewContext
                        let entity =  NSEntityDescription.entity(forEntityName: "User", in:managedContext)
                        let user = User(entity: entity!, insertInto: managedContext)
                        user.username = username
                        
                        UserSingleton.sharedInstance.setUser(userIn: user)
                        
                        DispatchQueue.main.async {
                            self.toHome()
                            self.signUpButton.isEnabled = true
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            self.signUpButton.isEnabled = true
                            self.usernameFeedback.text = message!
                        }
                    }
            })
        }
    }
    
    func checkUsernameAndPassword(username : String?, password: String?, confirmPass: String?) -> Bool {
        
        
        var usernameOk = false
        var passwordOk = false
        
        if username != "" {
            usernameOk = true
        } else {
            usernameOk = false
            usernameFeedback.text = USERNAME_WRONG
        }
        
        if password != "" {
            if (password == confirmPass){
                passwordOk = true
            } else {
                confirmPasswordFeedback.text = CON_PASS_INV
            }
        } else {
            passwordOk = false
            passwordFeedback.text = PASSWORD_INV
        }
        
        return passwordOk && usernameOk
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
        usernameField.placeholder = "username"
        usernameField.autocorrectionType = UITextAutocorrectionType.no
        passwordField.placeholder = "password"
        passwordField.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordField.placeholder = "confirm pass"
        confirmPasswordField.autocorrectionType = UITextAutocorrectionType.no
        
        usernameFeedback.font = UIFont.init(name: "arial", size: 10)
        usernameFeedback.textColor = UIColor.red
        
        passwordFeedback.font = UIFont.init(name: "arial", size: 10)
        passwordFeedback.textColor = UIColor.red
        
        confirmPasswordFeedback.font = UIFont.init(name: "arial", size: 10)
        confirmPasswordFeedback.textColor = UIColor.red
        
        //to move window up when keyboard comes up
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
