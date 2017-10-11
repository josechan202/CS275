//
//  ViewController.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var messageTextLabel: UILabel!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextBox.placeholder = "username"
        passwordTextBox.placeholder = "password"
        userNameTextBox.autocorrectionType = UITextAutocorrectionType.no
        passwordTextBox.autocorrectionType = UITextAutocorrectionType.no
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

