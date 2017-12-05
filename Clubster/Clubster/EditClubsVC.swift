//
//  EditClubsVC.swift
//  Clubster
//
//  Created by Jack Frederick Hurley on 12/5/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class EditClubsVC: UIViewController {
    
    var clubname: String?
    
    
    @IBOutlet weak var pageLabel: UILabel!

    @IBOutlet weak var clubNameLabel: UILabel!
    
    @IBOutlet weak var clubNameField: UITextField!
    
    @IBOutlet weak var bannerLabel: UILabel!
    
    @IBOutlet weak var bannerField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var infoField: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submit(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
