//
//  SettingsPageController.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class SettingsPageController: UIViewController {

    //define stuff for visuals
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var clubsIRunButton: UIButton!
    @IBOutlet weak var clubsImMemberButton: UIButton!
    @IBOutlet weak var nearbyEventsButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var myAccountButton: UIButton!
    
    //define button actions
    @IBAction func clubsIRunButton(_ sender: Any) {
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func clubsImMemberButton(_ sender: Any) {
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func nearbyEventsButton(_ sender: Any) {
    }
    @IBAction func messagesButton(_ sender: Any) {
    }
    @IBAction func myAccountButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set Hello message
        if((UserSingleton.sharedInstance.user?.getUsername()) != nil)
        {
            welcomeText.text = "Welcome" + UserSingleton.sharedInstance.user!.getUsername()
        }
        else
        {
            welcomeText.text = "Welcome Guest"
        }
        welcomeText.center = self.view.center
        
        //set buttons
        clubsIRunButton.layer.borderColor = UIColor.black.cgColor
        clubsIRunButton.setTitle("Clubs I Run", for: .normal)
        clubsIRunButton.setImage(UIImage(named: "images/settingsPage/clubsIRun.png"), for: .normal)
        clubsImMemberButton.layer.borderColor = UIColor.black.cgColor
        clubsImMemberButton.setTitle("Clubs I'm a member of", for: .normal)
        clubsImMemberButton.setImage(UIImage(named: "images/settingsPage/clubsImMember.png"), for: .normal)
        nearbyEventsButton.layer.borderColor = UIColor.black.cgColor
        nearbyEventsButton.setTitle("Nearby Events", for: .normal)
        nearbyEventsButton.setImage(UIImage(named: "images/settingsPage/nearbyEvents.png"), for: .normal)
        messagesButton.layer.borderColor = UIColor.black.cgColor
        messagesButton.setTitle("Messages", for: .normal)
        messagesButton.setImage(UIImage(named: "images/settingsPage/messages.png"), for: .normal)
        myAccountButton.layer.borderColor = UIColor.black.cgColor
        myAccountButton.setTitle("my text here", for: .normal)
        myAccountButton.setImage(UIImage(named: "images/settingsPage/myAccount.png"), for: .normal)
        
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
