//
//  messagesVC.swift
//  Clubster
//
//  Created by  on 10/29/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class messagesVC: UIViewController, UITextViewDelegate {
    
    var clubname: String?
    
    var placeholderLabel : UILabel!
    
    @IBOutlet weak var clubLabel: UILabel!

    @IBOutlet weak var clubNameHere: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageBody: UITextView!
    
    @IBOutlet weak var responseMessage: UILabel!
    
    @IBAction func publishButton(_ sender: Any) {
        let myUsername = UserSingleton.sharedInstance.user!.getUsername()
        
        HTTPRequestHandler.addPost(username: myUsername, clubname: self.clubname!, messageString: self.messageBody.text) {
            (success, message) in
            DispatchQueue.main.async {
            self.responseMessage.text = message
            self.responseMessage.isHidden = false
                if (success) {
                    self.messageBody.text = ""
                    self.responseMessage.textColor = UIColor(red: CGFloat(0.462), green: CGFloat(0.721), blue: CGFloat(0.509), alpha: CGFloat(1.0))
                } else {
                    self.responseMessage.textColor = UIColor(red: CGFloat(0.847), green: CGFloat(0.380), blue: CGFloat(0.337), alpha: CGFloat(1.0))
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBody.delegate = self
        
        self.clubNameHere.text = self.clubname!
        self.responseMessage.isHidden = true
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Type your message here."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (messageBody.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        messageBody.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (messageBody.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !messageBody.text.isEmpty
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //to move window up when keyboard comes up
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !messageBody.text.isEmpty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height)/3
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += (keyboardSize.height)/3
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
