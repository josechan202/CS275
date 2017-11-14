//
//  ClubPageVC.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

    
class ClubPageVC: UIViewController {
    var clubID = Int()
    var clubname: String = "Super Secret Club"
    var clubDescription: String = "Shhhhhhhh! This club is super secret!"
    var clubInfo: String = "www.super-secret-club.com"
    var bannerURL: URL!
    
    
    @IBOutlet weak var clubNameLabe: UILabel!
    
    @IBOutlet weak var clubImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentBody: UITextView!
    
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
        //TODO: Write this function.
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

        // Do any additional setup after loading the view.
        clubNameLabe.text = clubname
        clubID = Int(Configuration.REVERSE_CLUB_MAP[clubname]!)!
        
        HTTPRequestHandler.getSingleClub(clubID: clubID) {
            ( clubname, clubDescription, clubInfo, bannerURL, success ) in
            if (success) {
                DispatchQueue.main.async {
                    //self.clubname = clubname!
                    self.clubDescription = clubDescription!
                    self.clubInfo = clubInfo!
                    self.bannerURL = bannerURL
                    
                    self.clubNameLabe.text = self.clubname
                    self.contentLabel.text = "Description"
                    self.contentBody.text = self.clubDescription
                }
                
            } else {
                print("Pretty bad error on the club page.")
            }
        }
        
        //TODO: Implement banner image functionality
        //TODO: set subscribe button label.
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
