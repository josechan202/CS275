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
        
        //set buttons
        let buttons = [clubsIRunButton, clubsImMemberButton, nearbyEventsButton, messagesButton, myAccountButton]
        for i in 0 ..< numberOfButtons
        {
            buttons[i]?.layer.borderColor = UIColor.black.cgColor
            buttons[i]?.layer.borderWidth = 2
            buttons[i]?.layer.cornerRadius = 5
            buttons[i]?.setTitleShadowColor(UIColor.gray, for: .highlighted)
            
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
    
    func changeButtonView(_ button:UIButton!){
        if (button?.layer.borderWidth == 2)
        {
            button.layer.borderWidth = 8
        }
        else
        {
            button.layer.borderWidth = 2
        }
    }
    
    //define button actions
    @IBAction func clubsIRunButton(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "clubsIRunVC") as! clubsIRunVC
        navigationController?.pushViewController(nextVC, animated: true)
        changeButtonView(clubsIRunButton)
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
