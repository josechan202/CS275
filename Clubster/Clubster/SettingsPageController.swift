//
//  SettingsPageController.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class SettingsPageController: UIViewController {
    let numberOfButtons:Int = 5
    
    //define stuff for visuals
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var clubsIRunButton: UIButton!
    @IBOutlet weak var clubsImMemberButton: UIButton!
    @IBOutlet weak var nearbyEventsButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var myAccountButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background color. color provided in hex by UVM.
        self.view.backgroundColor = UIColor(red:0.00, green:0.33, blue:0.25, alpha:1.0)
        
        //set Hello message
        if((UserSingleton.sharedInstance.user?.getUsername()) != nil)
        {
            welcomeText.text = "Welcome, " + UserSingleton.sharedInstance.user!.getUsername()
        }
        else
        {
            welcomeText.text = "Welcome, Guest"
        }
        welcomeText.textAlignment = .center
        welcomeText.font = UIFont(name: "Chalkduster", size: 25)
        welcomeText.textColor = UIColor.white
        
        //set buttons
        let buttons = [clubsIRunButton, clubsImMemberButton, nearbyEventsButton, messagesButton, myAccountButton]
        for i in 0 ..< numberOfButtons
        {
            //buttons[i]?.layer.borderColor = UIColor.black.cgColor
           // buttons[i]?.layer.borderWidth = 2
            buttons[i]?.layer.cornerRadius = 5
            buttons[i]?.setTitleShadowColor(UIColor.gray, for: .highlighted)
            buttons[i]?.backgroundColor = UIColor(red:0.85, green:0.61, blue:0.07, alpha:1.0)
            buttons[i]?.setTitleColor(UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), for: .normal)

            
        }
        clubsIRunButton.setTitle("Clubs I Run", for: .normal)
        clubsIRunButton.setImage(UIImage(named: "images/settingsPage/clubsIRun.png"), for: .normal)
        
        clubsImMemberButton.layer.borderColor = UIColor.black.cgColor
        clubsImMemberButton.setTitle("Clubs I'm a member of", for: .normal)
        clubsImMemberButton.setImage(UIImage(named: "images/settingsPage/clubsImMember.png"), for: .normal)
        nearbyEventsButton.setTitle("Nearby Events", for: .normal)
        nearbyEventsButton.setImage(UIImage(named: "images/settingsPage/nearbyEvents.png"), for: .normal)
        messagesButton.setTitle("Messages", for: .normal)
        messagesButton.setImage(UIImage(named: "images/settingsPage/messages.png"), for: .normal)
        myAccountButton.setTitle("My Account", for: .normal)
        myAccountButton.setImage(UIImage(named: "images/settingsPage/myAccount.png"), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    //define button actions
    @IBAction func clubsIRunButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "clubsIRunVC") as! clubsIRunVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func clubsImMemberButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "clubsImMemberVC") as! clubsImMemberVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func nearbyEventsButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "nearbyEventsVC") as! nearbyEventsVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func messagesButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "messagesVC") as! messagesVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func myAccountButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "myAccountVC") as! myAccountVC
        navigationController?.pushViewController(nextVC, animated: true)
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
