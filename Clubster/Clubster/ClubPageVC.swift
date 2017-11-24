//
//  ClubPageVC.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit
import CoreData

    
class ClubPageVC: UIViewController {
    var clubID = String()
    var clubname: String = "Super Secret Club"
    var clubDescription: String = "Shhhhhhhh! This club is super secret!"
    var clubInfo: String = "www.super-secret-club.com"
    var bannerURL: URL!
    var subscribed: Bool!
    
    @IBOutlet weak var clubNameLabel: UILabel!
    
    @IBOutlet weak var clubImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentBody: UITextView!
    
    @IBOutlet weak var subButtonLabel: UIButton!
    
    @IBAction func clubTabBar(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentLabel.text = "Description"
            contentBody.text = self.clubDescription
        } else if sender.selectedSegmentIndex == 1 {
            contentLabel.text = "Info"
            contentBody.text = self.clubInfo
        }
    }
    
    @IBAction func toSettings(_ sender: Any) {
        // ! vs ? in the context:
        // ! will immediately assume the cast is valid, and will attempt
        // to downcast, throwing an exception if the cast is invalid
        // ? will try to cast, but will simply evaluate the variable to nil if the cast is invalid
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "SettingsPageController") as! SettingsPageController
        //nextVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)";
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func subscribeButton(_ sender: UIButton) {
        //TODO: Finish write this function.
        let myUsername = UserSingleton.sharedInstance.user!.getUsername()
        
        subButtonLabel.isEnabled = false
        
        HTTPRequestHandler.subscribe(username: myUsername, clubID: self.clubID) {
            (success, message) in
            if (success) {
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let entity =  NSEntityDescription.entity(forEntityName: "Club", in:managedContext)
                    
                    if (!self.subscribed!) {
                        let club = Club(entity: entity!, insertInto: managedContext)
                        club.club_code = self.clubID
                        club.name = self.clubname
                        UserSingleton.sharedInstance.user!.addToSubscriptions(club)
                        self.subButtonLabel.setTitle("Unsubscribe",for: .normal)
                        print("User \(myUsername) was successfully subscribed to club \(self.clubname).")
                    } else {
                        let club = UserSingleton.sharedInstance.user!.getClub(club_code: self.clubID)
                        UserSingleton.sharedInstance.user!.removeFromSubscriptions(club!)
                        self.subButtonLabel.setTitle("Subscribe", for: .normal)
                        print("User \(myUsername) was successfully unsubscribed from club \(self.clubname).")
                    }
                    self.subscribed = !(self.subscribed)
                }
                
            } else { //not success
                let m = message!
                print("Subscription request to \(self.clubname) was unsuccessful: \(m).")
            }
            DispatchQueue.main.async {
                self.subButtonLabel.isEnabled = true
                //UserSingleton.sharedInstance.user!.printClubs()
            }
            
        }
    }
    
    /*
    @IBAction func backToHomePage(_ sender: Any) {
        // ! vs ? in the context:
        // ! will immediately assume the cast is valid, and will attempt
        // to downcast, throwing an exception if the cast is invalid
        // ? will try to cast, but will simply evaluate the variable to nil if the cast is invalid
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "HomeVC") as! HomeVC
        //nextVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)";
        navigationController?.pushViewController(nextVC, animated: true)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true;
        // Do any additional setup after loading the view.
        clubNameLabel.text = clubname
        clubID = Configuration.REVERSE_CLUB_MAP[clubname]!
        
        if (UserSingleton.sharedInstance.user!.hasClub(club_code : self.clubID)){
            //print("User is subscribed to this club!")
            self.subscribed = true
            self.subButtonLabel.setTitle("Unsubscribe",for: .normal)
        } else {
            //print("User is not yet subscribed.")
            self.subscribed = false
            self.subButtonLabel.setTitle("Subscribe", for: .normal)
        }
        
        HTTPRequestHandler.getSingleClub(clubID: clubID) {
            ( clubname, clubDescription, clubInfo, bannerURL, success ) in
            if (success) {
                DispatchQueue.main.async {
                    //self.clubname = clubname!
                    self.clubDescription = clubDescription!
                    self.clubInfo = clubInfo!
                    self.bannerURL = bannerURL
                    
                    self.clubNameLabel.text = self.clubname
                    self.contentLabel.text = "Description"
                    self.contentBody.text = self.clubDescription
                }
                
            } else {
                print("Pretty bad error on the club page.")
            }
        }
        
        //TODO: Implement banner image functionality
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
