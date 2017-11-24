//
//  AllClubsVC.swift
//  Clubster
//
//  Created by Adam T. Barson on 11/7/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class AllClubsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //Populate table with database info and display
    //let list = Array(Configuration.CLUB_MAP.values)
    
    var groupSize = 10
    
    var query = ""
    
    var lastGroup = false
    
    var myClubs = [TempClub]()
    
    
    @IBOutlet weak var clubTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    public func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(myClubs.count)
    }
    
    // Defines what each cell does
    public func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let clubCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "clubCell")
        clubCell.textLabel?.text = myClubs[indexPath.row].name
        return(clubCell)
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
    
    // For if they click on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row selected: " + myClubs[indexPath.row].name!)
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "ClubPageVC") as! ClubPageVC
        nextVC.clubname = myClubs[indexPath.row].name!
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
                self.clubTable.reloadData()
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
                self.clubTable.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTable.delegate = self
        clubTable.dataSource = self
        searchBar.delegate = self
        
        // Reset search parameters just in c
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
                if (UserSingleton.sharedInstance.user!.hasClub(club_code : club.club_code!)){
                    club.subbed = true
                } else {
                    //print("User is not yet subscribed.")
                    club.subbed = false
                }
                self.myClubs.append(club)
            }
            DispatchQueue.main.async {
                self.clubTable.reloadData()
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
