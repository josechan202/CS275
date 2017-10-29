//
//  SettingsPageController.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class SettingsPageController: UIViewController {

    //define stuff
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
            welcomeText.text = "Welcome" + (UserSingleton.sharedInstance.user?.getUsername())!
        }
        else
        {
            welcomeText.text = "Welcome Guest"
        }
        welcomeText.center = self.view.center
        
        //set buttons
        clubsIRunButton.layer.borderColor = UIColor.black.cgColor

        
        
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
