//
//  messagesVC.swift
//  Clubster
//
//  Created by  on 10/29/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class messagesVC: UIViewController {
    var clubname: String?
    
    @IBOutlet weak var clubLabel: UILabel!

    @IBOutlet weak var clubNameHere: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageBody: UITextView!
    
    @IBAction func publishButton(_ sender: Any) {
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
