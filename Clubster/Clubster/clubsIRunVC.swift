//
//  clubsIRunVC.swift
//  Clubster
//
//  Created by  on 10/29/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class clubsIRunVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var groupSize = 10
    var query = ""
    var lastGroup = false
    var myClubs = [TempClub]()
    let SgaEmail = "sga@uvm.edu"
    
    
    @IBOutlet weak var adminTable: UITableView!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactSgaButton: UIButton!

    @IBAction func contactSGA(_ sender: Any) {
        let url = URL(string: "mailto:\(SgaEmail)")
        UIApplication.shared.open(url!)
    }
    
    
    //  -------------
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        adminTable.delegate = self
        adminTable.dataSource = self
        searchBar.delegate = self
        
        // Reset parameters
        self.query = ""
        searchBar.text = self.query
        self.myClubs.removeAll()
        
        
        // Since we just reset the above parameters, this function will return the first 10 results of ALL the clubs in the db.
        HTTPRequestHandler.searchClubs(startIndex: 0, groupSize: self.groupSize, rawQuery: self.query) {
            (lastGroup, results) in
            self.lastGroup = lastGroup
            self.myClubs.removeAll()
            for aClub in results {
                let clubObj = aClub as! [String : Any]
                let club = TempClub(name: clubObj["clubname"] as! String, club_code: clubObj["club_id"] as! String)
                
                // We don't strictly need to do this part here, but migth as well.
                if (UserSingleton.sharedInstance.user!.hasClub(club_code : club.club_code!)){
                    club.subbed = true
                } else {
                    //print("User is not yet subscribed.")
                    club.subbed = false
                }
                self.myClubs.append(club)
            }
            DispatchQueue.main.async {
                self.adminTable.reloadData()
            }
        }
    }
    
    //  --------------
    
    
    // Gimme a count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClubs.count
    }
    
    // Defines what each cell does
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let admin_cell = tableView.dequeueReusableCell(withIdentifier: "admin_cell", for: indexPath) as! AdminCell
        
        admin_cell.clubName.text = myClubs[indexPath.row].name!
        
        admin_cell.editClub.tag = indexPath.row
        admin_cell.editClub.addTarget(self, action: #selector(self.toEditClub), for: UIControlEvents.touchUpInside)
        
        admin_cell.newMessage.tag = indexPath.row
        admin_cell.newMessage.addTarget(self, action: #selector(self.toNewMessage), for: UIControlEvents.touchUpInside)

        
        return(admin_cell)
    }
    
    // For scrolling pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = myClubs.count - 1
        if indexPath.row == lastItem {
            if !self.lastGroup {
                self.loadMoreData()
            }
        }
    }
    
    func toEditClub(_ sender: UIButton) {
        
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "EditClubVC") as! EditClubVC
        nextVC.clubname = myClubs[sender.tag].name!
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func toNewMessage(_ sender: UIButton) {
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "messagesVC") as! messagesVC
        nextVC.clubname = myClubs[sender.tag].name!
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    // New search every time they type
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query = searchBar.text!
        HTTPRequestHandler.searchClubs(startIndex: 0, groupSize: self.groupSize, rawQuery: self.query) {
            (lastGroup, results) in
            self.lastGroup = lastGroup
            self.myClubs.removeAll()
            for aClub in results {
                let clubObj = aClub as! [String : Any]
                let club = TempClub(name: clubObj["clubname"] as! String, club_code: clubObj["club_id"] as! String)
                if (UserSingleton.sharedInstance.user!.hasClub(club_code : club.club_code!)){
                    club.subbed = true
                } else {
                    //print("User is not yet subscribed.")
                    club.subbed = false
                }
                self.myClubs.append(club)
            }
            DispatchQueue.main.async {
                self.adminTable.reloadData()
            }
        }
    }
    
    func loadMoreData() {
        HTTPRequestHandler.searchClubs(startIndex: myClubs.count, groupSize: self.groupSize, rawQuery: self.query) {
            (lastGroup, results) in
            self.lastGroup = lastGroup
            for aClub in results {
                let clubObj = aClub as! [String : Any]
                let club = TempClub(name: clubObj["clubname"] as! String, club_code: clubObj["club_id"] as! String)
                if (UserSingleton.sharedInstance.user!.hasClub(club_code : club.club_code!)){
                    club.subbed = true
                } else {
                    //print("User is not yet subscribed.")
                    club.subbed = false
                }
                self.myClubs.append(club)
            }
            DispatchQueue.main.async {
                self.adminTable.reloadData()
            }
        }
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
