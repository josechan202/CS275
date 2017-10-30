//
//  clubsIRunVC.swift
//  Clubster
//
//  Created by  on 10/29/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class clubsIRunVC: UIViewController, UITableViewDataSource {
    
    var clubAdminStrings = [String]()
    let SgaEmail = "sga@uvm.edu"
    
    @IBOutlet weak var pageLabel: UILabel!

    @IBOutlet weak var adminTable: UITableView!
    
    @IBOutlet weak var contactSgaButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initalize page label
        pageLabel.text = "Clubs I Run"
        pageLabel.center.x = self.view.center.x
        
        //initialize table
        adminTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        adminTable.dataSource = self
        
        //SORROUND WITH IF
        //check user singleton for admin status, following is if no admin status
        adminTable.separatorStyle = .none
        clubAdminStrings.append("go to the gym, you dont run any")
        contactSgaButton.setTitle("Contact SGA", for: .normal)
        

        // Do any additional setup after loading the view.
    }
    
    //this button does not work in the simulator, mail app only on real device
    @IBAction func contactSGA(_ sender: Any) {
        let url = URL(string: "mailto:\(SgaEmail)")
        UIApplication.shared.open(url!)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return clubAdminStrings.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = clubAdminStrings[indexPath.row]
        
        return cell!
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
