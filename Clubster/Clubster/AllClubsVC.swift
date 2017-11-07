//
//  AllClubsVC.swift
//  Clubster
//
//  Created by Adam T. Barson on 11/7/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class AllClubsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Populate table with database info and display
    let list = Array(Configuration.CLUB_MAP.values)
    
    @IBOutlet weak var clubTable: UITableView!
    public func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    public func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let ClubName = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ClubName")
        ClubName.textLabel?.text = list[indexPath.row]
        return(ClubName)
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
        clubTable.delegate = self
        clubTable.dataSource = self
        
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
