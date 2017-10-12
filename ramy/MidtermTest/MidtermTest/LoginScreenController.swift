//
//  LoginScreenController.swift
//  MidtermTest
//
//  Created by Adam Barson on 10/12/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class LoginScreenController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var passwordText: UILabel!
    
    @IBAction func loginAction(_ sender: Any) {
        
        let username = userNameField.text
        let password = passwordField.text
        
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
            passwordText.text = ""
            usernameText.text = ""
            let nextVC =
                storyboard?.instantiateViewController(withIdentifier:
                    "ViewController") as! ViewController
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            if (!userOk){
                usernameText.text = "Invalid"
                usernameText.textColor = UIColor.red
            } else {
                usernameText.text = ""
            }
            if (!passOk){
                passwordText.text = "Invalid"
                passwordText.textColor = UIColor.red
            } else {
                passwordText.text = ""
            }
        }
    }
    
    func checkUserName(username : String) -> Bool{
        return username == "admin"
    }
    
    func checkPassword(password : String) -> Bool{
        return password == "password"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.placeholder = "username"
        passwordField.placeholder = "password"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
