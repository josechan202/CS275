//
//  ClubPageVC.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

public class MyClub {
    var name: String
    var description: String
    var info: String
    
    init(name: String, description: String, info: String) {
        self.name = name
        self.description = description
        self.info = info
    }
}

var testClub = MyClub(name: "Super Secret Club", description: "Shhhhhhhh! This club is super secret!", info: "www.super-secret-club.com")

    
class ClubPageVC: UIViewController {
    
    var clubName : String?
    @IBOutlet weak var clubNameLabe: UILabel!
    
    @IBOutlet weak var clubImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentBody: UITextView!
    
    @IBAction func subscribeButton(_ sender: Any) {
    }
    
    @IBAction func clubTabBar(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentLabel.text = "Description"
            contentBody.text = testClub.description
        } else if sender.selectedSegmentIndex == 1 {
            contentLabel.text = "Info"
            contentBody.text = testClub.info
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
        //clubNameLabe.text = testClub.name
        clubNameLabe.text = clubName!
        contentLabel.text = "Description"
        contentBody.text = testClub.description
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
